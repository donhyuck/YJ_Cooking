package com.ldh.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyRepository {

	public void writeReply(int memberId, String relTypeCode, String relId, String body);

	public int getLastInsertId();

}
