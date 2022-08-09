package com.ldh.exam.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.ResultData;

@Controller
public class UserRecipeController {

	private RecipeService recipeService;

	public UserRecipeController(RecipeService recipeService) {
		this.recipeService = recipeService;
	}

	// 레시피 목록보기 메서드
	@RequestMapping("/user/recipe/list")
	@ResponseBody
	public ResultData<List<Recipe>> showList() {

		List<Recipe> recipes = recipeService.getRecipes();

		return ResultData.from("S-1", "레시피 목록입니다.", recipes);
	}

	// 레시피 상세보기 메서드
	@RequestMapping("/user/recipe/detail")
	@ResponseBody
	public ResultData<Recipe> showDetail(int id) {

		// 레시피 찾기
		Recipe recipe = recipeService.getRecipe(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		return ResultData.from("S-1", Ut.f("%s번 레시피입니다.", id), recipe);
	}

	// 레시피 등록하기 메서드
	@RequestMapping("/user/recipe/doWrite")
	@ResponseBody
	public ResultData<Recipe> doWrite(HttpSession httpSession, String title, String body) {

		// 로그인 확인, 세션접근
		boolean isLogined = false;
		int loginedMemberId = 0;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-Z", "로그인 후 이용해주세요.");
		}

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return ResultData.from("F-1", "제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return ResultData.from("F-2", "내용(을)를 입력해주세요.");
		}

		// 레시피 등록하기
		ResultData<Integer> writeRecipeRd = recipeService.writeRecipe(loginedMemberId, title, body);

		int id = (int) writeRecipeRd.getData1();
		Recipe recipe = recipeService.getRecipe(id);

		return ResultData.newData(writeRecipeRd, recipe);
	}

	// 레시피 수정하기 메서드
	@RequestMapping("/user/recipe/doModify")
	@ResponseBody
	public ResultData<Recipe> doModify(HttpSession httpSession, int id, String title, String body) {

		// 로그인 확인, 세션접근
		boolean isLogined = false;
		int loginedMemberId = 0;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-Z", "로그인 후 이용해주세요.");
		}

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return ResultData.from("F-1", "제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return ResultData.from("F-2", "내용(을)를 입력해주세요.");
		}

		// 레시피 찾기
		Recipe recipe = recipeService.getRecipe(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (recipe.getMemberId() != loginedMemberId) {
			return ResultData.from("F-B", "해당 레시피에 대한 권한이 없습니다.");
		}

		// 레시피 수정하기
		recipeService.modifyRecipe(id, title, body);

		return ResultData.from("S-1", Ut.f("%s번 레시피가 수정되었습니다.", id), recipe);
	}

	// 레시피 삭제하기 메서드
	@RequestMapping("/user/recipe/doDelete")
	@ResponseBody
	public ResultData doDelete(HttpSession httpSession, int id) {

		// 로그인 확인, 세션접근
		boolean isLogined = false;
		int loginedMemberId = 0;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) httpSession.getAttribute("loginedMemberId");
		}

		if (isLogined == false) {
			return ResultData.from("F-Z", "로그인 후 이용해주세요.");
		}

		// 레시피 찾기
		Recipe recipe = recipeService.getRecipe(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (recipe.getMemberId() != loginedMemberId) {
			return ResultData.from("F-B", "해당 레시피에 대한 권한이 없습니다.");
		}

		// 삭제처리
		recipeService.deleteRecipe(id);

		return ResultData.from("S-1", Ut.f("%s번 레시피가 삭제되었습니다.", id));
	}
}
