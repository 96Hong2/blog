package com.hong.blog.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hong.blog.dao.BoardDAO;
import com.hong.blog.dto.BoardDTO;

@Service
public class BoardService {

	@Autowired BoardDAO dao;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public ArrayList<BoardDTO> getPostList() {
		return dao.getPostList();
	}

	public HashMap<String, Object> delPost(ArrayList<Integer> delList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = dao.delPost(delList);
		logger.info("success : {}",success);
		map.put("success", success);
		return map;
	}

	public String write(RedirectAttributes rAttr, HashMap<String, String> param) {
		String msg = "게시글 작성에 실패했습니다.";
		String page = "redirect:/list";
		
		BoardDTO dto = new BoardDTO();
		dto.setTitle(param.get("title"));
		dto.setUserId(param.get("userId"));
		dto.setPostContent(param.get("content"));
		logger.info("title/userId/content : "+dto.getTitle()+"/"+dto.getUserId()+"/"+dto.getPostContent());
		
		int success = dao.write(dto);
		logger.info("success/postId : "+ success+" / "+dto.getPostId());
		if(success > 0) {
			msg = "게시글 작성이 완료되었습니다.";
			page = "redirect:/detail?postId="+dto.getPostId(); 
		}
		rAttr.addFlashAttribute("msg", msg);
		return page;
	}

	@Transactional
	public BoardDTO detail(Model model, int postId) {
		int success = dao.upHits(postId);
		logger.info("조회수 올리기 성공 여부 : "+success);
		return dao.detail(postId);
	}

	public int update(int postId, String title, String postContent) {
		return dao.update(postId, title, postContent);
	}

	public HashMap<String, Object> getComments(int postId, int page, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int end = page*5;
		int start = end-5+1;
		int pages = 0;

		ArrayList<BoardDTO> list = dao.getComments(start, end, postId); 
		
		//테스트용으로 세션에 loginId저장
		session.setAttribute("loginId", "hong");
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId 세션 : ", loginId);
		
		//이 포스팅의 댓글 총 개수
		int totalCnt = dao.allCount(postId);
		logger.info("리스트 사이즈 : "+list.size()+"/ 댓글 총 개수"+totalCnt);
		map.put("list", list);
		map.put("totalCnt", totalCnt);
		map.put("currPage", page);
		map.put("loginId", loginId);
		
		if(totalCnt > 5) {
		//전체 댓글페이지 개수(한 페이지에 5개의 댓글)
		pages = (int) (totalCnt%5 > 0 
				? Math.floor(totalCnt/5)+1 : Math.floor(totalCnt/5));
		}else {
			pages = 1;
		}
		
		map.put("pages", pages);
		
		return map;
	}

}
