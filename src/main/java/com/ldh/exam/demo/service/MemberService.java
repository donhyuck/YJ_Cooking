package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.MemberRepository;
import com.ldh.exam.demo.vo.Member;

@Service
public class MemberService {

	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	// 회원 등록하기
	public int doJoin(String loginId, String loginPw, String nickname, String cellphoneNo, String email) {

		memberRepository.doJoin(loginId, loginPw, nickname, cellphoneNo, email);

		return memberRepository.getLastInsertId();
	}

	public Member getMemberById(int id) {
		
		return memberRepository.getMemberById(id);
	}
}
