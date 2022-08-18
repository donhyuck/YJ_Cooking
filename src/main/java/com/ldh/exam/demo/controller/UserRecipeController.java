package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserRecipeController {

	private RecipeService recipeService;
	private Rq rq;

	public UserRecipeController(RecipeService recipeService, Rq rq) {
		this.recipeService = recipeService;
		this.rq = rq;
	}

	// 레시피 추천목록 페이지 메서드
	@RequestMapping("/user/list/suggest")
	public String showSuggestList() {

		return "user/list/suggest";
	}

	// 레시피 분류목록 페이지 메서드
	@RequestMapping("/user/list/category")
	public String showCategoryList() {

		return "user/list/category";
	}

	// 레시피 랭킹목록 페이지 메서드
	@RequestMapping("/user/list/rank")
	public String showRankList() {

		return "user/list/rank";
	}

	// 레시피 노트목록 페이지 메서드
	@RequestMapping("/user/list/note")
	public String showNoteList() {

		return "user/list/note";
	}

	// 레시피 상세페이지 페이지 메서드
	@RequestMapping("/user/recipe/detail")
	public String showDetail(Model model, int id) {

		// 레시피 찾기
		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), id);

		if (recipe == null) {
			return rq.historyBackOnView(Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		model.addAttribute("recipe", recipe);

		return "user/recipe/detail";
	}

	// 레시피 등록 페이지 메서드
	@RequestMapping("/user/recipe/write")
	public String showWrite() {

		return "user/recipe/write";
	}

	// 레시피 등록하기 메서드
	@RequestMapping("/user/recipe/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, String replaceUri) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return Ut.jsHistoryBack("제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return Ut.jsHistoryBack("내용(을)를 입력해주세요.");
		}

		// 레시피 등록하기
		int id = recipeService.writeRecipe(rq.getLoginedMemberId(), title, body);

		// 레시피 등록 후 이동
		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../recipe/detail?id=%d", id);
		}

		return Ut.jsReplace(Ut.f("%s번 레시피가 등록되었습니다.", id), replaceUri);
	}

	// 레시피 수정 페이지 메서드
	@RequestMapping("/user/recipe/modify")
	public String showModify(Model model, int id) {

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanModifyRd = recipeService.actorCanModify(rq.getLoginedMemberId(), id);

		if (actorCanModifyRd.isFail()) {
			return rq.historyBackOnView(actorCanModifyRd.getMsg());
		}

		model.addAttribute("recipe", actorCanModifyRd.getData1());

		return "user/recipe/modify";
	}

	// 레시피 수정하기 메서드
	@RequestMapping("/user/recipe/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return Ut.jsHistoryBack("제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return Ut.jsHistoryBack("내용(을)를 입력해주세요.");
		}

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanModifyRd = recipeService.actorCanModify(rq.getLoginedMemberId(), id);

		if (actorCanModifyRd.isFail()) {
			return Ut.jsHistoryBack(actorCanModifyRd.getMsg());
		}

		// 레시피 수정하기
		recipeService.modifyRecipe(id, title, body);

		return Ut.jsReplace(Ut.f("%s번 레시피가 수정되었습니다.", id), Ut.f("../recipe/detail?id=%d", id));
	}

	// 레시피 삭제하기 메서드
	@RequestMapping("/user/recipe/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanDeleteRd = recipeService.actorCanDelete(rq.getLoginedMemberId(), id);

		if (actorCanDeleteRd.isFail()) {
			return Ut.jsHistoryBack(actorCanDeleteRd.getMsg());
		}

		// 삭제처리
		recipeService.deleteRecipe(id);

		return Ut.jsReplace(Ut.f("%s번 레시피가 삭제되었습니다.", id), "/");
	}
}
