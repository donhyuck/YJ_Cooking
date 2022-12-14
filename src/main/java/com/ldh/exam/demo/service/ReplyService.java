package com.ldh.exam.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.ReplyRepository;
import com.ldh.exam.demo.util.Ut;
import com.ldh.exam.demo.vo.Recipe;
import com.ldh.exam.demo.vo.Reply;
import com.ldh.exam.demo.vo.ResultData;

@Service
public class ReplyService {

	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}

	// 특정 댓글 가져오기
	public Reply getForPrintReply(int memberId, String relTypeCode, int id) {

		Reply reply = replyRepository.getForPrintReply(relTypeCode, id);

		updateForPrintData(memberId, reply);

		return reply;
	}

	// 댓글 목록 가져오기
	public List<Reply> getForPrintReplies(int memberId, String relTypeCode, int relId) {

		List<Reply> replies = replyRepository.getForPrintReplies(relTypeCode, relId);

		for (Reply reply : replies) {
			updateForPrintData(memberId, reply);
		}

		return replies;
	}

	// 댓글 등록하기
	public int writeReply(int memberId, String relTypeCode, String relId, String body) {

		replyRepository.writeReply(memberId, relTypeCode, relId, body);

		return replyRepository.getLastInsertId();
	}

	// 댓글 수정하기
	public void modifyReply(int id, String body) {

		replyRepository.modifyReply(id, body);
	}

	// 댓글 삭제하기
	public ResultData deleteReply(int id) {

		replyRepository.deleteReply(id);

		return ResultData.from("S-1", Ut.f("%d번 댓글을 삭제하였습니다.", id));
	}

	// 수정, 삭제 권한여부 업데이트
	private void updateForPrintData(int memberId, Reply reply) {

		if (reply == null) {
			return;
		}

		ResultData actorCanModifyRd = actorCanModify(memberId, reply.getId());
		reply.setExtra__actorCanModify(actorCanModifyRd.isSuccess());

		ResultData actorCanDeleteRd = actorCanDelete(memberId, reply.getId());
		reply.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());
	}

	public ResultData actorCanModify(int memberId, int id) {

		// 댓글 찾기
		Reply reply = getReplyById(id);

		if (reply == null) {
			return ResultData.from("F-A", Ut.f("%s번 댓글을 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (reply.getMemberId() != memberId) {
			return ResultData.from("F-B", "해당 댓글에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "수정가능합니다.", "reply", reply);
	}

	public ResultData actorCanDelete(int memberId, int id) {

		// 댓글 찾기
		Reply reply = getReplyById(id);

		if (reply == null) {
			return ResultData.from("F-A", Ut.f("%s번 댓글을 찾을 수 없습니다.", id));
		}

		// 작성자 권한 체크
		if (reply.getMemberId() != memberId) {
			return ResultData.from("F-B", "해당 댓글에 대한 권한이 없습니다.");
		}

		return ResultData.from("S-1", "삭제가능합니다.");
	}

	// 댓글 확인
	public Reply getReplyById(int id) {

		return replyRepository.getReplyById(id);
	}

	// 삭제 후 해당 레시피의 댓글 갯수 확인
	public int getReplyCntByRelId(int id) {

		return replyRepository.getReplyCntByRelId(id);
	}
}
