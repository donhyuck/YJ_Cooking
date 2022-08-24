package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	public List<Reply> getForPrintReplies(String relTypeCode, int relId);

	public void writeReply(int memberId, String relTypeCode, String relId, String body);

	public int getLastInsertId();

}