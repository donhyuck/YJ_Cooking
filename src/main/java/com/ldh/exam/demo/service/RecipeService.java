package com.ldh.exam.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.RecipeRepository;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Ingredient;
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

	// 추천 - 램덤목록 가져오기
	public List<Recipe> getRandomRecipes(int memberId, int randomCount, int randomCountInAPage) {

		List<Recipe> recipes = recipeRepository.getRandomRecipes(randomCount, randomCountInAPage);

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;
	}

	// 추천 - 추천목록 더 가져오기
	public List<Recipe> getMoreSuggestRecipeByTabCode(int memberId, int suggestCount, int tabCode) {

		List<Recipe> recipes = recipeRepository.getMoreSuggestRecipeByTabCode(suggestCount, tabCode);

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;
	}

	// 추천 - 최근목록 가져오기
	public List<Recipe> getRecentRecipes(int memberId, int itemsCountInAPage, int page) {

		int limitStart = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;

		List<Recipe> recipes = recipeRepository.getRecentRecipes(limitStart, limitTake);

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;
	}

	// 분류 - 선택목록 가져오기
	public List<Recipe> getRecipesByGuideId(int boardId, int relId) {

		return recipeRepository.getRecipesByGuideId(boardId, relId);
	}

	// 랭킹 - 최다 하트, 조회수를 받은 레시피 목록 가져오기
	public List<Recipe> getRankRecipes(int memberId, int rankCount) {

		List<Recipe> recipes = recipeRepository.getRankRecipes(rankCount);

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;
	}

	// 랭킹 - 최다 스크랩된 레시피 목록 가져오기
	public List<Recipe> getManyScrapRecipes(int memberId, int manyScrapCount) {

		List<Recipe> recipes = recipeRepository.getManyScrapRecipes(manyScrapCount);

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;
	}

	// 노트 - 내가 등록한 레시피 목록
	public List<Recipe> getRegisteredRecipes(int memberId, int itemsCountInAPage, int page) {

		if (memberId == 0) {
			return null;
		}

		int limitStart = (page - 1) * itemsCountInAPage;
		int limitTake = itemsCountInAPage;

		List<Recipe> recipes = recipeRepository.getRegisteredRecipes(memberId, limitStart, limitTake);

		for (Recipe recipe : recipes) {
			updateForPrintData(memberId, recipe);
		}

		return recipes;
	}

	// 내가 등록한 레시피 갯수 가져오기
	public int getRegisteredRecipesCount(int memberId) {

		return recipeRepository.getRegisteredRecipesCount(memberId);
	}

	// 노트 - 내가 스크랩한 레시피 목록
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

	// 댓글 남긴 레시피 목록 가져오기
	public List<Recipe> getHaveReplyRecipes(int memberId) {

		return recipeRepository.getHaveReplyRecipes(memberId);
	}

	// 레시피 등록하기
	public int writeRecipe(int memberId, String title, String body, int amount, int time, int level, int guideId,
			String tip) {

		recipeRepository.writeRecipe(memberId, title, body, amount, time, level, guideId, tip);

		return recipeRepository.getLastInsertId();
	}

	// 재료, 양념 데이터 추가
	public int doInsertIngredient(String rowArr, String rowValueArr, String sauceArr, String sauceValueArr) {

		recipeRepository.doInsertIngredient(rowArr, rowValueArr, sauceArr, sauceValueArr);

		return recipeRepository.getLastInsertId();
	}

	// 재료, 양념 데이터를 레시피 번호 갱신
	public void updateRecipeIdForIngredient(int ingredientId, int recipeId) {

		recipeRepository.updateRecipeIdForIngredient(ingredientId, recipeId);
	}

	// 재료 항목 가져오기
	public List<String> getRowsById(int recipeId) {

		List<String> rows = new ArrayList<>();

		// 레시피에 해당하는 재료항목 가져오기
		Ingredient ingredient = recipeRepository.getIngredientByRecipeId(recipeId);
		
		String[] tempArrayForRows = ingredient.getRowArr().split(",");

		for (int i = 0; i < tempArrayForRows.length; i++) {
			rows.add(tempArrayForRows[i]);
		}

		return rows;
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

	// 수정권한 확인
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

	// 삭제권한 확인
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

	// 조회수 증가
	public ResultData increaseHitCount(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.increaseHitCount(id);

		return ResultData.from("S-1", "조회수가 1만큼 증가했습니다.");
	}

	// 특정 레시피 조회수 가져오기
	public int getRecipeHitCount(int id) {

		return recipeRepository.getRecipeHitCount(id);
	}

	// 좋아요 수 처리
	public ResultData increaseGoodRP(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.increaseGoodRP(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [좋아요]가 1만큼 증가했습니다.", id));
	}

	// 좋아요 수 취소
	public ResultData decreaseGoodRP(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.decreaseGoodRP(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [좋아요]가 1만큼 감소했습니다.", id));
	}

	// 스크랩 처리
	public ResultData increaseScrapPoint(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.increaseScrapPoint(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [스크랩]이 1만큼 증가했습니다.", id));

	}

	// 스크랩 취소
	public ResultData decreaseScrapPoint(int id) {

		Recipe recipe = recipeRepository.getRecipeById(id);

		if (recipe == null) {
			return ResultData.from("F-A", Ut.f("%s번 레시피를 찾을 수 없습니다.", id));
		}

		recipeRepository.decreaseScrapPoint(id);

		return ResultData.from("S-1", Ut.f("%d번 레시피 [스크랩]이 1만큼 감소했습니다.", id));

	}
}
