<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="detail-box w-10/12 mx-auto">
		<div class="bg-white rounded-md p-12">
			<!-- 대표사진, 제목, 설명 -->
			<section class="flex">
				<div class="main-photo w-3/6">
					<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
						alt="" />
					<div class="text-right mt-2 mr-4 text-black">조회수 111</div>
				</div>
				<div class="flex flex-col w-2/5 h-80 m-auto">
					<div class="text-3xl">${ recipe.title }</div>
					<div class="text-xl text-gray-400 mt-5">${ recipe.body }</div>
				</div>
			</section>
			<hr />

			<!-- 등록한 회원정보, 스크랩, 하트 버튼 -->
			<section class="flex">등록한 회원정보, 스크랩, 하트 버튼</section>
			셰프의 한마디 /팁
			<hr />

			<!-- 레시피 조작 영역 시작 -->
			<div class="btns mt-3">
				<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
				<c:if test="${ recipe.extra__actorCanModify }">
					<a class="btn btn-primary" href="../recipe/modify?id=${recipe.id}">수정</a>
				</c:if>
				<c:if test="${ recipe.extra__actorCanDelete }">
					<a class="btn btn-secondary" href="../recipe/doDelete?id=${ recipe.id }"
						onclick="if ( confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
				</c:if>
			</div>
			<!-- 레시피 조작 영역 끝 -->

			<!-- 재료, 양념 -->
			<section class="flex">재료, 양념</section>
			<hr />

			<!-- 조리순서 -->
			<section class="flex">조리순서</section>
			<hr />

			<!-- 댓글 -->
			<section class="flex">댓글</section>
			<hr />


		</div>
	</div>
</div>

<%@include file="../common/foot.jspf"%>