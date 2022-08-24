package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.ReplyService;
import com.ldh.exam.demo.util.Ut;
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

		// 구현중
		if (Ut.empty(replaceUri)) {

			switch (relTypeCode) {
			case "recipe":
				replaceUri = Ut.f("../recipe/detail?id=%d", relId);
				break;
			}
		}

		return null;
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
	public String doDelete(int id) {

		// 구현중
		return null;
	}
}
