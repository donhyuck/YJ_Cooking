package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.BoardRepository;
import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;
import com.ldh.exam.demo.vo.ResultData;

@Service
public class BoardService {

	private BoardRepository boardRepository;

	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}

	public Board getBoardByBoardId(int id) {

		return boardRepository.getBoardByBoardId(id);
	}

	public List<Board> getBoards() {

		return boardRepository.getBoards();
	}

	public Category getCategoryByBoardIdAndRelId(int boardId, int relId) {

		return boardRepository.getCategoryByBoardIdAndRelId(boardId, relId);
	}

	public List<Category> getCategories() {

		return boardRepository.getCategories();
	}

	public ResultData getNowBoardName(int boardId) {

		String nowBoardName = "";

		// 상위분류 전체선택시
		if (boardId == 0) {
			nowBoardName = "전체";
			return ResultData.from("S-1", "상위분류 전체선택 입니다.", "nowBoardName", nowBoardName);
		}

		Board board = getBoardByBoardId(boardId);

		// 미등록된 상위분류 선택시
		if (board == null) {
			return ResultData.from("F-1", "등록되지 않은 상위분류내역입니다.");
		}

		// 상위분류 일반선택시
		nowBoardName = board.getBoardName();

		return ResultData.from("S-2", "선택된 상위분류내역입니다.", "nowBoardName", nowBoardName);
	}

	public ResultData getNowCategoryName(int boardId, int relId) {

		String nowCategoryName = "";

		// 일반 선택시
		if (getNowBoardName(boardId).getResultCode().equals("S-2")) {

			// 카테고리 전체선택시
			if (relId == 0) {
				nowCategoryName = "전체";
				return ResultData.from("S-1", "카테고리 전체선택 입니다.", "nowCategoryName", nowCategoryName);
			}

			Category category = getCategoryByBoardIdAndRelId(boardId, relId);

			// 미등록된 카테고리 선택시
			if (category == null) {
				return ResultData.from("F-1", "등록되지 않은 카테고리내역입니다.");
			}

			// 현재 카테고리 이름
			nowCategoryName = category.getName();
		}

		return ResultData.from("S-2", "선택된 카테고리내역입니다.", "nowCategoryName", nowCategoryName);
	}

	// 등록된 레시피의 가이드 설정
	public int makeGuideForWriteRecipe(int sortId, int methodId, int contentId, int freeId) {

		boardRepository.makeGuideForWriteRecipe(sortId, methodId, contentId, freeId);

		return boardRepository.getLastInsertId();
	}

	// 등록된 레시피 번호를 가이드로 갱신
	public void updateRecipeId(int guideId, int recipeId) {

		boardRepository.updateRecipeId(guideId, recipeId);
	}

}
