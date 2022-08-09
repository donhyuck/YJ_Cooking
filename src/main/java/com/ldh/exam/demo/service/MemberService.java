package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.MemberRepository;

@Service
public class MemberService {

	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	// 회원 등록하기
	public void doJoin(String loginId, String loginPw, String nickname, String cellphoneNo, String email) {

		memberRepository.doJoin(loginId, loginPw, nickname, cellphoneNo, email);

	}
}
