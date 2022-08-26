package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Board;

@Mapper
public interface BoardRepository {

	public List<Board> getBoards();
}
