<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세페이지" />
<%@include file="../common/head.jspf"%>
<%@ include file="../../common/toastUiEditorLib.jspf"%>
<script src="/reply/Reply.js" defer="defer"></script>
<script src="/reply/Reaction.js" defer="defer"></script>

<!-- 게시글 조회수 스크립트 시작 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	
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

<!-- 스크롤 이동후 포커스 효과 적용 -->
<style>
.reply-list [data-id] {
	transition: background-color 1s;
}

.reply-list [data-id].focus {
	background-color: #efefef;
	transition: background-color 0s;
}
</style>

<!-- 댓글 수정 모달 활성화시 효과 적용 -->
<style>
.ReplyModify_box {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.3);
	display: none;
	justify-content: center;
	align-items: center;
}
</style>

<div class="bg-gray-200 py-4">
	<div class="detail-box w-10/12 mx-auto">
		<!-- 레시피 기본정보 영역 시작 -->
		<section class="bg-white rounded-md p-12 pb-8 mb-5">
			<div class="flex">
				<div class="main-photo w-3/6">
					<!-- 대표사진 -->
					<div class="flex flex-col justify-center items-center bg-gray-200 border rounded-xl border-gray-300">
						<img class="object-cover w-full h-80 rounded-md" src="${rq.getMainRecipeImgUri(recipe.id)}"
							onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" alt="" />
					</div>
					<div class="text-gray-400 text-lg text-right mt-2 mr-4">
						<span>등록번호</span>
						<span>${ recipe.id }</span>
					</div>
					<div class="text-gray-400 text-lg text-right mr-4">
						<span>조회수</span>
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
			</div>

			<!-- 날짜 표시 -->
			<div class="flex flex-col mr-4 text-gray-400 text-lg text-right">
				<div>
					최초등록일
					<span>${ recipe.forPrintRegDate_Type3 }</span>
				</div>
				<c:if test="${ recipe.regDate != recipe.updateDate }">
					<div>
						최근수정일
						<span>${ recipe.forPrintUpdateDate_Type3 }</span>
					</div>
				</c:if>
			</div>

			<!-- 레시피 분류 이름표시 영역 시작 -->
			<div class="flex mt-8 text-2xl m-5 font-medium text-slate-700 text-center">
				<c:forEach var="category" items="${ categoriesAboutRecipe }">
					<div class="mr-3">#${ category.name }</div>
				</c:forEach>
			</div>
			<!-- 레시피 분류 이름표시 영역 끝 -->
		</section>
		<!-- 레시피 기본정보 영역 끝 -->

		<!-- 회원 프로필, 리액션 영역 시작 -->
		<section class="bg-white rounded-md p-12 pb-8 flex mb-5">

			<!-- 등록한 회원정보 -->
			<div class="actor-photo w-60">
				<!-- 회원 프로필 -->
				<div class="w-60 h-60 flex flex-col justify-center items-center bg-gray-200 border rounded-xl border-gray-300">
					<img class="max-h-60 rounded-3xl" src="${rq.getProfileImgUri(recipe.memberId)}"
						onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
				</div>

				<div class="text-center text-xl mx-auto mt-2">
					<span class="py-3 px-5 font-bold">
						<span>${ recipe.extra__writerName }</span>
					</span>
					<div>
						<c:if test="${ recipe.extra__writerLeaved }">
							<span class="text-red-500">(탈퇴회원)</span>
						</c:if>
					</div>
				</div>
			</div>

			<!-- 리액션 영역 -->
			<div class="rection-box p-3 w-full flex flex-col">
				<div reaction-id="${ recipe.id }" reaction-code="recipe"
					class="upper-area flex items-center justify-around text-4xl text-center">

					<!-- 스크랩 -->
					<div class="text-yellow-400 hover:text-yellow-700">
						<c:if test="${ actorCanMakeScrap || rq.loginedMemberId == 0 }">
							<a action='make' id='scrapIcon' onclick='Scrap_AjaxForm(this);'>
								<i class='fa-solid fa-file'></i>
								<div class='text-lg font-bold mt-2'>스크랩 ${ recipe.scrap }</div>
							</a>
						</c:if>
						<c:if test="${ actorCanCancelScrap }">
							<a action='cancel' id='scrapIcon' onclick='Scrap_AjaxForm(this);'>
								<i class='fa-solid fa-file-circle-check'></i>
								<div class='text-lg font-bold mt-2'>스크랩 ${ recipe.scrap }</div>
							</a>
						</c:if>
					</div>

					<!-- 하트 -->
					<div class="text-red-400 hover:text-red-700">
						<c:if test="${ actorCanMakeRP || rq.loginedMemberId == 0 }">
							<a action='make' id='likeIcon' onclick='Like_AjaxForm(this);'>
								<i class='fa-solid fa-heart'></i>
								<div class='text-lg font-bold mt-2'>좋아요 ${ recipe.goodRP }</div>
							</a>
						</c:if>
						<c:if test="${ actorCanCancelRP }">
							<a action='cancel' id='likeIcon' onclick='Like_AjaxForm(this);'>
								<i class='fa-solid fa-heart-circle-check'></i>
								<div class='text-lg font-bold mt-2'>좋아요 ${ recipe.goodRP }</div>
							</a>
						</c:if>
					</div>

					<!-- 댓글 -->
					<a href="#replyTarget" class="scroll text-green-500 hover:text-green-700">
						<i class="fa-solid fa-comment-dots"></i>
						<div class="text-lg font-bold mt-2">
							댓글로 이동
							<span class='replyCnt'>${ replies.size() }</span>
						</div>
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
						<c:if test="${ recipe.tip == '' || recipe.tip == null }">
							<div class="ml-4 text-gray-400">오늘도 맛있게! 잘 챙겨드세요.</div>
						</c:if>
					</div>

					<!-- 레시피 조작 영역 시작 -->
					<div class="btns text-center">
						<c:if test="${ empty listUri }">
							<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
						</c:if>
						<c:if test="${not empty listUri}">
							<a class="btn btn-outline" href="${ param.listUri }">뒤로가기</a>
						</c:if>
						<div class="mt-3">
							<c:if test="${ recipe.extra__actorCanModify }">
								<a class="btn btn-primary btn-outline mr-1"
									href="../recipe/modify?id=${recipe.id}&replaceUri=${rq.encodedCurrentUri}">수정</a>
							</c:if>
							<c:if test="${ recipe.extra__actorCanDelete }">
								<a class="btn btn-secondary btn-outline ml-1"
									href="../recipe/doDelete?id=${ recipe.id }&replaceUri=${param.listUri}"
									onclick="if ( confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
							</c:if>
						</div>
					</div>
					<!-- 레시피 조작 영역 끝 -->
				</div>

				<!-- 안내문구 -->
				<ul class="list-disc text-lg flex flex-col space-y-5 ml-14 mt-14">
					<li>
						<span class="text-yellow-400">스크랩</span>
						하여
						<span class="link link-neutral">레시피 노트</span>
						에서 모아볼 수 있어요.
					</li>
					<li>
						이 레시피가 마음에 드신다면
						<span class="text-red-400">좋아요</span>
						를 눌러보세요.
					</li>
					<li>
						어떤 댓글이 있는지 궁금하시다면 바로
						<span class="text-green-500">댓글로 이동</span>
						할 수 있어요.
					</li>
				</ul>
			</div>
		</section>
		<!-- 회원 프로필, 리액션 영역 끝 -->

		<!-- 재료, 양념 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold">재료 준비</div>

			<!-- 안내문구 -->
			<ul class="list-disc text-lg flex flex-col space-y-5 my-7 mx-10">
				<li>좌측의 체크박스로 각 항목에서 확인(취소)을 표시할 수 있어요.</li>
				<li>궁금한 점이 있으시거나 설명이 필요하시면 작성자에게 댓글을 남겨주세요.</li>
			</ul>

			<div class="flex justify-between text-2xl px-5">
				<div class="w-1/2">
					<div class="font-bold mb-5">[ 재료 ]</div>
					<div class="flex">
						<div class="flex flex-col space-y-5 w-full form-control">
							<c:forEach var="row" items="${ rows }">
								<label class="py-3 border-b border-dashed border-gray-400 cursor-pointer hover:underline">
									<input type="checkbox" class="checkbox checkbox-accent mx-4" />
									<span>${ row }</span>
								</label>
							</c:forEach>
						</div>
						<div class="flex flex-col space-y-5 w-full text-center">
							<c:forEach var="rowValue" items="${ rowValues }">
								<div class="py-3 mr-6 border-b border-dashed border-gray-400">${ rowValue }</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 구분선 -->
				<div class="w-1 h-max mx-3 mt-12 -mb-2 rounded-lg opacity-50 bg-gray-200"></div>

				<div class="w-1/2">
					<div class="font-bold mb-5">[ 양념 ]</div>
					<div class="flex">
						<div class="flex flex-col space-y-5 w-full form-control">
							<c:forEach var="sauce" items="${ sauces }">
								<label class="py-3 border-b border-dashed border-gray-400 cursor-pointer hover:underline">
									<input type="checkbox" class="checkbox checkbox-accent mx-4" />
									<span>${ sauce }</span>
								</label>
							</c:forEach>
						</div>
						<div class="flex flex-col space-y-5 w-full text-center">
							<c:forEach var="sauceValue" items="${ sauceValues }">
								<div class="py-3 mr-6 border-b border-dashed border-gray-400">${ sauceValue }</div>
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

			<!-- 토스트 에디터 적용 -->
			<td>
				<div class="toast-ui-viewer">
					<script type="text/x-template">${recipe.body}</script>
				</div>
			</td>

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
				<span class="text-green-500 text-2xl ml-3">
					<span class='replyCnt'>${ replies.size() }</span>
				</span>
			</div>

			<div class="border-t border-gray-300 p-5">
				<!-- 안내문구 -->
				<div class="text-lg text-gray-500">
					<div class="">
						<span class="font-bold text-xl text-yellow-500">댓글등록</span>
						<span>${ recipe.extra__writerName }님 에게 궁금한점들을남겨주세요.</span>
					</div>
					<c:if test="${ rq.logined == false }">
						<a href="${ rq.loginUri }" class="link link-primary">로그인</a>
						<span>후 댓글을 남길 수 있습니다.</span>
					</c:if>
				</div>

				<!-- 댓글 작성 영역 시작 -->
				<c:if test="${ rq.logined == true }">
					<form class="flex items-center space-x-4 w-full" method="POST" enctype="multipart/form-data"
						action="/user/reply/doWrite" onsubmit="ReplyWrite__submitForm(this); return false;">
						<!-- 현재 페이지 정보 -->
						<input type="hidden" name="relTypeCode" value="recipe">
						<input type="hidden" name="relId" value="${ recipe.id }">
						<input type="hidden" name="replaceUri" value="${ rq.currentUri }">

						<!-- 요리후기 사진 등록 -->
						<div class="w-60 mt-10">
							<div id="replyButtonForPreview" class="w-full">
								<img id="preview-reply" class="object-cover rounded-xl w-full h-36"
									src="https://via.placeholder.com/300/?text=...">
							</div>
							<div class="px-3 mt-3">
								<label for="input-reply" id="replyButtonForEmpty"
									class="flex justify-center items-center rounded-lg bg-gray-200 hover:bg-gray-400 py-1 px-3">
									<i class="fa-solid fa-plus mr-3 font-bold"></i>
									<span>사진등록</span>
								</label>
							</div>
							<input type="file" id="input-reply" accept="image/gif, image/jpeg, image/png" onchange="previewFile();"
								oninput="readImage(this); return false;" name="file__reply__0__extra__reviewImg__1" class="hidden replyBox" />
						</div>

						<!-- 댓글 작성란 -->
						<div class="w-full">
							<textarea style="font-size: 1.2rem;" name="body" rows="3" class="w-full textarea textarea-warning"
								placeholder="요리후기를 사진과 함께 작성해보세요."></textarea>
						</div>

						<!-- 댓글 등록 버튼 -->
						<div class="text-xl font-bold">
							<button type="submit" class="w-32 h-32 border-double border-4 border-gray-300 rounded-xl hover:bg-yellow-200">등록</button>
						</div>
					</form>
				</c:if>
				<!-- 댓글 작성 영역 끝 -->
			</div>

			<!-- 댓글 목록 영역 시작 -->
			<div class="w-full overflow-y-auto" style="height: 70vh;">
				<div class="reply-list flex flex-col border-t">
					<c:if test="${ replies.size() == 0 }">
						<div class="text-2xl text-gray-400 mt-5 ml-3">등록된 댓글이 없습니다.</div>
					</c:if>
					<c:forEach var="reply" items="${ replies }">
						<div class="flex items-center border-b py-3" data-id="${ reply.id }">
							<!-- 회원 프로필 -->
							<div class="w-36">
								<div class="w-32 h-32 flex flex-col justify-center items-center bg-gray-200 border border-gray-200 rounded-full">
									<img class="max-h-32 rounded-full" src="${rq.getProfileImgUri(reply.memberId)}"
										onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
								</div>
							</div>

							<!-- 목록 내용 -->
							<div class="w-full pt-2 pl-2">
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
								<div class="ml-1 text-xl font-extralight h-20">${ reply.forPrintBody }</div>
							</div>

							<!-- 요리후기 사진 -->
							<div class="w-80 p-3">
								<img id="replyImg" class="rounded-md" src="${rq.getReviewImgUri(reply.id)}" alt="" />
							</div>

							<!-- 댓글 수정, 삭제 영역 시작 -->
							<script type="text/x-template" class="reply-body hidden">${reply.body}</script>

							<div class="btns flex flex-col w-32 justify-center items-center space-y-5">
								<c:if test="${ reply.extra__actorCanModify }">
									<a class="btn btn-primary btn-outline" onclick="ReplyModify__showModal(this);">
										<i class="fas fa-edit"></i>
										<div class="ml-1">수정</div>
									</a>
								</c:if>
								<c:if test="${ reply.extra__actorCanDelete }">
									<a class="btn btn-secondary btn-outline"
										onclick="if( confirm('정말 삭제하시겠습니까?')) { ReplyDelete_AjaxForm(this); } return false;">
										<i class="fas fa-trash"></i>
										<div class="ml-1">삭제</div>
									</a>
								</c:if>
							</div>
							<!-- 댓글 수정, 삭제 영역 영역 끝 -->
						</div>
					</c:forEach>
				</div>
			</div>
			<!-- 댓글 목록 영역 끝 -->

			<!-- TOP 버튼 -->
			<div class="fixed right-12 bottom-32 text-4xl text-center">
				<a href="#topTarget" class="scroll hover:text-yellow-400">
					<i class="fa-solid fa-circle-arrow-up"></i>
					<div class="text-xl font-black">TOP</div>
				</a>
			</div>
			<!-- 댓글보기 버튼 -->
			<div class="fixed right-12 bottom-12 text-4xl text-center">
				<a href="#replyTarget" class="scroll text-green-500 hover:text-green-700">
					<i class="fa-solid fa-comment-dots"></i>
					<div class="text-xl">댓글</div>
				</a>
			</div>

			<!-- 댓글 수정 모달 시작 -->
			<div id="ReplyModify_box" class="ReplyModify_box hidden">
				<div class="w-3/6 p-8 py-5 rounded-xl bg-gray-200">
					<div class="text-lg mb-2">댓글수정</div>
					<form class="" method="post" enctype="multipart/form-data" action="/user/reply/doModify"
						onsubmit="ReplyModify__submitForm(this); return false;">
						<input type="hidden" name="id" value="" />
						<input type="hidden" name="afterModifyUri" value="${ rq.currentUri }" />

						<div class="flex">
							<!-- 요리후기 사진 등록 -->
							<div class="w-60 my-2 mr-3">
								<div id="replyButtonForPreview" class="w-full">
									<img id="preview-modifyReply" class="object-cover rounded-xl w-full h-36"
										src="https://via.placeholder.com/300/?text=...">
								</div>
								<div class="px-3 mt-3">
									<label for="input-modifyReply" id="replyButtonForEmpty"
										class="flex justify-center items-center rounded-lg border border-gray-400 hover:bg-gray-400 py-1 px-3">
										<i class="fa-solid fa-plus font-bold"></i>
										<span>사진변경</span>
									</label>
								</div>
								<input type="file" id="input-modifyReply" accept="image/gif, image/jpeg, image/png" onchange="previewFile();"
									oninput="readImage(this); return false;" name="file__reply__0__extra__reviewImg__1" class="hidden replyBox" />
							</div>

							<!-- 입력창 -->
							<textarea style="font-size: 1.1rem;" class="textarea textarea-bordered w-full" name="body" rows="3"
								maxlength="2000" placeholder="내용을 입력해주세요.">${ reply.body }</textarea>
						</div>

						<div class="text-right mt-3">
							<button type="button" onclick="ReplyModify__hideModal();" class="btn btn-sm mr-3 area" title="닫기">
								<i class="fa-solid fa-xmark mr-2"></i>
								닫기
							</button>

							<button type="submit" class="btn btn-sm btn-primary btn-outline">
								<span>댓글수정</span>
							</button>
						</div>
					</form>
				</div>
			</div>
			<!-- 댓글 수정 모달 끝 -->
		</section>
		<!-- 댓글 영역 끝 -->
	</div>
</div>

<%@include file="../common/foot.jspf"%>