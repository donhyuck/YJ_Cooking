package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.ReplyRepository;
import com.ldh.exam.demo.vo.Reply;

@Service
public class ReplyService {

	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}

	// 댓글 목록 가져오기
	public List<Reply> getForPrintReplies(String relTypeCode, int relId) {

		return replyRepository.getForPrintReplies(relTypeCode, relId);
	}

	// 레시피 등록하기
	public int writeReply(int memberId, String relTypeCode, String relId, String body) {

		replyRepository.writeReply(memberId, relTypeCode, relId, body);

		return replyRepository.getLastInsertId();
	}

	// 레시피 수정하기
	public void modifyRecipe(int id, String title, String body) {

		// 구현중
	}

	// 레시피 삭제하기
	public void deleteRecipe(int id) {

		// 구현중
	}
}
