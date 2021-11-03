package com.hong.blog.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hong.blog.dto.BoardDTO;
import com.hong.blog.service.BoardService;


@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getPostList(Model model) {
		ArrayList<BoardDTO> list = service.getPostList();
		model.addAttribute("list", list);
		return "home";
	}
}
