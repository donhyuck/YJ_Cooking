package com.ldh.exam.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.ldh.exam.demo.service.BoardService;
import com.ldh.exam.demo.service.GenFileService;
import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.service.ReactionService;
import com.ldh.exam.demo.service.RecipeService;
import com.ldh.exam.demo.service.ReplyService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Category;
import com.ldh.exam.demo.vo.CookingOrder;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.Reply;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
@RequestMapping("/user/recipe")
public class UserRecipeController {

	private RecipeService recipeService;
	private BoardService boardService;
	private MemberService memberService;
	private ReplyService replyService;
	private ReactionService reactionService;
	private GenFileService genFileService;
	private Rq rq;

	public UserRecipeController(RecipeService recipeService, BoardService boardService, MemberService memberService,
			ReplyService replyService, ReactionService reactionService, GenFileService genFileService, Rq rq) {
		this.recipeService = recipeService;
		this.boardService = boardService;
		this.memberService = memberService;
		this.replyService = replyService;
		this.reactionService = reactionService;
		this.genFileService = genFileService;
		this.rq = rq;
	}

	// 레시피 상세페이지 메서드
	@RequestMapping("/detail")
	public String showDetail(Model model, int id) {

		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), id);

		// 좋아요 가능여부
		ResultData actorCanLikeRd = reactionService.actorCanLike(rq.getLoginedMemberId(), id, "recipe");

		// 이미 리액션한 경우(F-1) 리액션 취소가능
		if (actorCanLikeRd.getResultCode().equals("F-1")) {
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

		// 특정 레시피에 대한 분류정보 가져오기
		List<Category> categoriesAboutRecipe = boardService.getCategoriesAboutRecipe(recipe.getGuideId());

		// 해당 레시피 페이지의 재료, 양념 목록 가져오기
		List<List<String>> IngredientList = recipeService.getIngredientById(recipe.getIngredientId());

		// 조리순서
		String orderBody = "";
		CookingOrder cookingOrder = recipeService.getCookingOrderByRecipeId(id);

		if (cookingOrder != null) {
			orderBody = cookingOrder.getOrderBody();
		}

		model.addAttribute("recipe", recipe);
		model.addAttribute("replies", replies);
		model.addAttribute("categoriesAboutRecipe", categoriesAboutRecipe);
		model.addAttribute("rows", IngredientList.get(0));
		model.addAttribute("rowValues", IngredientList.get(1));
		model.addAttribute("sauces", IngredientList.get(2));
		model.addAttribute("sauceValues", IngredientList.get(3));
		model.addAttribute("orderBody", orderBody);
		model.addAttribute("actorCanMakeRP", actorCanLikeRd.isSuccess());
		model.addAttribute("actorCanMakeScrap", actorCanScrapRd.isSuccess());

		return "user/recipe/detail";
	}

	// 레시피 등록 페이지 메서드
	@RequestMapping("/write")
	public String showWrite(Model model) {

		// 분류 선택시 카테고리 목록
		List<Category> categories = boardService.getCategories();
		model.addAttribute("categories", categories);

		return "user/recipe/write";
	}

	// 레시피 등록하기 메서드
	@RequestMapping("/doWrite")
	@ResponseBody
	public String doWrite(String title, String body, int amount, int time, int level, String tip,
			@RequestParam(defaultValue = "0") int sortId, @RequestParam(defaultValue = "0") int methodId,
			@RequestParam(defaultValue = "0") int contentId, @RequestParam(defaultValue = "0") int freeId,
			String rowArr, String rowValueArr, String sauceArr, String sauceValueArr, String orderBody,
			MultipartRequest multipartRequest, @RequestParam(defaultValue = "/") String replaceUri) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(title)) {
			return rq.jsHistoryBack("제목(을)를 입력해주세요.");
		}

		if (Ut.empty(body)) {
			return rq.jsHistoryBack("내용(을)를 입력해주세요.");
		}

		// 레시피 가이드 구성
		int guideId = boardService.makeGuideForWriteRecipe(sortId, methodId, contentId, freeId);

		// 재료, 양념 데이터 추가
		int ingredientId = recipeService.insertIngredient(rowArr, rowValueArr, sauceArr, sauceValueArr);

		// 레시피 등록하기
		int id = recipeService.writeRecipe(rq.getLoginedMemberId(), title, body, amount, time, level, guideId,
				ingredientId, tip);

		// 등록된 레시피 번호를 가이드, 재료양념으로 갱신
		boardService.updateRecipeId(guideId, id);
		recipeService.updateRecipeIdForIngredient(ingredientId, id);

		// 조리순서 등록
		recipeService.insertOrderAboutRecipe(id, orderBody);

		// 레시피 등록시 대표 이미지 등록
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, id);
			}
		}

		// 레시피 등록 후 이동
		return rq.jsReplace(Ut.f("%s번 레시피가 등록되었습니다.", id), Ut.f("../recipe/detail?id=%d", id));
	}

	// 레시피 수정 페이지 메서드
	@RequestMapping("/modify")
	public String showModify(Model model, int id) {

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanModifyRd = recipeService.actorCanModify(rq.getLoginedMemberId(), id);

		if (actorCanModifyRd.isFail()) {
			return rq.historyBackOnView(actorCanModifyRd.getMsg());
		}

		// 해당 레시피를 수정 페이지로 넘기기
		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), id);

		// 난이도 이름 넘기기
		String levelName = recipe.getForPrintLevel();

		// 해당 레시피 페이지의 재료, 양념 목록 가져오기
		List<List<String>> IngredientList = recipeService.getIngredientById(recipe.getIngredientId());

		// 특정 레시피에 대한 분류정보 가져오기(기존에 등록된 분류정보)
		List<Category> categoriesAboutRecipe = boardService.getCategoriesAboutRecipe(recipe.getGuideId());

		// 분류 선택시 카테고리 목록(새로 선택할 수 있도록 넘기는 분류정보)
		List<Category> categories = boardService.getCategories();

		model.addAttribute("recipe", recipe);
		model.addAttribute("levelName", levelName);
		model.addAttribute("rows", IngredientList.get(0));
		model.addAttribute("rowValues", IngredientList.get(1));
		model.addAttribute("sauces", IngredientList.get(2));
		model.addAttribute("sauceValues", IngredientList.get(3));
		model.addAttribute("categoriesAboutRecipe", categoriesAboutRecipe);
		model.addAttribute("categories", categories);

		return "user/recipe/modify";
	}

	// 레시피 수정하기 메서드
	@RequestMapping("/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body, int amount, int time,
			@RequestParam(defaultValue = "0") int level, String tip, @RequestParam(defaultValue = "0") int sortId,
			@RequestParam(defaultValue = "0") int methodId, @RequestParam(defaultValue = "0") int contentId,
			@RequestParam(defaultValue = "0") int freeId, String rowArr, String rowValueArr, String sauceArr,
			String sauceValueArr, MultipartRequest multipartRequest,
			@RequestParam(defaultValue = "/") String replaceUri) {

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

		Recipe recipe = recipeService.getRecipeById(id);

		// 레시피 가이드 갱신
		boardService.updateGuide(recipe.getGuideId(), sortId, methodId, contentId, freeId);

		// 재료, 양념 갱신
		recipeService.updateIngredient(recipe.getIngredientId(), rowArr, rowValueArr, sauceArr, sauceValueArr);

		// 레시피 등록시 대표 이미지 등록
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, id);
			}
		}

		// 레시피 수정하기
		recipeService.modifyRecipe(id, title, body, amount, time, level, tip);

		return rq.jsReplace(Ut.f("%s번 레시피가 수정되었습니다.", id), replaceUri);
	}

	// 레시피 삭제하기 메서드
	@RequestMapping("/doDelete")
	@ResponseBody
	public String doDelete(int id, @RequestParam(defaultValue = "/") String replaceUri) {

		// 레시피 찾기, 작성자 권한 체크
		ResultData actorCanDeleteRd = recipeService.actorCanDelete(rq.getLoginedMemberId(), id);

		if (actorCanDeleteRd.isFail()) {
			return rq.jsHistoryBack(actorCanDeleteRd.getMsg());
		}

		// 삭제처리
		recipeService.deleteRecipe(id);

		return rq.jsReplace(Ut.f("%s번 레시피가 삭제되었습니다.", id), replaceUri);
	}

	// 레시피 상세보기시 조회수 증가
	@RequestMapping("/doIncreaseHitCount")
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
