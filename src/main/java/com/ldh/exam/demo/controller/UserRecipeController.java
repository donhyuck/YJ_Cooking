package com.ldh.exam.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.vo.Recipe;

@Controller
public class UserRecipeController {

	// 인스턴스 변수
	private int recipeLastId;
	private List<Recipe> recipes;

	// Recipe 컨트롤러 생성자
	public UserRecipeController() {
		recipeLastId = 0;
		recipes = new ArrayList<>();

		makeTestData();
	}

	// 서비스 메서드 시작
	private void makeTestData() {
		for (int i = 1; i <= 10; i++) {
			int id = recipeLastId + 1;
			String title = "요리명" + i;
			String body = "요리설명" + i;
			Recipe recipe = new Recipe(id, title, body);

			recipes.add(recipe);
			recipeLastId = id;
		}
	}

	// 레시피 등록하기 메서드
	@RequestMapping("/user/recipe/doWrite")
	@ResponseBody
	public Recipe doWrite(String title, String body) {

		int id = recipeLastId + 1;
		Recipe recipe = new Recipe(id, title, body);

		recipes.add(recipe);
		recipeLastId = id;

		return recipe;
	}

	// 레시피 목록보기 메서드
	@RequestMapping("/user/recipe/list")
	@ResponseBody
	public List<Recipe> showList() {

		return recipes;
	}
}
