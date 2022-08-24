package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.ReplyService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserReplyController {

	private ReplyService replyService;
	private Rq rq;

	public UserReplyController(ReplyService replyService, Rq rq) {
		this.replyService = replyService;
		this.rq = rq;
	}

	// 댓글 등록하기 메서드
	@RequestMapping("/user/reply/doWrite")
	@ResponseBody
	public String doWrite(String relTypeCode, String relId, String body,
			@RequestParam(defaultValue = "/") String replaceUri) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(relTypeCode)) {
			return rq.jsHistoryBack("타입코드(을)를 입력해주세요.");
		}

		if (Ut.empty(relId)) {
			return rq.jsHistoryBack("타입번호(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return rq.jsHistoryBack("내용(을)를 입력해주세요.");
		}

		// 댓글 등록하기
		int id = replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);

		// 댓글 등록 후 기존 레시피 페이지로 이동
		if (Ut.empty(replaceUri)) {

			switch (relTypeCode) {
			case "recipe":
				replaceUri = Ut.f("../recipe/detail?id=%d", relId);
				break;
			}
		}

		return rq.jsReplace(Ut.f("%s번 댓글이 등록되었습니다.", id), replaceUri);
	}

	// 댓글 수정 페이지 메서드
	@RequestMapping("/user/reply/modify")
	public String showModify(Model model, int id) {

		// 구현중
		return null;
	}

	// 댓글 수정하기 메서드
	@RequestMapping("/user/reply/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		// 구현중
		return null;
	}

	// 댓글 삭제하기 메서드
	@RequestMapping("/user/reply/doDelete")
	@ResponseBody
	public String doDelete(int id, @RequestParam(defaultValue = "/") String replaceUri) {

		// 댓글 찾기, 작성자 권한 체크
		ResultData actorCanDeleteRd = replyService.actorCanDelete(rq.getLoginedMemberId(), id);

		if (actorCanDeleteRd.isFail()) {
			return rq.jsHistoryBack(actorCanDeleteRd.getMsg());
		}

		// 삭제처리
		replyService.deleteReply(id);

		return rq.jsReplace(Ut.f("%s번 댓글이 삭제되었습니다.", id), replaceUri);
	}
}
