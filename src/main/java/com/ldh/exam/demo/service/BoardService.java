package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.BoardRepository;

@Service
public class BoardService {

	private BoardRepository boardRepository;

	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}
}
