package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.MemberRepository;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Member;
import com.ldh.exam.demo.vo.ResultData;

@Service
public class MemberService {

	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	// 회원 등록하기
	public ResultData<Integer> doJoin(String loginId, String loginPw, String nickname, String cellphoneNo,
			String email) {

		Member oldMember;

		// 아이디 중복 검사
		oldMember = getMemberByLoginId(loginId);

		if (oldMember != null) {
			return ResultData.from("F-1", Ut.f("입력하신 아이디는 [ %s ] 이미 사용중입니다.", loginId));
		}

		// 닉네임, 이메일 중복 검사
		oldMember = getMemberByNicknameAndEmail(nickname, email);

		if (oldMember != null) {
			return ResultData.from("F-2", Ut.f("입력하신 닉네임 [ %s ], 이메일 [ %s ] 은 이미 등록되었습니다.", nickname, email));
		}

		// 중복사항이 없을 경우, 가입처리
		memberRepository.doJoin(loginId, loginPw, nickname, cellphoneNo, email);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", id);
	}

	public Member getMemberById(int id) {

		return memberRepository.getMemberById(id);
	}

	public Member getMemberByLoginId(String loginId) {

		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMemberByNicknameAndEmail(String nickname, String email) {

		return memberRepository.getMemberByNicknameAndEmail(nickname, email);
	}
}
