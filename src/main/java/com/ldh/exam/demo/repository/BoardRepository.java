package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;
import com.ldh.exam.demo.vo.Guide;

@Mapper
public interface BoardRepository {

	public Board getBoardByBoardId(int id);

	public List<Board> getBoards();

	public Category getCategoryByBoardIdAndRelId(int boardId, int relId);

	public List<Category> getCategories();

	public void makeGuide(int recipeId, int sortId, int methodId, int contentId, int freeId);

	public int getLastInsertId();

	public void updateRecipeId(int guideId, int recipeId);

	public void updateGuide(int id, int sortId, int methodId, int contentId, int freeId);

	public List<Category> getCategoriesAboutRecipe(int recipeId);

}
