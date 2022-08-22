package com.ldh.exam.demo.service;

import org.springframework.stereotype.Service;

import com.ldh.exam.demo.repository.ReactionRepository;

@Service
public class ReactionService {

	private ReactionRepository reactionRepository;

	public ReactionService(ReactionRepository reactionRepository) {
		this.reactionRepository = reactionRepository;
	}

	// 좋아요가 없으면 리액션 가능
	public boolean actorCanReaction(int memberId, int relId, String relTypeCode) {

		if (memberId == 0) {
			return false;
		}

		return reactionRepository.getReactionSumByRelId(memberId, relId, relTypeCode) == 0;
	}

}
