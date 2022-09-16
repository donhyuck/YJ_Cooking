<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세페이지" />
<%@include file="../common/head.jspf"%>

<!-- 게시글 조회수 스크립트 시작 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function RecipeDetail__increaseHitCount() {
		<!-- 이미 읽은 레시피는 조회수 증가 요청이 없도록 -->
		/*
		const localStorageKey = 'recipe__' + params.id + '__viewDone';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);
		*/
		
		<!-- 조회수 증가 메서드 작동 -->
		$.get('../recipe/doIncreaseHitCount', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.recipe-detail__hitCount').empty().html(data.data1);
		}, 'json');
	}
	$(function() {
		// 실전코드
		// RecipeDetail__increaseHitCount();
		// 임시코드
		setTimeout(RecipeDetail__increaseHitCount, 300);
	})
</script>
<!-- 게시글 조회수 스크립트 끝 -->

<!-- 댓글 작성시 유효성 검사 스크립트 시작 -->
<script>
	let ReplyWrite__submitFormDone = false;
	
	function ReplyWrite__submitForm(form) {
		if (ReplyWrite__submitFormDone) {
			return;
		}
		
		form.body.value = form.body.value.trim();
		if (form.body.value.length < 3) {
			alert('최소 3글자 이상 입력해주세요.');
			form.body.focus();
			return;
		}
		ReplyWrite__submitFormDone = true;
		form.submit();
	}
</script>
<!-- 댓글 작성시 유효성 검사 스크립트 끝 -->

<!-- 댓글 작성후 스크롤 이동 스크립트 시작 -->
<!-- 포커스 효과 적용 -->
<style>
.reply-list [data-id] {
	transition: background-color 1s;
}

.reply-list [data-id].focus {
	background-color: #efefef;
	transition: background-color 0s;
}
</style>

<script>
	function ReplyList__goToReply(id) {
		setTimeout(function() {
			const $target = $('.reply-list [data-id="' + id + '"]');
			const targetOffset = $target.offset();
			$(window).scrollTop(targetOffset.top - 50);
			$target.addClass('focus');
			
			setTimeout(function() {
				$target.removeClass('focus');
			}, 1000);
		}, 1000);
	}
	
	if (param.focusReplyId) {
		ReplyList__goToReply(param.focusReplyId);
	}
</script>
<!-- 댓글 작성후 스크롤 이동 스크립트 끝 -->

