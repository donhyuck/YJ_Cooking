package com.ldh.exam.demo.controller;

import java.util.List;

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
	public ResultData showList() {

		List<Recipe> recipes = recipeService.getRecipes();

		return ResultData.from("S-1", "레시피 목록입니다.", recipes);
	}

	// 레시피 상세보기 메서드
	@RequestMapping("/user/recipe/detail")
	@ResponseBody
	public ResultData showDetail(int id) {

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
	public ResultData doWrite(String title, String body) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return ResultData.from("F-1", "제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return ResultData.from("F-2", "내용(을)를 입력해주세요.");
		}

		// 레시피 등록하기
		ResultData writeRecipeRd = recipeService.writeRecipe(title, body);

		int id = (int) writeRecipeRd.getData1();
		Recipe recipe = recipeService.getRecipe(id);

		return ResultData.from(writeRecipeRd.getResultCode(), writeRecipeRd.getMsg(), recipe);
	}

	// 레시피 수정하기 메서드
	@RequestMapping("/user/recipe/doModify")
	@ResponseBody
	public ResultData doModify(int id, String title, String body) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return ResultData.from("F-2", "제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return ResultData.from("F-3", "내용(을)를 입력해주세요.");
		}

		// 레시피 찾기
		Recipe recipe = recipeService.getRecipe(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 레시피 수정하기
		ResultData modifyRecipeRd = recipeService.modifyRecipe(id, title, body);

		return ResultData.from(modifyRecipeRd.getResultCode(), modifyRecipeRd.getMsg(), modifyRecipeRd.getData1());
	}

	// 레시피 삭제하기 메서드
	@RequestMapping("/user/recipe/doDelete")
	@ResponseBody
	public ResultData doDelete(int id) {

		// 레시피 찾기
		Recipe recipe = recipeService.getRecipe(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 삭제처리
		ResultData deleteRecipeRd = recipeService.deleteRecipe(id);

		return ResultData.from(deleteRecipeRd.getResultCode(), deleteRecipeRd.getMsg(), deleteRecipeRd.getData1());
	}
}
