package com.ldh.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberRepository {

	public void doJoin(String loginId, String loginPw, String nickname, String cellphoneNo, String email);

}
