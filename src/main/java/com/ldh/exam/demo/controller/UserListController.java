package com.ldh.exam.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ldh.exam.demo.service.BoardService;
import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
@RequestMapping("/user/list")
public class UserListController {

	private RecipeService recipeService;
	private BoardService boardService;
	private Rq rq;

	public UserListController(RecipeService recipeService, BoardService boardService, Rq rq) {
		this.recipeService = recipeService;
		this.boardService = boardService;
		this.rq = rq;
	}

	// 레시피 추천목록 페이지 메서드
	@RequestMapping("/suggest")
	public String showSuggestList(Model model, @RequestParam(defaultValue = "1") int page) {

		// 최근 등록된 레시피 목록 가져오기
		int recipesCount = 20; // 총 레시피 갯수
		int itemsCountInAPage = 4; // 한 페이지 당 갯수
		int pagesCount = (int) Math.ceil((double) recipesCount / itemsCountInAPage); // 페이지 갯수

		// 페이지에 해당하는 레시피 목록가져오기
		List<Recipe> recentRecipes = recipeService.getRecentRecipes(rq.getLoginedMemberId(), itemsCountInAPage, page);

		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("recipesCount", recipesCount);
		model.addAttribute("recentRecipes", recentRecipes);

		// 램덤 레시피 목록 가져오기
		int randomCount = 20;
		int randomCountInAPage = 3;

		List<Recipe> randomRecipes = recipeService.getRandomRecipes(rq.getLoginedMemberId(), randomCount,
				randomCountInAPage);

		model.addAttribute("randomRecipes", randomRecipes);

		return "user/list/suggest";
	}

	// 레시피 추천 전체목록 페이지 메서드
	@RequestMapping("/moreSuggest")
	public String showMoreSuggest(Model model, @RequestParam(defaultValue = "1") int tabCode) {

		// 램덤 레시피 전체목록 가져오기
		int suggestCount = 52;

		List<Recipe> moreSuggestRecipes = recipeService.getMoreSuggestRecipeByTabCode(rq.getLoginedMemberId(),
				suggestCount, tabCode);

		model.addAttribute("moreSuggestRecipes", moreSuggestRecipes);

		return "user/list/moreSuggest";
	}

	// 레시피 분류목록 페이지 메서드
	@RequestMapping("/category")
	public String showCategoryList(Model model) {

		// 대분류 가져오기, 종류, 재료, 방법..
		List<Board> boards = boardService.getBoards();

		// 중분류 가져오기
		List<Category> categories = boardService.getCategories();

		model.addAttribute("boards", boards);
		model.addAttribute("categories", categories);

		return "user/list/category";
	}

	// 분류페이지에서 선택한 레시피 목록 보기
	@RequestMapping("/choice")
	public String showChoice(Model model, @RequestParam(defaultValue = "0") int boardId,
			@RequestParam(defaultValue = "0") int relId) {

		// 해당 레시피 목록 확인
		if (boardId == -1 || relId == -1) {
			return rq.replaceUriOnView("잘못 선택되었습니다. 다시 시도하시거나 검색으로 찾아보세요.", "/user/list/category");
		}

		// 선택사항 초기화
		String nowBoardName = "";
		String nowCategoryName = "";

		ResultData<String> nowBoardNameRd = boardService.getNowBoardName(boardId);
		ResultData<String> nowCategoryNameRd = boardService.getNowCategoryName(boardId, relId);

		// 미등록된 상위분류 선택시
		if (nowBoardNameRd.isFail()) {
			return rq.historyBackOnView(nowBoardNameRd.getMsg());
		}

		// 상위분류 전체선택시
		if (nowBoardNameRd.getResultCode().equals("S-1")) {

			nowBoardName = nowBoardNameRd.getData1();
			nowCategoryName = nowBoardName;
		}

		// 상위분류 일반선택시
		if (nowBoardNameRd.getResultCode().equals("S-2")) {

			// 미등록된 카테고리 선택시
			if (nowCategoryNameRd.isFail()) {
				return rq.historyBackOnView(nowCategoryNameRd.getMsg());
			}

			// 카테고리 전체선택시 or 일반 선택
			if (nowCategoryNameRd.isSuccess()) {

				nowBoardName = nowBoardNameRd.getData1();
				nowCategoryName = nowCategoryNameRd.getData1();
			}
		}

		// 선택한 레시피 목록 가져오기
		List<Recipe> choicedRecipes = recipeService.getRecipesByGuideId(boardId, relId);

		if (choicedRecipes == null) {
			return rq.historyBackOnView("해당되는 레시피 목록을 찾을 수 없습니다.");
		}

		// 추가선택을 위한 리스트 가져오기
		List<Board> boards = boardService.getBoards();

		model.addAttribute("nowBoardName", nowBoardName);
		model.addAttribute("nowCategoryName", nowCategoryName);
		model.addAttribute("choicedRecipes", choicedRecipes);
		model.addAttribute("boards", boards);

		return "user/list/choice";
	}

