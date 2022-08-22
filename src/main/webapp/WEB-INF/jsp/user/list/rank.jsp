<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 랭킹" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="today-list bg-white rounded-md p-4">
			<div class="mb-2">
				<div class="text-xl mb-1">명예의 전당</div>
				<div class="text-lg">BEST 10</div>
			</div>
			<div class="flex items-center">
				<a href="#" class="text-3xl mb-20">
					<i class="fa-solid fa-angle-left"></i>
				</a>
				<div class="flex grid grid-cols-3 gap-6">
					<!-- 최다 조회수, 하트를 받은 레시피 -->
					<c:forEach var="recipe" items="${ recipes }">
						<div class="relative">
							<div class="rank-number absolute top-0 w-10 h-10 bg-white border border-2 border-gray-400 rounded-lg">
								<div class="font-bold text-center mt-2">${ recipe.id }</div>
							</div>
							<div class="p-1">
								<a href="/user/recipe/detail?id=${ recipe.id }">
									<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
										alt="" />
								</a>
								<div class="ml-3 mt-2">
									<div class="text-xl">${ recipe.title }</div>
									<div class="text-lg">${ recipe.extra__writerName }</div>
									<span class="text-lg">
										<i class="fa-solid fa-heart text-red-500"></i>
										(12) 조회수 ${ recipe.hitCount }
									</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<a href="#" class="text-3xl mb-20">
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</div>
		</section>

		<section class="recent-list bg-white rounded-md p-4 mt-4">
			<div class="mb-2">
				<div class="text-xl mb-1">함께 먹어요</div>
				<div class="text-lg">최근 많은 사람들이 스크랩 했어요</div>
			</div>
			<div class="flex items-center">
				<a href="#" class="text-3xl mb-20">
					<i class="fa-solid fa-angle-left"></i>
				</a>
				<div class="flex grid grid-cols-3 gap-3">
					<!-- 최다 스크랩된 레시피 -->
					<c:forEach var="recipe" items="${ recipes }">
						<div class="relative">
							<div class="rank-number absolute top-0 w-10 h-10 bg-white border border-2 border-gray-400 rounded-lg">
								<div class="font-bold text-center mt-2">${ recipe.id }</div>
							</div>
							<div class="p-1">
								<a href="/user/recipe/detail?id=${ recipe.id }">
									<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
										alt="" />
								</a>
								<div class="ml-3 mt-2">
									<div class="text-xl">${ recipe.title }</div>
									<div class="text-lg">${ recipe.extra__writerName }</div>
									<span class="text-lg">
										<i class="fa-solid fa-heart text-red-500"></i>
										(12) 조회수 ${ recipe.hitCount }
									</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<a href="#" class="text-3xl mb-20">
					<i class="fa-solid fa-angle-right"></i>
				</a>
			</div>
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>