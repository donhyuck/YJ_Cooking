<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 모아보기" />
<%@include file="../common/listhead.jspf"%>

<section class="second-bar bg-green-400 opacity-80 w-full h-16">
	<div class="menu-box flex items-center justify-around h-full text-center text-lg font-bold px-40">
		<a href="/user/list/suggest?page=1" class="">
			<div class="text-white hover:text-yellow-300">추천 레시피</div>
			<div class="text-xs font-normal text-black">오늘 뭐 먹지?</div>
		</a>
		<a href=/user/list/category class="">
			<div class="text-yellow-300">레시피 모아보기</div>
			<div class="text-xs">맛있는 한 끼를 찾아서</div>
		</a>
		<a href="/user/list/rank" class="">
			<div class="text-white hover:text-yellow-300">랭킹보기</div>
			<div class="text-xs font-normal text-black">명예의 전당</div>
		</a>
		<a href="/user/list/note?page=1" class="">
			<div class="text-white hover:text-yellow-300">레시피 노트</div>
			<div class="text-xs font-normal text-black">나만의 요리사전</div>
		</a>
	</div>
</section>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">

		<!-- TOP 버튼 -->
		<div class="fixed bottom-10 right-10 text-4xl text-center hover:text-yellow-400">
			<a href="#topTarget" class="scroll">
				<i class="fa-solid fa-circle-arrow-up"></i>
				<div class="text-xl font-black">TOP</div>
			</a>
		</div>
		
		<div class="flex flex-col space-y-6">
			<!-- 대분류 -->
			<c:forEach var="board" items="${ boards }">
				<section class="bg-white rounded-md p-8">
					<div class="text-3xl border-b border-gray-400 mb-4 p-3 mx-4">${ board.boardName }</div>
					<div class="flex grid grid-cols-5 text-center mx-20">

						<!-- 중분류 -->
						<c:forEach var="category" items="${ categories }">

							<!--소분류, 선택한 카테고리의 레시피 보기 -->
							<c:if test="${ category.boardId == board.id }">
								<a href="/user/list/choice?boardId=${ category.boardId }&relId=${category.relId}"
									class="flex justify-center items-center w-32 h-16 my-4 border border-gray-400 rounded-full mx-auto hover:bg-yellow-200">
									<div class="text-gray-600 text-xl">${ category.name }</div>
								</a>
							</c:if>
						</c:forEach>
					</div>
				</section>
			</c:forEach>
		</div>
	</div>
</div>

<%@include file="../common/foot.jspf"%>