	// 레시피 랭킹목록 페이지 메서드
	@RequestMapping("/rank")
	public String showRankList(Model model) {

		// 최다 하트, 조회수, 스크랩 수를 받은 레시피 목록 가져오기
		int rankCount = 10;
		List<Recipe> rankRecipes = recipeService.getRankRecipes(rq.getLoginedMemberId(), rankCount);

		// 최다 스크랩된 레시피 목록 가져오기
		int manyScrapCount = 10;
		List<Recipe> manyScrapRecipes = recipeService.getManyScrapRecipes(rq.getLoginedMemberId(), manyScrapCount);

		model.addAttribute("rankRecipes", rankRecipes);
		model.addAttribute("manyScrapRecipes", manyScrapRecipes);

		return "user/list/rank";
	}

	// 레시피 노트목록 페이지 메서드
	@RequestMapping("/note")
	public String showNoteList(Model model, @RequestParam(defaultValue = "1") int page) {

		// 내가 등록한 레시피 목록
		int registeredRecipesCount = recipeService.getRegisteredRecipesCount(rq.getLoginedMemberId()); // 총 레시피 갯수
		int itemsCountInAPage = 4; // 한 페이지 당 갯수
		int pagesCount = (int) Math.ceil((double) registeredRecipesCount / itemsCountInAPage); // 페이지 갯수

		// 페이지에 해당하는 레시피 목록가져오기
		List<Recipe> registeredRecipes = recipeService.getRegisteredRecipes(rq.getLoginedMemberId(), itemsCountInAPage,
				page);

		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("recipesCount", registeredRecipesCount);
		model.addAttribute("registeredRecipes", registeredRecipes);

		// 내가 스크랩한 레시피 목록
		List<Recipe> scrapRecipes = recipeService.getScrapRecipes(rq.getLoginedMemberId());
		model.addAttribute("scrapRecipes", scrapRecipes);

		return "user/list/note";
	}

	// 검색결과 페이지
	@RequestMapping("/search")
	public String showSearch(Model model, @RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "keywordTotal") String keywordType,
			@RequestParam(defaultValue = "") String searchRange, @RequestParam(defaultValue = "total") String rangeType,
			@RequestParam(defaultValue = "selectAll") String includeOption) {

		// 검색타입 이름
		String keywordTypeName = "";

		switch (keywordType) {
		case "keywordTotal":
			keywordTypeName = "전체";
			break;
		case "recipeTitle":
			keywordTypeName = "제목만";
			break;
		case "titleAndBody":
			keywordTypeName = "제목과 내용";
			break;
		case "recipeId":
			keywordTypeName = "등록번호";
			break;
		case "recipeWriter":
			keywordTypeName = "회원닉네임";
			break;
		default:
			keywordTypeName = "미선택";
		}

		// 검색분류 이름
		String rangeTypeName = "";

		switch (rangeType) {
		case "total":
			rangeTypeName = "전체";
			break;
		case "sort":
			rangeTypeName = "레시피종류";
			break;
		case "method":
			rangeTypeName = "요리방법";
			break;
		case "ingredient":
			rangeTypeName = "재료, 양념";
			break;
		case "free":
			rangeTypeName = "상황";
			break;
		default:
			rangeTypeName = "미선택";
		}

		// 제목,내용으로 레시피 검색
		List<Recipe> searchRecipes = recipeService.getSearchRecipes(searchKeyword, keywordType, searchRange, rangeType, includeOption);

		if (searchRecipes.size() == 0) {
			searchRecipes = null;
		}

		model.addAttribute("searchRecipes", searchRecipes);

		// 검색조건 넘기기
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("keywordType", keywordType);
		model.addAttribute("keywordTypeName", keywordTypeName);
		model.addAttribute("searchRange", searchRange);
		model.addAttribute("rangeType", rangeType);
		model.addAttribute("rangeTypeName", rangeTypeName);
		model.addAttribute("includeOption", includeOption);

		return "user/list/search";
	}
}
