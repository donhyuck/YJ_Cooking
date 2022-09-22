package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.service.ReplyService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.Reply;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserReplyController {

	private ReplyService replyService;
	private RecipeService recipeService;
	private Rq rq;

	public UserReplyController(ReplyService replyService, RecipeService recipeService, Rq rq) {
		this.replyService = replyService;
		this.recipeService = recipeService;
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

		// 등록한 댓글 번호를 URI에 포함
		replaceUri = Ut.getNewUri(replaceUri, "focusReplyId", id + "");

		return rq.jsReplace("", replaceUri);
	}

	// 댓글 수정 페이지 메서드
	@RequestMapping("/user/reply/modify")
	public String showModify(Model model, int id) {

		// 댓글 찾기, 작성자 권한 체크
		ResultData actorCanModifyRd = replyService.actorCanModify(rq.getLoginedMemberId(), id);

		if (actorCanModifyRd.isFail()) {
			return rq.historyBackOnView(actorCanModifyRd.getMsg());
		}

		// 해당 댓글을 수정 페이지로 넘기기
		Reply reply = replyService.getForPrintReply(rq.getLoginedMemberId(), "recipe", id);

		// 댓글에 해당하는 레시피 정보 넘기기
		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), reply.getRelId());

		model.addAttribute("reply", reply);
		model.addAttribute("recipe", recipe);

		return "/user/reply/modify";
	}

	// 댓글 수정하기 메서드
	@RequestMapping("/user/reply/doModify")
	@ResponseBody
	public String doModify(int id, String body, @RequestParam(defaultValue = "/") String afterModifyUri) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(body)) {
			return rq.jsHistoryBack("댓글 내용(을)를 입력해주세요.");
		}

		// 댓글 찾기, 작성자 권한 체크
		ResultData actorCanModifyRd = replyService.actorCanModify(rq.getLoginedMemberId(), id);

		if (actorCanModifyRd.isFail()) {
			return rq.historyBackOnView(actorCanModifyRd.getMsg());
		}

		// 댓글 수정하기
		replyService.modifyReply(id, body);

		Reply reply = (Reply) actorCanModifyRd.getData1();

		// 수정 후 기존 레시피 페이지로 이동
		if (Ut.empty(afterModifyUri)) {
			switch (reply.getRelTypeCode()) {
			case "recipe":
				afterModifyUri = Ut.f("../recipe/detail?id=%d", reply.getRelId());
				break;
			}
		}

		// 수정후 댓글 번호를 URI에 포함
		afterModifyUri = Ut.getNewUri(afterModifyUri, "focusReplyId", id + "");

		return rq.jsReplace("", afterModifyUri);
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

	// 댓글 삭제하기 (ajax 적용)
	@RequestMapping("/user/reply/doDeleteAjax")
	@ResponseBody
	public ResultData doDeleteAjax(int id) {

		if (Ut.empty(id)) {
			return ResultData.from("F-1", "댓글번호가 입력되지 않았습니다.");
		}

		// 댓글 찾기, 작성자 권한 체크
		ResultData actorCanDeleteRd = replyService.actorCanDelete(rq.getLoginedMemberId(), id);

		if (actorCanDeleteRd.isFail()) {
			return ResultData.from(actorCanDeleteRd.getResultCode(), actorCanDeleteRd.getMsg());
		}

		// 삭제처리
		ResultData deleteReplyRd = replyService.deleteReply(id);

		return ResultData.from("S-1", deleteReplyRd.getMsg());
	}
}
