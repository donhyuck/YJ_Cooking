package com.ldh.exam.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.BoardService;
import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.service.ReactionService;
import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.service.ReplyService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.Reply;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserRecipeController {

	private RecipeService recipeService;
	private BoardService boardService;
	private MemberService memberService;
	private ReplyService replyService;
	private ReactionService reactionService;
	private Rq rq;

	public UserRecipeController(RecipeService recipeService, BoardService boardService, MemberService memberService,
			ReplyService replyService, ReactionService reactionService, Rq rq) {
		this.recipeService = recipeService;
		this.boardService = boardService;
		this.memberService = memberService;
		this.replyService = replyService;
		this.reactionService = reactionService;
		this.rq = rq;
	}

	// 레시피 추천목록 페이지 메서드
	@RequestMapping("/user/list/suggest")
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
	@RequestMapping("/user/list/moreSuggest")
	public String showMoreSuggest(Model model, @RequestParam(defaultValue = "1") int tabCode) {

		// 램덤 레시피 전체목록 가져오기
		int suggestCount = 52;

		List<Recipe> moreSuggestRecipes = recipeService.getMoreSuggestRecipeByTabCode(rq.getLoginedMemberId(),
				suggestCount, tabCode);

		model.addAttribute("moreSuggestRecipes", moreSuggestRecipes);

		return "user/list/moreSuggest";
	}

	// 레시피 분류목록 페이지 메서드
	@RequestMapping("/user/list/category")
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
	@RequestMapping("/user/list/choice")
	public String showChoice(Model model, @RequestParam(defaultValue = "-1") int boardId,
			@RequestParam(defaultValue = "-1") int relId) {

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
	@RequestMapping("/user/list/rank")
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
	@RequestMapping("/user/list/note")
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

	// 레시피 상세페이지 메서드
	@RequestMapping("/user/recipe/detail")
	public String showDetail(Model model, int id) {

		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), id);

		// 좋아요 가능여부
		ResultData actorCanReactionRd = reactionService.actorCanReaction(rq.getLoginedMemberId(), id, "recipe");

		// 이미 리액션한 경우(F-1) 리액션 취소가능
		if (actorCanReactionRd.getResultCode().equals("F-1")) {
			model.addAttribute("actorCanCancelRP", true);
		}

		// 스크랩 가능여부
		ResultData actorCanScrapRd = reactionService.actorCanScrap(rq.getLoginedMemberId(), id, "recipe");

		// 이미 스크랩한 경우(F-1) 스크랩 취소가능
		if (actorCanScrapRd.getResultCode().equals("F-1")) {
			model.addAttribute("actorCanCancelScrap", true);
		}

		// 해당 레시피 페이지의 댓글 목록 가져오기
		List<Reply> replies = replyService.getForPrintReplies(rq.getLoginedMemberId(), "recipe", id);

		model.addAttribute("recipe", recipe);
		model.addAttribute("replies", replies);
		model.addAttribute("actorCanMakeRP", actorCanReactionRd.isSuccess());
		model.addAttribute("actorCanMakeScrap", actorCanScrapRd.isSuccess());

		return "user/recipe/detail";
	}

	// 레시피 등록 페이지 메서드
	@RequestMapping("/user/recipe/write")
	public String showWrite() {

		return "user/recipe/write";
	}

	// 레시피 등록하기 메서드
	@RequestMapping("/user/recipe/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, int amount, int time, int level, String tip,
			@RequestParam(defaultValue = "/") String replaceUri) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return rq.jsHistoryBack("제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return rq.jsHistoryBack("내용(을)를 입력해주세요.");
		}
		
		// 레시피 등록하기
//		int id = recipeService.writeRecipe(rq.getLoginedMemberId(), title, body);

		// 레시피 등록 후 이동

		return null;
	}

	// 레시피 수정 페이지 메서드
	@RequestMapping("/user/recipe/modify")
	public String showModify(Model model, int id) {

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanModifyRd = recipeService.actorCanModify(rq.getLoginedMemberId(), id);

		if (actorCanModifyRd.isFail()) {
			return rq.historyBackOnView(actorCanModifyRd.getMsg());
		}

		// 해당 레시피를 수정 페이지로 넘기기
		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), id);

		model.addAttribute("recipe", recipe);

		return "user/recipe/modify";
	}

	// 레시피 수정하기 메서드
	@RequestMapping("/user/recipe/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return rq.jsHistoryBack("제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return rq.jsHistoryBack("내용(을)를 입력해주세요.");
		}

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanModifyRd = recipeService.actorCanModify(rq.getLoginedMemberId(), id);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBack(actorCanModifyRd.getMsg());
		}

		// 레시피 수정하기
		recipeService.modifyRecipe(id, title, body);

		return rq.jsReplace(Ut.f("%s번 레시피가 수정되었습니다.", id), Ut.f("../recipe/detail?id=%d", id));
	}

	// 레시피 삭제하기 메서드
	@RequestMapping("/user/recipe/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanDeleteRd = recipeService.actorCanDelete(rq.getLoginedMemberId(), id);

		if (actorCanDeleteRd.isFail()) {
			return rq.jsHistoryBack(actorCanDeleteRd.getMsg());
		}

		// 삭제처리
		recipeService.deleteRecipe(id);

		return rq.jsReplace(Ut.f("%s번 레시피가 삭제되었습니다.", id), "/");
	}

	// 레시피 찾기, 조회수 증가
	@RequestMapping("/user/recipe/doIncreaseHitCount")
	@ResponseBody
	public ResultData<Integer> doIncreaseHitCount(int id) {

		ResultData<Integer> increaseHitCountRd = recipeService.increaseHitCount(id);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData<Integer> newDataRd = ResultData.newData(increaseHitCountRd, "hitCount",
				recipeService.getRecipeHitCount(id));

		newDataRd.setData2("id", id);

		return newDataRd;
	}
}
