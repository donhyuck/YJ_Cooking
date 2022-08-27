package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;

@Mapper
public interface BoardRepository {

	public Board getBoardByBoardId(int id);

	public List<Board> getBoards();

	public String getBoardNameByBoardId(int boardId);

	public Category getCategoryByBoardId(int boardId);

	public List<Category> getCategories();

	public int getGuideIdByBoardIdAndRelId(int boardId, int relId);
}
