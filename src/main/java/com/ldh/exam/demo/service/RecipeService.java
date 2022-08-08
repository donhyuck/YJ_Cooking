package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.RecipeRepository;
import com.ldh.exam.demo.vo.Recipe;

@Service
public class RecipeService {

	private RecipeRepository recipeRepository;

	public RecipeService(RecipeRepository recipeRepository) {
		this.recipeRepository = recipeRepository;
	}

	// 특정 레시피 가져오기
	public Recipe getRecipe(int id) {

		return recipeRepository.getRecipe(id);
	}

	// 레시피 목록 가져오기
	public List<Recipe> getRecipes() {

		return recipeRepository.getRecipes();
	}

	// 레시피 등록하기
	public Recipe writeRecipe(String title, String body) {

		return recipeRepository.writeRecipe(title, body);
	}

	// 레시피 수정하기
	public void modifyRecipe(int id, String title, String body) {

		recipeRepository.modifyRecipe(id, title, body);
	}

	// 레시피 삭제하기
	public void deleteRecipe(int id) {

		recipeRepository.deleteRecipe(id);
	}

}
