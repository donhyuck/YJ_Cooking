package com.ldh.exam.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.BoardService;
import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.service.ReactionService;
import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.service.ReplyService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Board;
import com.ldh.exam.demo.vo.Category;
import com.ldh.exam.demo.vo.Guide;
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
	public String showSuggestList(Model model) {

		List<Recipe> recipes = recipeService.getForPrintRecipes(rq.getLoginedMemberId());
		model.addAttribute("recipes", recipes);

		return "user/list/suggest";
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
	public String showChoice(Model model, int boardId, int relId) {

		// 분류 이름
		String boardName = boardService.getBoardByBoardId(boardId).getBoardName();

		// 분류페이지에서 선택한 레시피 목록 가져오기
		List<Recipe> choicedRecipes = recipeService.getRecipesByGuideId(boardId, relId);

		model.addAttribute("boardName", boardName);
		model.addAttribute("choicedRecipes", choicedRecipes);

		return "user/list/choice";
	}

	// 레시피 랭킹목록 페이지 메서드
	@RequestMapping("/user/list/rank")
	public String showRankList(Model model) {

		List<Recipe> recipes = recipeService.getForPrintRecipes(rq.getLoginedMemberId());
		model.addAttribute("recipes", recipes);

		return "user/list/rank";
	}

	// 레시피 노트목록 페이지 메서드
	@RequestMapping("/user/list/note")
	public String showNoteList(Model model) {

		List<Recipe> recipes = recipeService.getForPrintRecipes(rq.getLoginedMemberId());
		model.addAttribute("recipes", recipes);

		// 스크랩한 레시피 목록
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
	public String doWrite(String title, String body, String replaceUri) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return rq.jsHistoryBack("제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return rq.jsHistoryBack("내용(을)를 입력해주세요.");
		}

		// 레시피 등록하기
		int id = recipeService.writeRecipe(rq.getLoginedMemberId(), title, body);

		// 레시피 등록 후 이동
		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../recipe/detail?id=%d", id);
		}

		return rq.jsReplace(Ut.f("%s번 레시피가 등록되었습니다.", id), replaceUri);
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
