package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.ReactionRepository;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.ResultData;

@Service
public class ReactionService {

	private RecipeService recipeService;
	private ReactionRepository reactionRepository;

	public ReactionService(RecipeService recipeService, ReactionRepository reactionRepository) {
		this.recipeService = recipeService;
		this.reactionRepository = reactionRepository;
	}

	// 좋아요가 없으면 리액션 가능
	public ResultData actorCanReaction(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return ResultData.from("F-A", "로그인 후 이용해주세요.");
		}

		int sumReactionPoint = reactionRepository.getReactionSumByRelId(memberId, relId, relTypeCode);

		if (sumReactionPoint != 0) {
			return ResultData.from("F-1", "이미 리액션했습니다.", "sumReactionPoint", sumReactionPoint);
		}

		return ResultData.from("S-1", "리액션이 가능합니다.", "sumReactionPoint", sumReactionPoint);
	}

	// 좋아요 처리
	public void doMakeLike(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return;
		}

		reactionRepository.doMakeLike(memberId, relId, relTypeCode);

		// 해당 레시피의 좋아요 갱신
		switch (relTypeCode) {
		case "recipe":
			recipeService.increaseGoodRP(relId);
		}
	}

}
