package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;

@Mapper
public interface BoardRepository {

	public List<Board> getBoards();

	public List<Category> getCategoriesByBoardId(int boardId);
}
