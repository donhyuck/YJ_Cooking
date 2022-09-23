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
	public ResultData actorCanLike(int memberId, int relId, String relTypeCode) {

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
	public ResultData doMakeLike(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return ResultData.from("F-A", "로그인 후 이용해주세요.");
		}

		reactionRepository.doMakeLike(memberId, relId, relTypeCode);

		// 해당 레시피의 좋아요 갱신
		String forPrintCodeName = "";

		switch (relTypeCode) {
		case "recipe":
			recipeService.increaseGoodRP(relId);
			forPrintCodeName = "레시피";
		}

		return ResultData.from("S-1", Ut.f("%d번 %s [좋아요] 처리", relId, forPrintCodeName));
	}

	// 좋아요 취소
	public ResultData doCancelLike(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return ResultData.from("F-A", "로그인 후 이용해주세요.");
		}

		reactionRepository.doCancelLike(memberId, relId, relTypeCode);

		// 해당 레시피의 좋아요 갱신
		String forPrintCodeName = "";

		switch (relTypeCode) {
		case "recipe":
			recipeService.decreaseGoodRP(relId);
			forPrintCodeName = "레시피";
		}

		return ResultData.from("S-1", Ut.f("%d번 %s [좋아요] 취소", relId, forPrintCodeName));
	}

	// 스크랩이 없으면 리액션 가능
	public ResultData actorCanScrap(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return ResultData.from("F-A", "로그인 후 이용해주세요.");
		}

		int sumScrapPoint = reactionRepository.getScrapSumByRelId(memberId, relId, relTypeCode);

		if (sumScrapPoint != 0) {
			return ResultData.from("F-1", "이미 스크랩했습니다.", "sumScrapPoint", sumScrapPoint);
		}

		return ResultData.from("S-1", "스크랩이 가능합니다.", "sumScrapPoint", sumScrapPoint);
	}

	// 스크랩 처리
	public ResultData doMakeScrap(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return ResultData.from("F-A", "로그인 후 이용해주세요.");
		}

		reactionRepository.doMakeScrap(memberId, relId, relTypeCode);

		// 해당 레시피의 스크랩 수 갱신
		String forPrintCodeName = "";

		switch (relTypeCode) {
		case "recipe":
			recipeService.increaseScrapPoint(relId);
			forPrintCodeName = "레시피";
		}

		return ResultData.from("S-1", Ut.f("%d번 %s [스크랩] 처리", relId, forPrintCodeName));
	}

	// 스크랩 취소
	public ResultData doCancelScrap(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return ResultData.from("F-A", "로그인 후 이용해주세요.");
		}

		reactionRepository.doCancelScrap(memberId, relId, relTypeCode);

		// 해당 레시피의 스크랩 갱신
		String forPrintCodeName = "";

		switch (relTypeCode) {
		case "recipe":
			recipeService.decreaseScrapPoint(relId);
			forPrintCodeName = "레시피";
		}

		return ResultData.from("S-1", Ut.f("%d번 %s [스크랩] 취소", relId, forPrintCodeName));
	}

}
