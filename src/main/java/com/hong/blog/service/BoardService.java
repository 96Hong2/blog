package com.hong.blog.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
