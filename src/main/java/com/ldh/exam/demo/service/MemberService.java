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

		Member oldMember;

		// 아이디 중복 검사
		oldMember = getMemberByLoginId(loginId);

		if (oldMember != null) {
			return -1;
		}

		// 닉네임, 이메일 중복 검사
		oldMember = getMemberByNicknameAndEmail(nickname, email);

		if (oldMember != null) {
			return -2;
		}

		// 중복사항이 없을 경우, 가입처리
		memberRepository.doJoin(loginId, loginPw, nickname, cellphoneNo, email);

		return memberRepository.getLastInsertId();
	}

	public Member getMemberById(int id) {

		return memberRepository.getMemberById(id);
	}

	private Member getMemberByLoginId(String loginId) {

		return memberRepository.getMemberByLoginId(loginId);
	}

	private Member getMemberByNicknameAndEmail(String nickname, String email) {

		return memberRepository.getMemberByNicknameAndEmail(nickname, email);
	}
}
