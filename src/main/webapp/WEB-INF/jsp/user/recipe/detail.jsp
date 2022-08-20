<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="detail-box w-10/12 mx-auto">
		<section class="bg-white rounded-md p-12 flex mb-5">

			<!-- 대표사진, 제목, 설명 -->
			<div class="main-photo w-3/6">
				<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
					alt="" />
				<div class="text-right mt-2 mr-4 text-black">조회수 111</div>
			</div>

			<!-- 레시피 기본정보 -->
			<div class="flex flex-col w-2/5 h-80 m-auto">
				<div class="text-3xl">${ recipe.title }</div>
				<div class="text-xl text-gray-400 mt-5">${ recipe.body }</div>
				<!-- 인원, 소요시간, 난이도 -->
				<div class="info-box flex justify-center items-end space-x-10 mt-auto mb-3 text-2xl">
					<div>
						<i class="fa-solid fa-user-check"></i>
						<span class="ml-1">2인분</span>
					</div>
					<div>
						<i class="fa-solid fa-clock"></i>
						<span class="ml-1">10분</span>
					</div>
					<div>
						<i class="fa-solid fa-star"></i>
						<span class="ml-1">누구나</span>
					</div>
				</div>
			</div>
		</section>

		<!-- 회원 프로필, 리액션 영역 시작 -->
		<section class="bg-white rounded-md p-12 flex mb-5">
		
			<!-- 등록한 회원정보 -->
			<div class="actor-photo w-60 mr-12">
				<img class="w-full rounded-full" src="https://cdn.pixabay.com/photo/2017/06/16/13/35/chef-2409158_960_720.png"
					alt="" />
				<div class="text-center text-xl mx-auto mt-2">
					<span class="py-3 px-5">${ actorNickname }</span>
				</div>
			</div>

			<!-- 리액션 영역 -->
			<div class="rection-box p-3 w-full flex flex-col">
				<div class="upper-area flex items-center justify-around text-4xl text-center">
					<!-- 스크랩 -->
					<a href="#" class="text-yellow-400">
						<i class="fa-solid fa-paperclip"></i>
						<div class="text-lg font-bold mt-2">스크랩</div>
					</a>
					<!-- 하트 -->
					<a href="#" class="text-red-400">
						<i class="fa-solid fa-heart"></i>
						<div class="text-lg font-bold mt-2">좋아요</div>
					</a>
					<!-- 댓글 -->
					<a href="#" class="text-gray-500">
						<i class="fa-solid fa-comment-dots"></i>
						<div class="text-lg font-bold mt-2">댓글보기</div>
					</a>
				</div>

				<div class="under-area flex items-center justify-around mt-12">
					<!-- 팁 / 주의사항 -->
					<div class="text-lg w-4/6 p-4 border border-gray-200 rounded-md shadow-xl">
						<div class="bg-white mb-2 font-bold text-red-600">
							<i class="fa-solid fa-lightbulb"></i>
							<span class="ml-1">팁 / 주의사항</span>
						</div>
						<div class="ml-4">뜨거우니 조심해서 담으세요 설탕은 처음에!</div>
					</div>

					<!-- 레시피 조작 영역 시작 -->
					<div class="btns text-center">
						<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
						<div class="mt-3">
							<c:if test="${ recipe.extra__actorCanModify }">
								<a class="btn btn-primary btn-outline mr-1" href="../recipe/modify?id=${recipe.id}">수정</a>
							</c:if>
							<c:if test="${ recipe.extra__actorCanDelete }">
								<a class="btn btn-secondary btn-outline ml-1" href="../recipe/doDelete?id=${ recipe.id }"
									onclick="if ( confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
							</c:if>
						</div>
					</div>
					<!-- 레시피 조작 영역 끝 -->
				</div>
			</div>
		</section>
		<!-- 등록한 회원정보, 스크랩, 하트 영역 끝 -->

		<!-- 재료, 양념 -->
		<section class="bg-white rounded-md p-12 flex">재료, 양념</section>

		<!-- 조리순서 -->
		<section class="bg-white rounded-md p-12 flex">조리순서</section>

		<!-- 댓글 -->
		<section class="bg-white rounded-md p-12 flex">댓글</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>