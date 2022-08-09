package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.RecipeRepository;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.ResultData;

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
	public ResultData writeRecipe(String title, String body) {

		recipeRepository.writeRecipe(title, body);

		int id = recipeRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%s번 레시피가 등록되었습니다.", id), id);
	}

	// 레시피 수정하기
	public ResultData modifyRecipe(int id, String title, String body) {

		recipeRepository.modifyRecipe(id, title, body);

		Recipe recipe = recipeRepository.getRecipe(id);

		return ResultData.from("S-1", Ut.f("%s번 레시피가 수정되었습니다.", id), recipe);
	}

	// 레시피 삭제하기
	public ResultData deleteRecipe(int id) {

		recipeRepository.deleteRecipe(id);

		return ResultData.from("S-1", Ut.f("%s번 레시피가 삭제되었습니다.", id));
	}

}
