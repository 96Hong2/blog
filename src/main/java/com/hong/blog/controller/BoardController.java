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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hong.blog.dto.BoardDTO;
import com.hong.blog.service.BoardService;


@Controller
public class BoardController {

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired BoardService service;
	
	//메인화면으로 이동
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String Home() {
		logger.info("메인 화면으로 이동 요청");
		return "home";
	}
	
	//게시글 리스트를 띄워주는 메소드
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String getPostList(Model model) {
		logger.info("게시글 리스트 요청");
		ArrayList<BoardDTO> list = service.getPostList();
		model.addAttribute("list", list);
		return "list";
	}
	
	//글쓰기 폼으로 이동시켜주는 메소드
	@RequestMapping(value = "/writeForm", method = RequestMethod.GET)
	public String writeForm() {
		logger.info("글쓰기 폼 요청");
		return "writeForm";
	}
	
	//게시글의 번호를 받아 해당 게시글을 삭제하는 메소드
	@RequestMapping(value = "/delPost", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> delPost(@RequestParam String postId) {
		logger.info("게시글 삭제 요청");
		int pId = Integer.parseInt(postId);
		logger.info("pId : {}", pId);
		return service.delPost(pId);
	}
	
	//게시글을 작성하는 메소드
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(RedirectAttributes rAttr, @RequestParam HashMap<String, String> param) {
		logger.info("게시글 작성 요청 : "+param);
		return service.write(rAttr, param);
	}
	
}
