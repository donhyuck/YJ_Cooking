package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Ingredient;
import com.ldh.exam.demo.vo.Recipe;

@Mapper
public interface RecipeRepository {

	public Recipe getRecipeById(int id);

	public Recipe getForPrintRecipe(int id);

	public Ingredient getIngredientByRecipeId(int recipeId);

	public List<Recipe> getForPrintRecipes();

	public List<Recipe> getRandomRecipes(int randomCount, int randomCountInAPage);

	public List<Recipe> getMoreSuggestRecipeByTabCode(int suggestCount, int tabCode);

	public List<Recipe> getRecentRecipes(int limitStart, int limitTake);

	public List<Recipe> getRecipesByGuideId(int boardId, int relId);

	public List<Recipe> getRankRecipes(int rankCount);

	public List<Recipe> getManyScrapRecipes(int manyScrapCount);

	public List<Recipe> getRegisteredRecipes(int memberId, int limitStart, int limitTake);

	public int getRegisteredRecipesCount(int memberId);

	public List<Recipe> getScrapRecipes(int memberId);

	public List<Recipe> getHaveReplyRecipes(int memberId);

	public void writeRecipe(int memberId, String title, String body, int amount, int time, int level, int guideId,
			int ingredientId, String tip);

	public int insertIngredient(String rowArr, String rowValueArr, String sauceArr, String sauceValueArr);

	public void updateRecipeIdForIngredient(int ingredientId, int recipeId);

	public void updateIngredient(int id, String rowArr, String rowValueArr, String sauceArr, String sauceValueArr);

	public void modifyRecipe(int id, String title, String body, int amount, int time, int level, String tip);

	public void deleteRecipe(int id);

	public List<Recipe> getSearchRecipes(String searchKeyword, String keywordType, String searchRange, String rangeType,
			String includeOption);

	public String getCookingOrderByRecipeId(int recipeId);

	public int getLastInsertId();

	public int increaseHitCount(int id);

	public int getRecipeHitCount(int id);

	public void increaseGoodRP(int id);

	public void decreaseGoodRP(int id);

	public void increaseScrapPoint(int id);

	public void decreaseScrapPoint(int id);
}
