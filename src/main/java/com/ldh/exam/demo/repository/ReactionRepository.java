package com.ldh.exam.demo.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReactionRepository {

	public int getReactionSumByRelId(int memberId, int relId, String relTypeCode);

	public void doMakeLike(int memberId, int relId, String relTypeCode);

	public void doCancelLike(int memberId, int relId, String relTypeCode);

	public int getScrapSumByRelId(int memberId, int relId, String relTypeCode);

	public void doMakeScrap(int memberId, int relId, String relTypeCode);

	public void doCancelScrap(int memberId, int relId, String relTypeCode);
}
