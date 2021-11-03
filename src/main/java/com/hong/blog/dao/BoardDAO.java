package com.hong.blog.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.hong.blog.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> getPostList();

}
