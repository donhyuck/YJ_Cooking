package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Recipe;

@Mapper
public interface RecipeRepository {

	public Recipe getForPrintRecipe(int id);

	public List<Recipe> getForPrintRecipes();

	public void writeRecipe(int memberId, String title, String body);

	public void modifyRecipe(int id, String title, String body);

	public void deleteRecipe(int id);

	public int getLastInsertId();

	public Recipe getRecipeById(int id);

	public int increaseHitCount(int id);

	public int getRecipeHitCount(int id);

	public int actorCanMakeReaction(int memberId, int id);
}
