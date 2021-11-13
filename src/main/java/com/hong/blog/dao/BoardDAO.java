package com.hong.blog.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.hong.blog.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> getPostList();

	int delPost(ArrayList<Integer> delList);

	int write(BoardDTO dto);

	BoardDTO detail(int postId);

	int update(int postId, String title, String postContent);

	int upHits(int postId);


}
