package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.MailService;
import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Member;
import com.ldh.exam.demo.vo.ResultData;
import com.ldh.exam.demo.vo.Rq;

@Controller
public class UserMemberController {

	private MemberService memberService;
	private MailService mailService;
	private Rq rq;

	public UserMemberController(MemberService memberService, MailService mailService, Rq rq) {
		this.memberService = memberService;
		this.mailService = mailService;
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
			return rq.jsHistoryBack("아이디(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호(을)를 입력해주세요.");
		}

		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("닉네임(을)를 입력해주세요.");
		}

		if (Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("연락처(을)를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return rq.jsHistoryBack("이메일(을)를 입력해주세요.");
		}

		// 회원 등록하기
		ResultData<Integer> joinMemberRd = memberService.doJoin(loginId, loginPw, nickname, cellphoneNo, email);

		// 아이디 또는 닉네임, 이메일 중복 확인
		if (joinMemberRd.isFail()) {
			return rq.jsHistoryBack(joinMemberRd.getMsg());
		}

		return rq.jsReplace(Ut.f("%s 님의 회원등록이 완료되었습니다.", nickname), "/");
	}

	// 회원 로그인 페이지 메서드
	@RequestMapping("/user/member/login")
	public String showLogin() {

		return "user/member/login";
	}

	// 회원 로그인 메서드
	@RequestMapping("/user/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {

		// 로그인 확인
		if (rq.isLogined() == true) {
			return rq.jsHistoryBack("이미 로그인 중입니다.");
		}

		// 입력 데이터 유효성 검사
		if (Ut.empty(loginId)) {
			return rq.jsHistoryBack("아이디(을)를 입력해주세요.");
		}

		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호(을)를 입력해주세요.");
		}

		// 회원정보 가져오기
		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return rq.jsReplace("등록되지 않은 회원입니다.", "/user/member/login");
		}

		if (member.getLoginPw().equals(Ut.sha256(loginPw)) == false) {
			return rq.jsReplace("잘못된 비밀번호입니다.", "/user/member/login");
		}

		// 로그인 하기
		rq.login(member);

		return rq.jsReplace(Ut.f("%s님 환영합니다.", member.getNickname()), afterLoginUri);
	}

	// 회원 로그아웃 메서드
	@RequestMapping("/user/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {

		// 로그아웃 확인
		if (rq.isLogined() == false) {
			return rq.jsHistoryBack("이미 로그아웃 중입니다.");
		}

		// 로그아웃 하기
		rq.logout();

		return rq.jsReplace("로그아웃되었습니다.", afterLogoutUri);
	}

	// My홈 페이지 메서드
	@RequestMapping("/user/member/myPage")
	public String showMyPage() {

		return "user/member/myPage";
	}

	// 비밀번호 확인 페이지 메서드
	@RequestMapping("/user/member/checkPassword")
	public String showCheckPW() {

		return "user/member/checkPassword";
	}

	// 비밀번호 확인 메서드
	@RequestMapping("/user/member/doCheckPassword")
	@ResponseBody
	public String doCheckPassword(String loginPw, String replaceUri) {

		// 입력데이터 유효성 검사
		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("비밀번호(을)를 입력해주세요.");
		}

		// 비밀번호 확인하기
		if (rq.getLoginedMember().getLoginPw().equals(Ut.sha256(loginPw)) == false) {
			return rq.jsHistoryBack("잘못된 비밀번호 입니다.");
		}

		// 비밀번호 확인에 대한 인증코드 발급
		if (replaceUri.equals("../member/modify")) {
			String authKeyForModify = memberService.genAuthKey(rq.getLoginedMemberId());

			replaceUri += "?memberModifyAuthKey=" + authKeyForModify;
		}

		return rq.jsReplace("", replaceUri);
	}

	// 회원정보 수정 페이지 메서드
	@RequestMapping("/user/member/modify")
	public String showModify(String memberModifyAuthKey) {

		// 인증코드가 없으면 재접근 요청
		if (Ut.empty(memberModifyAuthKey)) {
			return rq.historyBackOnView("비밀번호 확인이 안되었습니다. 다시 시도해주세요.");
		}

		// 인증코드 확인
		ResultData checkMemberModifyAuthKeyRd = memberService.checkAuthKey(rq.getLoginedMemberId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.historyBackOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		return "user/member/modify";
	}

	// 회원 수정하기 메서드
	@RequestMapping("/user/member/doModify")
	@ResponseBody
	public String doModify(String memberModifyAuthKey, String loginPw, String nickname, String cellphoneNo,
			String email) {

		// 인증코드가 없으면 재접근 요청
		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBack("비밀번호 확인이 안되었습니다. 다시 시도해주세요.");
		}

		// 인증코드 확인
		ResultData checkMemberModifyAuthKeyRd = memberService.checkAuthKey(rq.getLoginedMemberId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBack(checkMemberModifyAuthKeyRd.getMsg());
		}

		// 입력 데이터 유효성 검사
		if (Ut.empty(loginPw)) {
			loginPw = null;
		}

		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("닉네임(을)를 입력해주세요.");
		}

		if (Ut.empty(cellphoneNo)) {
			return rq.jsHistoryBack("연락처(을)를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return rq.jsHistoryBack("이메일(을)를 입력해주세요.");
		}

		// 회원 수정하기
		memberService.doModify(rq.getLoginedMemberId(), loginPw, nickname, cellphoneNo, email);

		// 로그아웃
		rq.logout();

		return rq.jsReplace(Ut.f("%s 님의 회원정보가 수정되었습니다. 다시 로그인해주세요.", nickname), "/user/member/login");
	}

	// 아이디 찾기 페이지 메서드
	@RequestMapping("/user/member/findLoginId")
	public String showFindLoginId() {

		return "user/member/findLoginId";
	}

	// 아이디 찾기 메서드
	@RequestMapping("/user/member/doFindLoginId")
	@ResponseBody
	public String doFindLoginId(String nickname, String email,
			@RequestParam(defaultValue = "/") String afterFindLoginIdUri) {

		// 로그인 확인
		if (rq.isLogined() == true) {
			return rq.jsHistoryBack("이미 로그인 중입니다.");
		}

		// 입력 데이터 유효성 검사
		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("닉네임(을)를 입력해주세요.");
		}

		if (Ut.empty(email)) {
			return rq.jsHistoryBack("이메일(을)를 입력해주세요.");
		}

		// 닉네임과 이메일로 회원정보 가져오기
		Member member = memberService.getMemberByNicknameAndEmail(nickname, email);

		// 찾기 실패시 uri가 중복되지 않도록 replace
		if (member == null) {
			return rq.jsReplace("등록되지 않은 회원이거나 잘못된 정보입니다.", rq.getFindLoginIdUri());
		}

		return rq.jsReplace(Ut.f("등록된 아이디 [%s] 입니다. 로그인 페이지로 이동합니다.", member.getLoginId()), "/user/member/login");
	}

	// 비밀번호 찾기 페이지 메서드
	@RequestMapping("/user/member/findLoginPw")
	public String showFindLoginPw() {

		return "user/member/findLoginPw";
	}
}
