package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.ReplyRepository;
import com.ldh.exam.demo.vo.Recipe;

@Service
public class ReplyService {

	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}

	// 댓글 목록 가져오기
	public List<Recipe> getForPrintRecipes(int memberId) {

		// 구현중
		return null;
	}

	// 레시피 등록하기
	public int writeRecipe(int memberId, String title, String body) {

		// 구현중
		return 0;
	}

	// 레시피 수정하기
	public void modifyRecipe(int id, String title, String body) {

		// 구현중
	}

	// 레시피 삭제하기
	public void deleteRecipe(int id) {

		// 구현중
	}
}
