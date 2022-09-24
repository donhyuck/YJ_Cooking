package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.ReactionService;
import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserReactionController {

	private ReactionService reactionService;
	private RecipeService recipeService;
	private Rq rq;

	public UserReactionController(ReactionService reactionService, RecipeService recipeService, Rq rq) {
		this.reactionService = reactionService;
		this.recipeService = recipeService;
		this.rq = rq;
	}

	// 스크랩 처리 메서드
	@RequestMapping("/user/reaction/doMakeScrap")
	@ResponseBody
	public String doMakeScrap(String relTypeCode, int relId, String replaceUri) {

		// 사용자가 스크랩 가능여부 확인
		ResultData isActorCanScrapRd = reactionService.actorCanScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanScrapRd.isFail()) {
			return rq.jsHistoryBack(isActorCanScrapRd.getMsg());
		}

		// 스크랩 처리
		ResultData doMakeScrapRd = reactionService.doMakeScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		// 기존 레시피 페이지로 이동
		replaceUri = Ut.f("/user/recipe/detail?id=%d", relId);

		return rq.jsReplace(doMakeScrapRd.getMsg(), replaceUri);
	}

	// 스크랩 취소 메서드
	@RequestMapping("/user/reaction/doCancelScrap")
	@ResponseBody
	public String doCancelScrap(String relTypeCode, int relId, String replaceUri) {

		// 사용자가 스크랩 가능여부 확인
		ResultData isActorCanScrapRd = reactionService.actorCanScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanScrapRd.isSuccess()) {
			return rq.jsHistoryBack("이미 취소되었습니다.");
		}

		// 스크랩 취소
		ResultData doCancelScrapRd = reactionService.doCancelScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		// 기존 레시피 페이지로 이동
		replaceUri = Ut.f("/user/recipe/detail?id=%d", relId);

		return rq.jsReplace(doCancelScrapRd.getMsg(), replaceUri);
	}

	// 스크랩 처리 메서드 (ajax 적용)
	@RequestMapping("/user/reaction/doMakeScrapAjax")
	@ResponseBody
	public ResultData doMakeScrapAjax(String relTypeCode, int relId) {

		if (Ut.empty(relId)) {
			return ResultData.from("F-1", "레시피를 찾을 수 없습니다..");
		}

		// 사용자가 스크랩 가능여부 확인
		ResultData isActorCanScrapRd = reactionService.actorCanScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanScrapRd.isFail()) {
			return ResultData.from(isActorCanScrapRd.getResultCode(), isActorCanScrapRd.getMsg());
		}

		// 스크랩 처리
		ResultData doMakeScrapRd = reactionService.doMakeScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		// 현재 스크랩 수 가져오기
		int scrapCnt = recipeService.getRecipeById(relId).getScrap();

		return ResultData.from("S-1", doMakeScrapRd.getMsg(), "scrapCnt", scrapCnt);
	}

	// 스크랩 취소 메서드 (ajax 적용)
	@RequestMapping("/user/reaction/doCancelScrapAjax")
	@ResponseBody
	public ResultData doCancelScrapAjax(String relTypeCode, int relId) {

		if (Ut.empty(relId)) {
			return ResultData.from("F-1", "레시피를 찾을 수 없습니다..");
		}

		// 사용자가 스크랩 가능여부 확인
		ResultData isActorCanScrapRd = reactionService.actorCanScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanScrapRd.isSuccess()) {
			return ResultData.from("F-B", "이미 취소되었습니다.");
		}

		// 스크랩 취소
		ResultData doCancelScrapRd = reactionService.doCancelScrap(rq.getLoginedMemberId(), relId, relTypeCode);

		// 현재 스크랩 수 가져오기
		int scrapCnt = recipeService.getRecipeById(relId).getScrap();

		return ResultData.from("S-2", doCancelScrapRd.getMsg(), "scrapCnt", scrapCnt);
	}

	// 좋아요 처리 메서드
	@RequestMapping("/user/reaction/doMakeLike")
	@ResponseBody
	public String doMakeLike(String relTypeCode, int relId, @RequestParam(defaultValue = "/") String replaceUri) {

		// 사용자가 리액션 가능여부 확인
		ResultData isActorCanLikeRd = reactionService.actorCanLike(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanLikeRd.isFail()) {
			return rq.jsHistoryBack(isActorCanLikeRd.getMsg());
		}

		// 좋아요 처리
		ResultData doMakeLikeRd = reactionService.doMakeLike(rq.getLoginedMemberId(), relId, relTypeCode);

		return rq.jsReplace(doMakeLikeRd.getMsg(), replaceUri);
	}

	// 좋아요 취소 메서드
	@RequestMapping("/user/reaction/doCancelLike")
	@ResponseBody
	public String doCancelLike(String relTypeCode, int relId, @RequestParam(defaultValue = "/") String replaceUri) {

		// 사용자가 리액션 가능여부 확인
		ResultData isActorCanLikeRd = reactionService.actorCanLike(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanLikeRd.isSuccess()) {
			return rq.jsHistoryBack("이미 취소되었습니다.");
		}

		// 좋아요 취소
		ResultData doCancelLikeRd = reactionService.doCancelLike(rq.getLoginedMemberId(), relId, relTypeCode);

		return rq.jsReplace(doCancelLikeRd.getMsg(), replaceUri);
	}

	// 좋아요 처리 메서드 (ajax 적용)
	@RequestMapping("/user/reaction/doMakeLikeAjax")
	@ResponseBody
	public ResultData doMakeLikeAjax(String relTypeCode, int relId) {

		if (Ut.empty(relId)) {
			return ResultData.from("F-1", "레시피를 찾을 수 없습니다..");
		}

		// 사용자가 좋아요 가능여부 확인
		ResultData isActorCanLikeRd = reactionService.actorCanLike(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanLikeRd.isFail()) {
			return ResultData.from(isActorCanLikeRd.getResultCode(), isActorCanLikeRd.getMsg());
		}

		// 좋아요 처리
		ResultData doMakeLikeRd = reactionService.doMakeLike(rq.getLoginedMemberId(), relId, relTypeCode);

		// 현재 좋아요 수 가져오기
		int likeCnt = recipeService.getRecipeById(relId).getGoodRP();

		return ResultData.from("S-1", doMakeLikeRd.getMsg(), "likeCnt", likeCnt);
	}

	// 좋아요 취소 메서드 (ajax 적용)
	@RequestMapping("/user/reaction/doCancelLikeAjax")
	@ResponseBody
	public ResultData doCancelLikeAjax(String relTypeCode, int relId) {

		if (Ut.empty(relId)) {
			return ResultData.from("F-1", "레시피를 찾을 수 없습니다..");
		}

		// 사용자가 좋아요 가능여부 확인
		ResultData isActorCanLikeRd = reactionService.actorCanLike(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanLikeRd.isSuccess()) {
			return ResultData.from("F-B", "이미 취소되었습니다.");
		}

		// 좋아요 취소
		ResultData doCancelLikeRd = reactionService.doCancelLike(rq.getLoginedMemberId(), relId, relTypeCode);

		// 현재 좋아요 수 가져오기
		int likeCnt = recipeService.getRecipeById(relId).getGoodRP();

		return ResultData.from("S-2", doCancelLikeRd.getMsg(), "likeCnt", likeCnt);
	}
}
