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

	// 특정 분류 가져오기
	public Board getBoardByBoardId(int id) {

		return boardRepository.getBoardByBoardId(id);
	}

	// 분류 목록 가져오기
	public List<Board> getBoards() {

		return boardRepository.getBoards();
	}

	// 특정 카테고리 가져오기
	public Category getCategoryByBoardIdAndRelId(int boardId, int relId) {

		return boardRepository.getCategoryByBoardIdAndRelId(boardId, relId);
	}

	// 카테고리 목록 가져오기
	public List<Category> getCategories() {

		return boardRepository.getCategories();
	}

	// 전체 선택을 고려한 분류이름 가져오기
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

	// 전체 선택을 고려한 카테고리이름 가져오기
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

	// 레시피 등록을 위한 가이드 생성
	public int makeGuide(int recipeId, int sortId, int methodId, int contentId, int freeId) {

		boardRepository.makeGuide(recipeId, sortId, methodId, contentId, freeId);

		return boardRepository.getLastInsertId();
	}

	// 등록된 가이드 정보를 갱신
	public void updateGuide(int id, int sortId, int methodId, int contentId, int freeId) {

		boardRepository.updateGuide(id, sortId, methodId, contentId, freeId);
	}

	// 특정 레시피에 대한 분류정보 가져오기
	public List<Category> getCategoriesAboutRecipe(int recipeId) {

		return boardRepository.getCategoriesAboutRecipe(recipeId);
	}

	// 레시피 삭제시 해당 가이드 삭제
	public void deleteGuide(int recipeId) {
		
		boardRepository.deleteGuide(recipeId);
	}

}
