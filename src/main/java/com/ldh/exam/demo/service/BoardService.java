package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.BoardRepository;
import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;

@Service
public class BoardService {

	private BoardRepository boardRepository;

	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}

	public Board getBoardByBoardId(int id) {

		return boardRepository.getBoardByBoardId(id);
	}

	public List<Board> getBoards() {

		return boardRepository.getBoards();
	}

	public String getBoardNameByBoardId(int boardId) {

		return boardRepository.getBoardNameByBoardId(boardId);
	}

	public Category getCategoryByBoardId(int boardId) {

		return boardRepository.getCategoryByBoardId(boardId);
	}

	public List<Category> getCategories() {

		return boardRepository.getCategories();
	}

	public int getGuideIdByBoardIdAndRelId(int boardId, int relId) {

		return boardRepository.getGuideIdByBoardIdAndRelId(boardId, relId);
	}
}
