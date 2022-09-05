<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="댓글 수정페이지" />
<%@include file="../common/head.jspf"%>

<!-- 댓글 수정시 유효성 검사 스크립트 시작 -->
<script>
	let ReplyModify__submitFormDone = false;
	function ReplyModify__submitForm(form) {
		if (ReplyModify__submitFormDone) {
			return;
		}
		// 좌우 공백 제거
		if (form.body.value.length < 3) {
			alert('최소 3글자 이상 입력해주세요.');
			form.body.focus();
			return;
		}
		ReplyModify__submitFormDone = true;
		form.submit();
	}
</script>
<!-- 댓글 수정시 유효성 검사 스크립트 끝 -->

<div class="bg-gray-200 py-4">
	<div class="detail-box w-10/12 mx-auto">

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

		<!-- 댓글 영역 시작-->
		<section class="bg-white rounded-md p-12 mb-5 relative">
			<div class="text-3xl font-bold mb-8">
				<span>요리후기/댓글 수정</span>
			</div>

			<!-- 댓글 수정 영역 시작 -->
			<div class="mt-10">
				<div class="border-b border-gray-300 pl-3 pb-2 mb-3 font-bold text-xl text-yellow-500">
					<span>후기등록</span>
				</div>
				<div class="text-lg text-gray-500 tracking-wide mb-2 ml-3">
					<div>
						<span>${ recipe.extra__writerName }님</span>
						에게 궁금한점들을남겨주세요.
					</div>
					<div class="text-right">
						<c:if test="${ reply.regDate == reply.updateDate }">
							<span>${ reply.forPrintRegDate_Type2 } &nbsp;(최초등록일)</span>
						</c:if>
						<c:if test="${ reply.regDate != reply.updateDate }">
							<span>${ reply.forPrintUpdateDate_Type2 } &nbsp;(최근수정일)</span>
						</c:if>
					</div>
				</div>

				<form class="flex items-center" method="POST" action="../reply/doModify" method="POST"
					onsubmit="ReplyModify__submitForm(this); return false;">

					<input type="hidden" name="id" value="${ reply.id }" />
					<input type="hidden" name="relId" value="${ reply.relId }" />

					<!-- 요리후기 사진 등록 -->
					<div class="mr-4">
						<div class="text-center mx-auto"></div>
						<a href="#"
							class="flex justify-center items-center w-36 h-36 rounded-xl bg-gray-200 hover:bg-gray-300 mr-4 text-4xl">
							<i class="fa-solid fa-plus"></i>
						</a>
					</div>

					<!-- 댓글 수정 영역 -->
					<div class="border border-gray-300 rounded-xl p-2 w-10/12">
						<textarea name="body" rows="5" class="w-full" placeholder="댓글을 수정하세요.">${ reply.body }</textarea>
					</div>
					<button type="submit" class="w-36 h-36 hover:bg-gray-100 border-double border-4 border-gray-300 rounded-xl ml-3">
						<div class="text-xl">수정</div>
					</button>
				</form>
				<div class="btns text-right mt-3">
					<div type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</div>
					<div type="submit" class="btn btn-outline btn-secondary">사진변경</div>
				</div>
			</div>
			<!-- 댓글 작성 영역 끝 -->
		</section>
		<!-- 댓글 영역 끝 -->
	</div>
</div>

<%@include file="../common/foot.jspf"%>