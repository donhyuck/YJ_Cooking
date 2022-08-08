package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Recipe;

@Mapper
public interface RecipeRepository {

	public Recipe getRecipe(int id);

	public List<Recipe> getRecipes();

	public void writeRecipe(String title, String body);

	public void modifyRecipe(int id, String title, String body);

	public void deleteRecipe(int id);

	public int getLastInsertId();

}
