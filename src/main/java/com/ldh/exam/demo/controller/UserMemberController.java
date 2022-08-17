package com.ldh.exam.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Member;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserMemberController {

	private MemberService memberService;
	private Rq rq;

	public UserMemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}

	// 회원등록 페이지 보기 메서드
	@RequestMapping("/user/member/join")
	public String showJoin() {
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

	// 회원 로그인 보기 메서드
	@RequestMapping("/user/member/login")
	public String showLogin() {

		return "user/member/login";
	}

	// 회원 로그인 메서드
	@RequestMapping("/user/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {

		// 로그인 확인
		if (rq.isLogined() == true) {
			return Ut.jsHistoryBack("이미 로그인 중입니다.");
		}

		// 입력 데이터 유효성 검사
		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("아이디(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("비밀번호(을)를 입력해주세요.");
		}

		// 회원정보 가져오기
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsReplace("등록되지 않은 회원입니다.", "/user/member/login");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsReplace("잘못된 비밀번호입니다.", "/user/member/login");
		}

		rq.login(member);

		return Ut.jsReplace(Ut.f("%s님 환영합니다.", member.getNickname()), "/");
	}

	// 회원 로그아웃 메서드
	@RequestMapping("/user/member/doLogout")
	@ResponseBody
	public String doLogout(HttpSession httpSession) {

		// 로그아웃 확인
		if (rq.isLogined() == false) {
			return Ut.jsHistoryBack("이미 로그아웃 중입니다.");
		}

		// 로그아웃 하기
		rq.logout();

		return Ut.jsReplace("로그아웃되었습니다.", "/");
	}

	// My홈 보기 메서드
	@RequestMapping("/user/member/myPage")
	public String showMyPage() {

		return "user/member/myPage";
	}
}
