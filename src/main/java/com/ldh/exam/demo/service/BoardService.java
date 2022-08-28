package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.BoardRepository;
import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;
import com.ldh.exam.demo.vo.Guide;

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

	public Category getCategoryByBoardIdAndRelId(int boardId, int relId) {

		return boardRepository.getCategoryByBoardIdAndRelId(boardId, relId);
	}

	public List<Category> getCategories() {

		return boardRepository.getCategories();
	}
}
