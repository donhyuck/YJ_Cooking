<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피노트" />
<%@include file="../common/listhead.jspf"%>

<section class="second-bar bg-green-400 opacity-80 w-full h-16">
	<div class="menu-box flex items-center justify-around h-full text-center text-lg font-bold px-40">
		<a href="/user/list/suggest" class="">
			<div class="text-white hover:text-yellow-300">추천 레시피</div>
			<div class="text-xs font-normal text-black">오늘 뭐 먹지?</div>
		</a>
		<a href="/user/list/category" class="">
			<div class="text-white hover:text-yellow-300">레시피 모아보기</div>
			<div class="text-xs font-normal text-black">맛있는 한 끼를 찾아서</div>
		</a>
		<a href="/user/list/rank" class="">
			<div class="text-white hover:text-yellow-300">랭킹보기</div>
			<div class="text-xs font-normal text-black">명예의 전당</div>
		</a>
		<a href="/user/list/note" class="">
			<div class="text-yellow-300">레시피 노트</div>
			<div class="text-xs">나만의 요리사전</div>
		</a>
	</div>
</section>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="write-list bg-white rounded-md p-4">
			<div class="mb-2">
				<div class="text-xl mb-1">내가 등록한 레시피</div>
			</div>
			<c:if test="${ rq.loginedMember == null }">
				<div class="ml-2">
					<a href="/user/member/login" class="link link-primary">로그인</a>
					후 확인해보세요.
				</div>
			</c:if>
			<c:if test="${ rq.loginedMember != null }">
				<div class="flex grid grid-cols-3 gap-10">
					<!-- 작성자가 본인인 레시피 -->
					<c:forEach var="recipe" items="${ recipes }">
						<div>
							<a href="/user/recipe/detail?id=${ recipe.id }"">
								<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
									alt="" />
							</a>
							<div class="ml-3 mt-2">
								<div class="text-lg">${ recipe.title }</div>
								<div>${ recipe.extra__writerName }</div>
								<!-- 좋아요 , 조회수 -->
								<div class="text-sm">
									<span class="text-red-500 mr-1">
										<i class="fa-solid fa-heart"></i>
										${ recipe.goodRP }
									</span>
									<span class="text-gray-500">조회수 ${ recipe.hitCount }</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>

		</section>
		<section class="scrap-list bg-white rounded-md p-4 mt-4">
			<div class="mb-2">
				<div class="text-xl mb-1">스크랩한 레시피</div>
			</div>
			<c:if test="${ rq.loginedMember == null }">
				<div class="ml-2">
					<a href="/user/member/login" class="link link-primary">로그인</a>
					후 확인해보세요.
				</div>
			</c:if>
			<c:if test="${ rq.loginedMember != null }">
				<div class="flex grid grid-cols-3 gap-10">
					<!-- 내가 스크랩한 레시피 -->
					<c:forEach var="scrapRecipe" items="${ scrapRecipes }">
						<div>
							<a href="/user/recipe/detail?id=${ scrapRecipe.id }">
								<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
									alt="" />
							</a>
							<div class="ml-3 mt-2">
								<div class="text-lg">${ scrapRecipe.title }</div>
								<div>${ scrapRecipe.extra__writerName }</div>
								<!-- 좋아요 , 조회수 -->
								<div class="text-sm">
									<span class="text-red-500 mr-1">
										<i class="fa-solid fa-heart"></i>
										${ scrapRecipe.goodRP }
									</span>
									<span class="text-gray-500">조회수 ${ scrapRecipe.hitCount }</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</section>
	</div>
</div>


<%@include file="../common/foot.jspf"%>