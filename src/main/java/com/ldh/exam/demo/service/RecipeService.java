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
	public Recipe getForPrintRecipe(int memberId, int id) {

		Recipe recipe = recipeRepository.getForPrintRecipe(id);

		updateForPrintData(memberId, recipe);

		return recipe;
	}

	// 레시피 목록 가져오기
	public List<Recipe> getForPrintRecipes(int memberId) {

		List<Recipe> recipes = recipeRepository.getForPrintRecipes();

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;
	}

	// 분류페이지에서 선택한 레시피 목록 가져오기
	public List<Recipe> getRecipesOfChoice(int boardId, int relId) {

		return recipeRepository.getRecipesOfChoice(boardId, relId);
	}

	// 레시피 등록하기
	public int writeRecipe(int memberId, String title, String body) {

		recipeRepository.writeRecipe(memberId, title, body);

		return recipeRepository.getLastInsertId();
	}

	// 레시피 수정하기
	public void modifyRecipe(int id, String title, String body) {

		recipeRepository.modifyRecipe(id, title, body);
	}

	// 레시피 삭제하기
	public void deleteRecipe(int id) {

		recipeRepository.deleteRecipe(id);
	}

	// 레시피 확인
	private Recipe getRecipeById(int id) {

		return recipeRepository.getRecipeById(id);
	}

	// 수정, 삭제 권한여부 업데이트
	private void updateForPrintData(int memberId, Recipe recipe) {

		if (recipe == null) {
			return;
		}

		ResultData actorCanModifyRd = actorCanModify(memberId, recipe.getId());
		recipe.setExtra__actorCanModify(actorCanModifyRd.isSuccess());

		ResultData actorCanDeleteRd = actorCanDelete(memberId, recipe.getId());
		recipe.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());
	}

	public ResultData actorCanModify(int memberId, int id) {

		// 레시피 찾기
		Recipe recipe = getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (recipe.getMemberId() != memberId) {
			return ResultData.from("F-B", "해당 레시피에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "수정가능합니다.", "recipe", recipe);
	}

	public ResultData actorCanDelete(int memberId, int id) {

		// 레시피 찾기
		Recipe recipe = getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (recipe.getMemberId() != memberId) {
			return ResultData.from("F-B", "해당 레시피에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "삭제가능합니다.");
	}

	// 레시피가 있을 경우 조회수 증가
	public ResultData increaseHitCount(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.increaseHitCount(id);

		return ResultData.from("S-1", "조회수가 1만큼 증가했습니다.");
	}

	// 조회수 가져오기
	public int getRecipeHitCount(int id) {

		return recipeRepository.getRecipeHitCount(id);
	}

	// 레시피가 있을 경우 좋아요 수 증가
	public ResultData increaseGoodRP(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.increaseGoodRP(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [좋아요]가 1만큼 증가했습니다.", id));
	}

	// 레시피가 있을 경우 좋아요 수 감소
	public ResultData decreaseGoodRP(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.decreaseGoodRP(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [좋아요]가 1만큼 감소했습니다.", id));
	}

	// 레시피가 있을 경우 스크랩 수 증가
	public ResultData increaseScrapPoint(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.increaseScrapPoint(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [스크랩]이 1만큼 증가했습니다.", id));

	}

	// 레시피가 있을 경우 좋아요 수 감소
	public ResultData decreaseScrapPoint(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.decreaseScrapPoint(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [스크랩]이 1만큼 감소했습니다.", id));

	}

	// 스크랩한 레시피
	public List<Recipe> getScrapRecipes(int memberId) {

		if (memberId == 0) {
			return null;
		}

		List<Recipe> recipes = recipeRepository.getScrapRecipes(memberId);

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;

	}
}
