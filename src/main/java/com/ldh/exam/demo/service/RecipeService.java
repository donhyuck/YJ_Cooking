package com.ldh.exam.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.vo.Recipe;

@Service
public class RecipeService {

	// 인스턴스 변수
	public int recipeLastId;
	public List<Recipe> recipes;

	// Recipe 서비스 생성자
	public RecipeService() {
		recipeLastId = 0;
		recipes = new ArrayList<>();

		makeTestData();
	}

	private void makeTestData() {
		for (int i = 1; i <= 10; i++) {
			String title = "요리명" + i;
			String body = "요리설명" + i;

			writeRecipe(title, body);
		}
	}

	// 레시피 등록하기
	public Recipe writeRecipe(String title, String body) {

		int id = recipeLastId + 1;
		Recipe recipe = new Recipe(id, title, body);

		recipes.add(recipe);
		recipeLastId = id;

		return recipe;
	}

}
