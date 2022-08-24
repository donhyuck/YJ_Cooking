package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.MemberRepository;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Member;
import com.ldh.exam.demo.vo.ResultData;

@Service
public class MemberService {

	private MemberRepository memberRepository;
	private AttrService attrService;

	public MemberService(MemberRepository memberRepository, AttrService attrService) {
		this.memberRepository = memberRepository;
		this.attrService = attrService;
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

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);
	}

	// 회원정보 수정하기
	public void doModify(int id, String loginPw, String nickname, String cellphoneNo, String email) {

		// 비밀번호 암호화
		loginPw = Ut.sha256(loginPw);

		memberRepository.doModify(id, loginPw, nickname, cellphoneNo, email);
	}

	// 등록번호로 회원 가져오기
	public Member getMemberById(int id) {

		return memberRepository.getMemberById(id);
	}

	// 아이디로 회원 가져오기
	public Member getMemberByLoginId(String loginId) {

		return memberRepository.getMemberByLoginId(loginId);
	}

	// 닉네임,이메일로 회원 가져오기
	public Member getMemberByNicknameAndEmail(String nickname, String email) {

		return memberRepository.getMemberByNicknameAndEmail(nickname, email);
	}

	// 인증코드 발급하기
	public String genAuthKey(int memberId) {

		String authKey = Ut.getTempPassword(10);

		// 생성된 배열을 인증코드로 설정
		attrService.setValue("member", memberId, "extra", "memberModifyAuthKey", authKey, Ut.getDateStrLater(60 * 5));

		return authKey;
	}

	// 인증코드 확인하기
	public ResultData checkAuthKey(int memberId, String authKey) {

		// 설정된 인증코드와 url접근과 비교
		String saved = attrService.getValue("member", memberId, "extra", "memberModifyAuthKey");

		if (saved.equals(authKey) == false) {
			return ResultData.from("F-1", "일치하지 않거나 만료되었습니다.");
		}

		return ResultData.from("S-1", "정상적인 코드입니다.");
	}
}
