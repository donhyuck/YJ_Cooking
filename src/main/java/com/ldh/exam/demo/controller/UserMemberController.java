package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.MemberService;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Member;

@Controller
public class UserMemberController {

	private MemberService memberService;

	public UserMemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	// 회원 등록하기 메서드
	@RequestMapping("/user/member/doJoin")
	@ResponseBody
	public Object doJoin(String loginId, String loginPw, String nickname, String cellphoneNo, String email) {

		// 입력 데이터 유효성 검사
		if (Ut.empty(loginId)) {
			return "아이디(을)를 입력해주세요.";
		}

		if (Ut.empty(loginPw)) {
			return "비밀번호(을)를 입력해주세요.";
		}

		if (Ut.empty(nickname)) {
			return "닉네임(을)를 입력해주세요.";
		}

		if (Ut.empty(cellphoneNo)) {
			return "연락처(을)를 입력해주세요.";
		}

		if (Ut.empty(email)) {
			return "이메일(을)를 입력해주세요.";
		}

		// 회원 등록하기
		int id = memberService.doJoin(loginId, loginPw, nickname, cellphoneNo, email);

		// 아이디 또는 닉네임, 이메일 중복 확인
		if (id == -1) {
			return Ut.f("입력하신 아이디는 [ %s ] 이미 사용중입니다.", loginId);
		}

		if (id == -2) {
			return Ut.f("입력하신 이름 [ %s ], 이메일 [ %s ] 은 이미 등록되었습니다.", nickname, email);
		}

		// 등록된 회원정보 가져오기
		Member member = memberService.getMemberById(id);

		return member;
	}
}
