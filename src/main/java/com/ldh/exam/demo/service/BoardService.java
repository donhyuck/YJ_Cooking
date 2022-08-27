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

	public List<Board> getBoards() {

		return boardRepository.getBoards();
	}

	public List<Category> getCategoriesByBoardId(int boardId) {

		return boardRepository.getCategoriesByBoardId(boardId);
	}
}
