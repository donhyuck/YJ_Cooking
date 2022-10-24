package com.ldh.exam.demo.vo;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.util.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {

	@Getter
	private boolean isAjax;
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;

	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	private Map<String, String> paramMap;

	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService) {

		this.req = req;
		this.resp = resp;
		paramMap = Ut.getParamMap(req);

		this.session = req.getSession();

		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
		}

		if (loginedMemberId != 0) {
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;

		// 해당 요청이 ajax 요청인지 아닌지 체크
		String requestUri = req.getRequestURI();

		boolean isAjax = requestUri.endsWith("Ajax");

		if (isAjax == false) {
			if (paramMap.containsKey("ajax") && paramMap.get("ajax").equals("Y")) {
				isAjax = true;
			} else if (paramMap.containsKey("isAjax") && paramMap.get("isAjax").equals("Y")) {
				isAjax = true;
			}
		}
		if (isAjax == false) {
			if (requestUri.contains("/get")) {
				isAjax = true;
			}
		}

		this.isAjax = isAjax;
	}

	public void printHistoryBackJs(String msg) {

		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsHistoryBack(msg));

	}

	public void print(String str) {

		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void println(String str) {
		print(str + "\n");
	}

	public void login(Member member) {

		session.setAttribute("loginedMemberId", member.getId());
	}

	public boolean isNotLogined() {
		return !isLogined;
	}

	public void logout() {

		session.removeAttribute("loginedMemberId");
	}

	public boolean isAdmin() {
		if (isLogined == false) {
			return false;
		}

		return loginedMember.isAdmin();
	}

	public String historyBackOnView(String msg) {

		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);

		return "common/js";
	}

	public String replaceUriOnView(String msg, String replaceUri) {

		req.setAttribute("msg", msg);
		req.setAttribute("replaceUri", replaceUri);

		return "common/js";
	}

	public String jsHistoryBack(String msg) {

		resp.setContentType("text/html; charset=UTF-8");
		return Ut.jsHistoryBack(msg);
	}

	public String jsReplace(String msg, String uri) {

		resp.setContentType("text/html; charset=UTF-8");
		return Ut.jsReplace(msg, uri);
	}

	public String getCurrentUri() {

		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		if (queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}

	public String getEncodedCurrentUri() {
		return Ut.getUriEncoded(getCurrentUri());
	}

	public void printReplaceJs(String msg, String uri) {

		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplace(msg, uri));
	}

	public void printReplaceJsForConfirm(String goal, String msg, String uri) {

		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplaceForConfirm(goal, msg, uri));
	}

	public String getParamJsonStr() {
		return Ut.toJsonStr(paramMap);
	}

	public String getLoginUri() {

		return "/user/member/login?afterLoginUri=" + getAfterLoginUri();
	}

	public String getLogoutUri() {

		return "/user/member/doLogout?afterLogoutUri=" + getAfterLogoutUri();
	}

	public String getAfterLoginUri() {

		String requestUri = req.getRequestURI();
		String getAfterLoginUri = "";

		// 로그인 후 다시 돌아가는 url 반복되지 않도록
		switch (requestUri) {
		case "/user/member/login":
		case "/user/member/join":
		case "/user/member/findLoginId":
		case "/user/member/findLoginPw":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLoginUri", ""));
		}

		// 로그인 후 자동으로 리액션 처리가 되지 않도록
		switch (requestUri) {
		case "/user/reaction/doMakeLike":
		case "/user/reaction/doCancelLike":
		case "/user/reaction/doMakeScrap":
		case "/user/reaction/doCancelScrap":
			return "/user/recipe/detail?id=" + req.getParameter("relId");
		}

		return getEncodedCurrentUri();
	}

	public String getAfterLogoutUri() {

		String requestUri = req.getRequestURI();

		// 로그아웃 후 다시 돌아가는 url 반복되지 않도록
		switch (requestUri) {
		case "/user/member/doLogout":
		case "/user/member/myPage":
			return "";
		}

		return getEncodedCurrentUri();
	}

	public String getFindLoginIdUri() {
		return "/user/member/findLoginId?afterFindLoginIdUri=" + getAfterFindLoginIdUri();
	}

	public String getFindLoginPwUri() {
		return "/user/member/findLoginPw?afterFindLoginPwUri=" + getAfterFindLoginPwUri();
	}

	public String getAfterFindLoginIdUri() {

		String requestUri = req.getRequestURI();

		// 아이디 찾기 후 다시 돌아가는 url 반복되지 않도록
		switch (requestUri) {
		case "/user/member/login":
		case "/user/member/join":
		case "/user/member/findLoginId":
		case "/user/member/findLoginPw":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterFindLoginIdUri", ""));
		}

		return getEncodedCurrentUri();
	}

	public String getAfterFindLoginPwUri() {

		String requestUri = req.getRequestURI();

		// 비밀번호 찾기 후 다시 돌아가는 url 반복되지 않도록
		switch (requestUri) {
		case "/user/member/login":
		case "/user/member/join":
		case "/user/member/findLoginId":
		case "/user/member/findLoginPw":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterFindLoginPwUri", ""));
		}

		return getEncodedCurrentUri();
	}

	public String getRecipeDetailUriFromList(Recipe recipe) {

		return "/user/recipe/detail?id=" + recipe.getId() + "&listUri=" + getEncodedCurrentUri();
	}

	public String getJoinUri() {

		return "/user/member/join?afterJoinUri=" + getAfterJoinUri();
	}

	public String getAfterJoinUri() {

		String requestUri = req.getRequestURI();

		// 회원가입시 다시 돌아가는 url 반복되지 않도록
		switch (requestUri) {
		case "/user/member/login":
		case "/user/member/join":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterJoinUri", ""));
		}

		return getEncodedCurrentUri();
	}

	public boolean isLeaved(Member member) {

		if (member.isDelStatus()) {
			return true;
		}
		return false;
	}

	// 프로필이미지 가져오기
	public String getProfileImgUri(int membeId) {
		return "/common/genFile/file/member/" + membeId + "/extra/profileImg/1";
	}

	public String getProfileFallbackImgUri() {
		// return "https://via.placeholder.com/300/?text=*^_^*";
		return "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
	}

	// 프로필이미지 미등록시
	public String getProfileFallbackImgOnErrorHtml() {
		return "this.src = '" + getProfileFallbackImgUri() + "'";
	}

	public String getRemoveProfileImgIfNotExistsOnErrorHtmlAttr() {
		return "$(this).remove();";
	}

	// 레시피 대표이미지 가져오기
	public String getMainRecipeImgUri(int recipeId) {
		return "/common/genFile/file/recipe/" + recipeId + "/extra/mainRecipeImg/1";
	}

	public String getMainRecipeFallbackImgUri() {
		return "https://cdn.pixabay.com/photo/2018/05/21/12/37/restaurant-3418134_960_720.png";
	}

	// 레시피 대표이미지 미등록시
	public String getMainRecipeFallbackImgOnErrorHtml() {
		return "this.src = '" + getMainRecipeFallbackImgUri() + "'";
	}

	// 댓글 요리후기이미지 가져오기
	public String getReviewImgUri(int replyId) {
		return "/common/genFile/file/reply/" + replyId + "/extra/reviewImg/1";
	}

	public String getReviewFallbackImgUri() {
		return "https://via.placeholder.com/300/?text=...";
	}

	// 댓글 요리후기이미지 미등록시
	public String getReviewFallbackImgOnErrorHtml() {
		return "this.src = '" + getReviewFallbackImgUri() + "'";
	}

	// 레시피 조리순서이미지 가져오기
	public String getRecipeOrderImgUri(int recipeId, int fileNoCount) {
		return "/common/genFile/file/order/" + recipeId + "/extra/recipeOrderImg/"+ fileNoCount;
	}

	public String getOrderFallbackImgUri() {
		return "https://via.placeholder.com/300/?text=...";
	}

	// 레시피 조리순서이미지 미등록시
	public String getOrderFallbackImgOnErrorHtml() {
		return "this.src = '" + getOrderFallbackImgUri() + "'";
	}
}