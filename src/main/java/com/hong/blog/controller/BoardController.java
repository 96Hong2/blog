package com.hong.blog.controller;

import java.awt.List;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

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
	@RequestMapping(value = "/delPost", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> delPost(@RequestParam(value="delArr[]") ArrayList<String> delArr) {
		logger.info("게시글 삭제 요청 : "+delArr);
		
		ArrayList<Integer> delList = new ArrayList<Integer>();
		for(String postId : delArr) {
			int pId = Integer.parseInt(postId);
			logger.info("pId : {}", pId);
			delList.add(pId);
		}
		logger.info("delList 크기 : "+delList.size());
		return service.delPost(delList);
	}
	
	//게시글을 작성하는 메소드
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String write(RedirectAttributes rAttr, @RequestParam HashMap<String, String> param) {
		logger.info("게시글 작성 요청 : "+param);
		return service.write(rAttr, param);
	}
	
	//게시글 상세보기 메소드
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(Model model, @RequestParam int postId) {
		logger.info("게시글 상세보기 요청 : "+postId);
		BoardDTO dto = service.detail(model, postId);
		model.addAttribute("post", dto);
		return "detail";
	}
	
	//게시글 수정 폼 보기 메소드
	@RequestMapping(value = "/updateForm", method = RequestMethod.GET)
	public String updateForm(Model model, @RequestParam int postId) {
		logger.info("게시글 수정 폼 요청 : "+postId);
		BoardDTO dto = service.detail(model, postId);
		model.addAttribute("post", dto);
		return "updateForm";
	}
	
	//게시글 수정 메소드
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(RedirectAttributes rAttr, @RequestParam int postId, @RequestParam String title, @RequestParam String postContent) {
		logger.info("게시글 수정 요청 : 번호/제목/내용 "+postId+"/"+title+"/"+postContent);
		int success = service.update(postId, title, postContent);
		logger.info("success : "+success);
		String msg = "게시글 수정에 실패했습니다.";
		if(success > 0) {
			msg = "게시글 수정이 완료되었습니다.";
		}
		rAttr.addFlashAttribute("msg", msg);
		return "redirect:/detail?postId="+postId;
	}
	
	//댓글 불러오기 메소드
	@RequestMapping(value = "/getComments", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getComments(@RequestParam int postId, @RequestParam int page, HttpSession session) {
		logger.info("댓글 불러올 게시글 번호 : " + postId);
		logger.info("댓글 페이지 : " + page);
		return service.getComments(postId, page, session);
	}
}
