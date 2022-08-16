package com.ldh.exam.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Member;
import com.ldh.exam.demo.vo.ResultData;

@Controller
public class UserMemberController {

	private MemberService memberService;

	public UserMemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	// 회원등록 페이지 보기 메서드
	@RequestMapping("/user/member/join")
	public String join() {
		return "user/member/join";
	}

	// 회원 등록하기 메서드
	@RequestMapping("/user/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String nickname, String cellphoneNo, String email) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("아이디(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("비밀번호(을)를 입력해주세요.");
		}

		if (Ut.empty(nickname)) {
			return Ut.jsHistoryBack("닉네임(을)를 입력해주세요.");
		}

		if (Ut.empty(cellphoneNo)) {
			return Ut.jsHistoryBack("연락처(을)를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return Ut.jsHistoryBack("이메일(을)를 입력해주세요.");
		}

		// 회원 등록하기
		ResultData<Integer> joinMemberRd = memberService.doJoin(loginId, loginPw, nickname, cellphoneNo, email);

		// 아이디 또는 닉네임, 이메일 중복 확인
		if (joinMemberRd.isFail()) {
			return Ut.jsHistoryBack(joinMemberRd.getMsg());
		}

		// 등록된 회원정보 가져오기
		Member member = memberService.getMemberById((int) joinMemberRd.getData1());

		return Ut.jsReplace(Ut.f("%s 님의 회원등록이 완료되었습니다.", member.getNickname()), "/");
	}

	// 회원 로그인 메서드
	@RequestMapping("/user/member/doLogin")
	@ResponseBody
	public ResultData<Member> doLogin(HttpSession httpSession, String loginId, String loginPw) {

		// 로그인 확인, 세션접근
		boolean isLogined = false;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
		}

		if (isLogined == true) {
			return ResultData.from("F-A", "이미 로그인 중입니다.");
		}

		// 입력 데이터 유효성 검사
		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "아이디(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return ResultData.from("F-2", "비밀번호(을)를 입력해주세요.");
		}

		// 회원정보 가져오기
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return ResultData.from("F-B", "등록되지 않은 회원입니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return ResultData.from("F-C", "잘못된 비밀번호입니다.");
		}

		// 등록된 회원으로 로그인 하기
		httpSession.setAttribute("loginedMemberId", member.getId());

		return ResultData.from("S-1", Ut.f("%s님 환영합니다.", member.getNickname()));
	}

	// 회원 로그아웃 메서드
	@RequestMapping("/user/member/doLogout")
	@ResponseBody
	public ResultData<Member> doLogout(HttpSession httpSession) {

		// 로그아웃 확인, 세션접근
		boolean isLogined = false;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
		}

		if (isLogined == false) {
			return ResultData.from("S-A", "이미 로그아웃 중입니다.");
		}

		// 로그아웃 하기
		httpSession.removeAttribute("loginedMemberId");

		return ResultData.from("S-B", "로그아웃되었습니다.");
	}

	// My홈 보기 메서드
	@RequestMapping("/user/member/myPage")
	public String showMyPage() {

		return "user/member/myPage";
	}
}
