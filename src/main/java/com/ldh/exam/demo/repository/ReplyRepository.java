package com.ldh.exam.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ldh.exam.demo.vo.Reply;

@Mapper
public interface ReplyRepository {

	public Reply getForPrintReply(String relTypeCode, int id);

	public List<Reply> getForPrintReplies(String relTypeCode, int relId);

	public void writeReply(int memberId, String relTypeCode, String relId, String body);

	public int getLastInsertId();

	public Reply getReplyById(int id);

	public void deleteReply(int id);

}
