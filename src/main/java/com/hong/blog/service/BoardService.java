package com.hong.blog.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
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
		int success = delList.get(0);
		//int success = dao.delPost(delList);
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

}
