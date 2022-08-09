package com.ldh.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.ldh.exam.demo.vo.Member;

@Mapper
public interface MemberRepository {

	public void doJoin(String loginId, String loginPw, String nickname, String cellphoneNo, String email);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	public Member getMemberById(int id);

	public Member getMemberByLoginId(String loginId);

	public Member getMemberByNicknameAndEmail(String nickname, String email);

}
