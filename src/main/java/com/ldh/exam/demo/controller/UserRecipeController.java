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

		List<Recipe> recipes = recipeService.getRecipes();

		return recipes;
	}

	// 레시피 상세보기 메서드
	@RequestMapping("/user/recipe/detail")
	@ResponseBody
	public Recipe showDetail(int id) {

		Recipe recipe = recipeService.getRecipe(id);

		return recipe;
	}

	// 레시피 등록하기 메서드
	@RequestMapping("/user/recipe/doWrite")
	@ResponseBody
	public Recipe doWrite(String title, String body) {

		Recipe recipe = recipeService.writeRecipe(title, body);
		return recipe;
	}
}
