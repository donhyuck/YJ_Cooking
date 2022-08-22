package com.ldh.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReactionRepository {

	public int getReactionSumByRelId(int memberId, int relId, String relTypeCode);
}
