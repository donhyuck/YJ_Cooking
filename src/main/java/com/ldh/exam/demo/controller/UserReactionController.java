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

	// 좋아요 메서드
	@RequestMapping("/user/reaction/doMakeLike")
	@ResponseBody
	public String doMakeLike(String relTypeCode, int relId, String replaceUri) {

		ResultData isActorCanReactionRd = reactionService.actorCanReaction(rq.getLoginedMemberId(), relId, relTypeCode);

		if (isActorCanReactionRd.isFail()) {
			return rq.jsHistoryBack(isActorCanReactionRd.getMsg());
		}

		return rq.jsReplace("좋아요", replaceUri);
	}
}
