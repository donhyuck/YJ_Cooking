package com.ldh.exam.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.vo.Recipe;

@Controller
public class UserRecipeController {

	private RecipeService recipeService;

	public UserRecipeController(RecipeService recipeService) {
		this.recipeService = recipeService;
	}

	// 레시피 목록보기 메서드
	@RequestMapping("/user/recipe/list")
	@ResponseBody
	public List<Recipe> showList() {

		return recipeService.getRecipes();
	}

	// 레시피 상세보기 메서드
	@RequestMapping("/user/recipe/detail")
	@ResponseBody
	public Recipe showDetail(int id) {

		return recipeService.getRecipe(id);
	}

	// 레시피 등록하기 메서드
	@RequestMapping("/user/recipe/doWrite")
	@ResponseBody
	public Recipe doWrite(String title, String body) {

		Recipe recipe = recipeService.writeRecipe(title, body);
		return recipe;
	}

	// 레시피 수정하기 메서드
	@RequestMapping("/user/recipe/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		Recipe recipe = recipeService.getRecipe(id);

		if (recipe == null) {
			return id + "번 레시피를 찾을 수 없습니다.";
		}

		// 수정처리
		recipeService.modifyRecipe(id, title, body);

		return id + "번 레시피를 수정했습니다.";
	}

	// 레시피 삭제하기 메서드
	@RequestMapping("/user/recipe/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		Recipe recipe = recipeService.getRecipe(id);

		if (recipe == null) {
			return id + "번 레시피를 찾을 수 없습니다.";
		}

		// 삭제처리
		recipeService.deleteRecipe(id);

		return id + "번 레시피를 삭제했습니다.";
	}
}
