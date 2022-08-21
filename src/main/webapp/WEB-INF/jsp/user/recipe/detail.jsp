<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="detail-box w-10/12 mx-auto">

		<!-- 레시피 기본정보 영역 시작 -->
		<section class="bg-white rounded-md p-12 flex mb-5">
			<!-- 대표사진-->
			<div class="main-photo w-3/6">
				<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
					alt="" />
				<div class="text-right mt-2 mr-4 text-black">조회수 111</div>
			</div>

			<div class="flex flex-col w-2/5 h-80 m-auto">
				<!-- 제목, 내용 -->
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
		<!-- 레시피 기본정보 영역 끝 -->

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
					<div class="text-lg w-2/3 p-4 border border-gray-200 rounded-lg shadow-xl">
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
		<!-- 회원 프로필, 리액션 영역 끝 -->

		<!-- 재료, 양념 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold mb-8">재료 준비</div>
			<div class="flex justify-between space-x-5 text-2xl px-5">
				<div class="w-1/2">
					<div class="font-bold mb-5">[ 재료 ]</div>
					<c:forEach begin="1" end="8" step="1">
						<div class="grid grid-cols-2 mb-2 ml-4 px-3 border-b-2 border-dashed border-gray-300">
							<div class="">버섯</div>
							<div class="text-center">1개</div>
						</div>
					</c:forEach>
				</div>
				<div class="w-1/2">
					<div class="font-bold mb-5">[ 양념 ]</div>
					<c:forEach begin="1" end="5" step="1">
						<div class="grid grid-cols-2 mb-2 ml-4 px-3 border-b-2 border-dashed border-gray-300">
							<div class="">간장</div>
							<div class="text-center">1숟가락</div>
						</div>
					</c:forEach>
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

		<!-- 댓글 -->
		<section class="bg-white rounded-md p-12 flex">댓글</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>