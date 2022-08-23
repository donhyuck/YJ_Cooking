package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.ReactionService;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserReactionController {

	private ReactionService reactionService;
	private Rq rq;

	public UserReactionController(ReactionService reactionService, Rq rq) {
		this.reactionService = reactionService;
		this.rq = rq;
	}

	// 좋아요 처리 메서드
	@RequestMapping("/user/reaction/doMakeLike")
	@ResponseBody
	public String doMakeLike(String relTypeCode, int relId, String replaceUri) {

		// 사용자가 리액션 가능여부 확인
		ResultData isActorCanReactionRd = reactionService.actorCanReaction(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanReactionRd.isFail()) {
			return rq.jsHistoryBack(isActorCanReactionRd.getMsg());
		}

		// 좋아요 처리
		ResultData doMakeLikeRd = reactionService.doMakeLike(rq.getLoginedMemberId(), relId, relTypeCode);

		return rq.jsReplace(doMakeLikeRd.getMsg(), replaceUri);
	}

	// 좋아요 취소 메서드
	@RequestMapping("/user/reaction/doCancelLike")
	@ResponseBody
	public String doCancelLike(String relTypeCode, int relId, String replaceUri) {

		// 사용자가 리액션 가능여부 확인
		ResultData isActorCanReactionRd = reactionService.actorCanReaction(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanReactionRd.isSuccess()) {
			return rq.jsHistoryBack("이미 취소되었습니다.");
		}

		// 좋아요 취소
		ResultData doCancelLikeRd = reactionService.doCancelLike(rq.getLoginedMemberId(), relId, relTypeCode);

		return rq.jsReplace(doCancelLikeRd.getMsg(), replaceUri);
	}
}
