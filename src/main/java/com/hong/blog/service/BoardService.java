package com.hong.blog.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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

	public HashMap<String, Object> delPost(int postId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int success = dao.delPost(postId);
		logger.info("success : {}",success);
		map.put("success", success);
		return map;
	}

	public String write(RedirectAttributes rAttr, HashMap<String, String> param) {
		String msg = "게시글 작성에 실패했습니다.";
		String title = param.get("title");
		String userId = param.get("userId");
		String content = param.get("content");
		logger.info("title/userId/content : "+title+"/"+userId+"/"+content);
		int success = dao.write(title, userId, content);
		logger.info("success : {}", success);
		if(success > 0) {
			msg = "게시글 작성이 완료되었습니다.";
		}
		rAttr.addFlashAttribute("msg", msg);
		return "redirect:/list";
	}

	public BoardDTO detail(Model model, int postId) {
		return dao.detail(postId);
	}

}
