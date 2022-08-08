package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.ldh.exam.demo.vo.Recipe;

@Mapper
public interface RecipeRepository {

	@Select("SELECT * FROM recipe WHERE id = #{id}")
	public Recipe getRecipe(int id);

	@Select("SELECT * FROM recipe ORDER BY id DESC")
	public List<Recipe> getRecipes();

	@Insert("INSERT INTO recipe SET regDate = NOW(), updateDate = NOW(), title = #{title}, `body` = #{body}")
	public Recipe writeRecipe(String title, String body);

	@Update("UPDATE recipe SET updateDate = NOW(), title = #{title}, `body` = #{body} WHERE id = #{id}")
	public void modifyRecipe(int id, String title, String body);

	@Delete("DELETE FROM recipe WHERE id = #{id}")
	public void deleteRecipe(int id);

}
