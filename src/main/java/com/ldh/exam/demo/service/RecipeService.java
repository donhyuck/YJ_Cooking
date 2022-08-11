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
	public Recipe getForPrintRecipe(int id) {

		return recipeRepository.getForPrintRecipe(id);
	}

	// 레시피 목록 가져오기
	public List<Recipe> getForPrintRecipes() {

		return recipeRepository.getForPrintRecipes();
	}

	// 레시피 등록하기
	public ResultData<Integer> writeRecipe(int memberId, String title, String body) {

		recipeRepository.writeRecipe(memberId, title, body);

		int id = recipeRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%s번 레시피가 등록되었습니다.", id), "id", id);
	}

	// 레시피 수정하기
	public void modifyRecipe(int id, String title, String body) {

		recipeRepository.modifyRecipe(id, title, body);
	}

	// 레시피 삭제하기
	public void deleteRecipe(int id) {

		recipeRepository.deleteRecipe(id);
	}

	public ResultData actorCanModify(int memberId, int id) {

		// 레시피 찾기
		Recipe recipe = getForPrintRecipe(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (recipe.getMemberId() != memberId) {
			return ResultData.from("F-B", "해당 레시피에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "수정가능합니다.");
	}

	public ResultData actorCanDelete(int memberId, int id) {

		// 레시피 찾기
		Recipe recipe = getForPrintRecipe(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (recipe.getMemberId() != memberId) {
			return ResultData.from("F-B", "해당 레시피에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "삭제가능합니다.");
	}

}
