package com.hong.blog.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hong.blog.dao.BoardDAO;
import com.hong.blog.dto.BoardDTO;

@Service
public class BoardService {

	@Autowired BoardDAO dao;
	
	public ArrayList<BoardDTO> getPostList() {
		
		return dao.getPostList();
	}

}