<div class="bg-gray-200 py-4">
	<div class="detail-box w-10/12 mx-auto" id="topTarget">

		<!-- 레시피 기본정보 영역 시작 -->
		<section class="bg-white rounded-md p-12 flex mb-5">
			<!-- 대표사진-->
			<div class="main-photo w-3/6">
				<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
					alt="" />
				<div class="text-right text-gray-400 text-lg mt-2 mr-4">
					조회수
					<span class="recipe-detail__hitCount">${ recipe.hitCount }</span>
				</div>
			</div>

			<div class="flex flex-col w-2/5 h-80 m-auto">
				<!-- 제목, 내용 -->
				<div class="text-3xl">${ recipe.title }</div>
				<div class="text-xl text-gray-400 mt-5">${ recipe.body }</div>
				<!-- 인원, 소요시간, 난이도 -->
				<div class="info-box flex justify-center items-end space-x-5 mt-auto mb-3 text-2xl">
					<div>
						<i class="fa-solid fa-user-check"></i>
						<span class="ml-1">${ recipe.amount }인분</span>
					</div>
					<div>
						<i class="fa-solid fa-clock"></i>
						<span class="ml-1">${ recipe.forPrintTime } 이내</span>
					</div>
					<div>
						<i class="fa-solid fa-star"></i>
						<span class="ml-1">${ recipe.forPrintLevel }</span>
					</div>
				</div>
			</div>
		</section>
		<!-- 레시피 기본정보 영역 끝 -->

		<!-- 회원 프로필, 리액션 영역 시작 -->
		<section class="bg-white rounded-md p-12 flex mb-5">

			<!-- 등록한 회원정보 -->
			<div class="actor-photo w-60 mr-12">
				<img class="w-full rounded-full" src="https://cdn.pixabay.com/photo/2017/06/16/13/35/chef-2409158_960_720.png"
					alt="" />
				<div class="text-center text-xl mx-auto mt-2">
					<span class="py-3 px-5">${ recipe.extra__writerName }</span>
				</div>
			</div>

			<!-- 리액션 영역 -->
			<div class="rection-box p-3 w-full flex flex-col">
				<div class="upper-area flex items-center justify-around text-4xl text-center">
					<!-- 스크랩 -->
					<div class="text-yellow-400 hover:text-yellow-700">
						<c:if test="${ actorCanMakeScrap || rq.loginedMemberId == 0 }">
							<a href="/user/reaction/doMakeScrap?relTypeCode=recipe&relId=${ param.id }&replaceUri=${rq.encodedCurrentUri}">
								<i class="fa-solid fa-file"></i>
								<div class="text-lg font-bold mt-2">스크랩 ${ recipe.scrap }</div>
							</a>
						</c:if>
						<c:if test="${ actorCanCancelScrap }">
							<a href="/user/reaction/doCancelScrap?relTypeCode=recipe&relId=${ param.id }&replaceUri=${rq.encodedCurrentUri}">
								<i class="fa-solid fa-file-circle-check"></i>
								<div class="text-lg font-bold mt-2">스크랩 ${ recipe.scrap }</div>
							</a>
						</c:if>
					</div>
					<!-- 하트 -->
					<div class="text-red-400 hover:text-red-700">
						<c:if test="${ actorCanMakeRP || rq.loginedMemberId == 0 }">
							<a href="/user/reaction/doMakeLike?relTypeCode=recipe&relId=${ param.id }&replaceUri=${ rq.encodedCurrentUri }">
								<i class="fa-solid fa-heart"></i>
								<div class="text-lg font-bold mt-2">좋아요 ${ recipe.goodRP }</div>
							</a>
						</c:if>
						<c:if test="${ actorCanCancelRP }">
							<a href="/user/reaction/doCancelLike?relTypeCode=recipe&relId=${ param.id }&replaceUri=${ rq.encodedCurrentUri }">
								<i class="fa-solid fa-heart-circle-check"></i>
								<div class="text-lg font-bold mt-2">좋아요 ${ recipe.goodRP }</div>
							</a>
						</c:if>
					</div>
					<!-- 댓글 -->
					<a href="#replyTarget" class="scroll text-green-500 hover:text-green-700">
						<i class="fa-solid fa-comment-dots"></i>
						<div class="text-lg font-bold mt-2">댓글보기 ${replies.size()}</div>
					</a>
				</div>

				<div class="under-area flex items-center justify-around mt-12">
					<!-- 팁 / 주의사항 -->
					<div class="text-lg w-2/3 p-4 border border-gray-200 rounded-lg shadow-xl">
						<div class="mb-2 font-bold text-red-600">
							<i class="fa-solid fa-lightbulb"></i>
							<span class="ml-1">팁 / 주의사항</span>
						</div>
						<c:if test="${ recipe.tip != null }">
							<div class="ml-4">${ recipe.tip }</div>
						</c:if>
						<c:if test="${ recipe.tip == null }">
							<div class="ml-4 text-gray-400">오늘도 맛있게! 잘 챙겨드세요.</div>
						</c:if>
					</div>

					<!-- 레시피 조작 영역 시작 -->
					<div class="btns text-center">
						<c:if test="${ empty param.listUri }">
							<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
						</c:if>
						<c:if test="${not empty param.listUri}">
							<a class="btn btn-outline" href="${param.listUri}">뒤로가기</a>
						</c:if>
						<div class="mt-3">
							<c:if test="${ recipe.extra__actorCanModify }">
								<a class="btn btn-primary btn-outline mr-1"
									href="../recipe/modify?id=${recipe.id}&replaceUri=${rq.encodedCurrentUri}">수정</a>
							</c:if>
							<c:if test="${ recipe.extra__actorCanDelete }">
								<a class="btn btn-secondary btn-outline ml-1"
									href="../recipe/doDelete?id=${ recipe.id }&replaceUri=${rq.encodedCurrentUri}"
									onclick="if ( confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
							</c:if>
						</div>
					</div>
					<!-- 레시피 조작 영역 끝 -->
				</div>
			</div>
		</section>
		<!-- 회원 프로필, 리액션 영역 끝 -->

		<!-- 재료, 양념 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold mb-8">재료 준비</div>

			<div class="flex justify-between text-2xl px-5">
				<div class="w-1/2">
					<div class="font-bold mb-5">[ 재료 ]</div>
					<div class="flex text-center">
						<div class="flex flex-col space-y-5 w-full text-left">
							<c:forEach var="row" items="${ rowArr }">
								<div class="py-3 pl-16 ml-6 border-b border-dashed border-gray-400">${ row }</div>
							</c:forEach>
						</div>
						<div class="flex flex-col space-y-5 w-full">
							<c:forEach begin="1" end="5" step="1">
								<div class="py-3 mr-6 border-b border-dashed border-gray-400">2개</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 구분선 -->
				<div class="w-1 h-max mx-3 mt-12 -mb-2 rounded-lg opacity-50 bg-gray-200"></div>

				<div class="w-1/2">
					<div class="font-bold mb-5">[ 양념 ]</div>
					<div class="flex text-center">
						<div class="flex flex-col space-y-5 w-full text-left">
							<c:forEach begin="1" end="5" step="1">
								<div class="py-3 pl-16 ml-6 border-b border-dashed border-gray-400">간장</div>
							</c:forEach>
						</div>
						<div class="flex flex-col space-y-5 w-full">
							<c:forEach begin="1" end="5" step="1">
								<div class="py-3 mr-6 border-b border-dashed border-gray-400">1T</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- 재료, 양념 영역 끝 -->

		<!-- 조리순서 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold mb-8">조리순서</div>
			<div class="w-full flex flex-col space-y-8 px-5">
				<c:forEach var="i" begin="1" end="4" step="1">
					<div class="flex">
						<div class="w-1/2 mr-5">
							<img class="rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0" alt="" />
						</div>
						<div class="w-5/6 p-5 flex">
							<div class="w-10 h-10 bg-green-500 rounded-full">
								<div class="font-bold text-center text-white pt-2">${ i }</div>
							</div>
							<div class="text-2xl text-gray-600 ml-5 mt-1 w-5/6">양파를 썬다. 일정하게 1cm간격이 되도록 썬다.</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
		<!-- 조리순서 영역 시작 -->

		<!-- 댓글 영역 시작-->
		<section class="bg-white rounded-md p-12 mb-5 relative" id="replyTarget">
			<div class="text-3xl font-bold mb-8">
				<span>요리후기/댓글</span>
				<span class="text-green-500 text-xl ml-3">${ replies.size() }</span>
			</div>

			<!-- 댓글 목록 영역 시작 -->
			<div class="reply-list flex flex-col border-t">
				<c:forEach var="reply" items="${ replies }">
					<div class="flex items-center border-b" data-id="${ reply.id }">
						<div class="w-44">
							<!-- 댓글 프로필 -->
							<div class="actor-photo w-24 mx-auto">
								<c:if test="${ i == 1 || i == 3 }">
									<img class="w-full rounded-full" src="https://cdn.pixabay.com/photo/2017/06/16/13/35/chef-2409158_960_720.png"
										alt="" />
								</c:if>
								<!-- 대표사진 미등록 회원 -->
								<c:if test="${  i != 1 && i != 3 }">
									<img class="w-full rounded-full border border-gray-400"
										src="https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg" alt="" />
								</c:if>
							</div>
						</div>

						<div class="w-full pt-2 pl-2">
							<!-- 작성자, 등록(수정)일 -->
							<div class="flex items-center mb-2 text-gray-400 text-sm">
								<div class="text-xl font-bold text-black mr-3">${ reply.extra__writerName }</div>
								<div>
									<c:if test="${ reply.regDate == reply.updateDate }">
										<span>${ reply.forPrintRegDate_Type3 } &nbsp;(등록)</span>
									</c:if>
									<c:if test="${ reply.regDate != reply.updateDate }">
										<span>${ reply.forPrintUpdateDate_Type3 } &nbsp;(수정)</span>
									</c:if>
								</div>
							</div>

							<!-- 댓글 내용 -->
							<div class="ml-1 text-xl font-extralight h-20">${ reply.forPrintBody }</div>
						</div>

						<!-- 요리후기 사진 -->
						<div class="w-80 p-3">
							<!-- test="${ reply.regDate == reply.updateDate } -->
							<c:if test="${ true }">
								<img class="rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0" alt="" />
							</c:if>
						</div>

						<!-- 댓글 수정, 삭제 영역 시작 -->
						<div class="btns flex flex-col w-32 justify-center items-center space-y-5">
							<c:if test="${ reply.extra__actorCanModify }">
								<a href="../reply/modify?id=${ reply.id }&replaceUri=${rq.encodedCurrentUri}"
									class="btn btn-primary btn-outline" onclick="if( confirm('수정하시겠습니까?') == false ) return false;">
									<i class="fas fa-edit"></i>
									<div class="ml-1">수정</div>
								</a>
							</c:if>
							<c:if test="${ reply.extra__actorCanDelete }">
								<a href="../reply/doDelete?id=${ reply.id }&replaceUri=${rq.encodedCurrentUri}"
									class="btn btn-secondary btn-outline" onclick="if( confirm('정말 삭제하시겠습니까?') == false ) return false;">
									<i class="fas fa-trash"></i>
									<div class="ml-1">삭제</div>
								</a>
							</c:if>
						</div>
						<!-- 댓글 수정, 삭제 영역 영역 끝 -->
					</div>
				</c:forEach>
			</div>
			<!-- 댓글 목록 영역 끝 -->

			<!-- TOP 버튼 -->
			<div class="fixed right-10 bottom-20 text-4xl text-center hover:text-yellow-400">
				<a href="#topTarget" class="scroll">
					<i class="fa-solid fa-circle-arrow-up"></i>
					<div class="text-xl font-black">TOP</div>
				</a>
			</div>

			<!-- 댓글 작성 영역 시작 -->
			<div class="mt-10">
				<div class="border-b border-gray-300 pl-3 pb-2 mb-3 font-bold text-xl text-yellow-500">
					<span>후기등록</span>
				</div>
				<div class="text-lg text-gray-500 tracking-wide mb-2 ml-3">
					<div>
						<span>${ recipe.extra__writerName }님</span>
						에게 궁금한점들을남겨주세요.
					</div>
					<c:if test="${ rq.logined == false }">
						<a href="${ rq.loginUri }" class="link link-primary">로그인</a> 후 댓글을 남길 수 있습니다.
					</c:if>
				</div>
				<c:if test="${ rq.logined == true }">
					<form class="flex items-center" method="POST" action="../reply/doWrite"
						onsubmit="ReplyWrite__submitForm(this); return false;">
						<!-- 현재 페이지 정보 -->
						<input type="hidden" name="relTypeCode" value="recipe">
						<input type="hidden" name="relId" value="${ recipe.id }">
						<input type="hidden" name="replaceUri" value="${ rq.currentUri }">

						<!-- 요리후기 사진 등록 -->
						<a href="#"
							class="flex justify-center items-center w-36 h-36 rounded-xl bg-gray-200 hover:bg-gray-300 mr-4 text-4xl">
							<i class="fa-solid fa-plus"></i>
						</a>
						<!-- 댓글 작성 -->
						<div class="border border-gray-300 rounded-xl p-2 w-10/12">
							<textarea name="body" rows="5" class="w-full" placeholder="요리후기를 사진과 함께 작성해보세요."></textarea>
						</div>

						<button type="submit" class="w-36 h-36 hover:bg-gray-100 border-double border-4 border-gray-300 rounded-xl ml-3">
							<div class="text-xl">등록</div>
						</button>
					</form>
				</c:if>
			</div>
			<!-- 댓글 작성 영역 끝 -->
		</section>
		<!-- 댓글 영역 끝 -->
	</div>
</div>

<%@include file="../common/foot.jspf"%>