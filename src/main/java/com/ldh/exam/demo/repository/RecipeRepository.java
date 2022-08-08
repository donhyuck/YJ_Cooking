package com.ldh.exam.demo.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.ldh.exam.demo.vo.Recipe;

@Component
public class RecipeRepository {

	private int recipeLastId;
	private List<Recipe> recipes;

	public RecipeRepository() {
		recipeLastId = 0;
		recipes = new ArrayList<>();
	}

	public void makeTestData() {

		for (int i = 1; i <= 10; i++) {
			String title = "제목" + i;
			String body = "내용" + i;

			writeRecipe(title, body);
		}
	}

	public Recipe getRecipe(int id) {

		for (Recipe recipe : recipes) {
			if (recipe.getId() == id) {
				return recipe;
			}
		}

		return null;
	}

	public List<Recipe> getRecipes() {

		return recipes;
	}

	public Recipe writeRecipe(String title, String body) {

		int id = recipeLastId + 1;
		Recipe recipe = new Recipe(id, title, body);

		recipes.add(recipe);
		recipeLastId = id;

		return recipe;
	}

	public void modifyRecipe(int id, String title, String body) {

		Recipe recipe = getRecipe(id);

		recipe.setTitle(title);
		recipe.setBody(body);

	}

	public void deleteRecipe(int id) {

		Recipe recipe = getRecipe(id);

		recipes.remove(id);
	}

}
