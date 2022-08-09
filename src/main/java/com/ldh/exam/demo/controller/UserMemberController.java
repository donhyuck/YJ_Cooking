package com.ldh.exam.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ldh.exam.demo.service.MemberService;

@Controller
public class UserMemberController {

	private MemberService memberService;

	public UserMemberController(MemberService memberService) {
		this.memberService = memberService;
	}

	// 회원 등록하기 메서드
	@RequestMapping("/user/member/doJoin")
	@ResponseBody
	public String doJoin() {

		return null;
	}
}
