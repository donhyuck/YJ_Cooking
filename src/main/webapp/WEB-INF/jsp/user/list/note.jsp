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
		<section class="bg-white rounded-md p-4 mb-5">
			<!-- 안내문구 -->
			<div class="p-3 mx-4">
				<div class="text-3xl">내가 등록한 레시피</div>
				<div class="text-2xl">끼니 고민 덜어드려요</div>

				<!-- 로그아웃 상태 -->
				<c:if test="${ rq.loginedMember == null }">
					<div class="text-lg text-gray-600 mt-3">
						<a href="/user/member/login" class="link link-primary">로그인</a>
						후 확인해보세요.
					</div>
				</c:if>
			</div>

			<!-- 로그인 상태에서 보이기 -->
			<c:if test="${ rq.loginedMember != null }">
				<!-- 일일추천레시피 -->
				<div class="grid grid-cols-4">
					<c:forEach var="recipe" items="${ recipes }">
						<div class="card w-64 bg-base-100 shadow-xl my-6 border-2 border-base-100 hover:border-yellow-500">

							<!-- 레시피 대표 사진 -->
							<figure>
								<a href="/user/recipe/detail?id=${ recipe.id }">
									<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
										alt="" />
								</a>
							</figure>

							<!-- 안내영역, 제목, 등록자, 설명일부, 하트 스크랩 수 -->
							<div class="card-body">
								<div class="card-title">${ recipe.title }</div>
								<a href="/user/member/detail?memberId=${ recipe.memberId }" class="badge badge-lg badge-primary">
									<span>${ recipe.extra__writerName }</span>
								</a>
								<div class="truncate text-gray-500">${ recipe.body }</div>

								<div class="card-actions justify-end">
									<div class="badge badge-outline">조회수 ${ recipe.hitCount }</div>
									<div class="badge badge-outline">
										<span class="text-red-500 mr-1">
											<i class="fa-solid fa-heart"></i>
										</span>
										${ recipe.goodRP }
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:if>

		</section>

		<section class="bg-white rounded-md p-4 mb-5">

			<!-- 안내문구 -->
			<div class="p-3 mx-4">
				<div class="text-3xl">스크랩한 레시피</div>

				<!-- 로그아웃 상태 -->
				<c:if test="${ rq.loginedMember == null }">
					<div class="text-lg text-gray-600 mt-3">
						<a href="/user/member/login" class="link link-primary">로그인</a>
						후 확인해보세요.
					</div>
				</c:if>
			</div>

			<!-- 로그인 상태에서 보이기 -->
			<c:if test="${ rq.loginedMember != null }">
				<!-- 일일추천레시피 -->
				<div class="grid grid-cols-4">
					<c:forEach var="recipe" items="${ recipes }">
						<div class="card w-64 bg-base-100 shadow-xl my-6 border-2 border-base-100 hover:border-yellow-500">

							<!-- 레시피 대표 사진 -->
							<figure>
								<a href="/user/recipe/detail?id=${ recipe.id }">
									<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
										alt="" />
								</a>
							</figure>

							<!-- 안내영역, 제목, 등록자, 설명일부, 하트 스크랩 수 -->
							<div class="card-body">
								<div class="card-title">${ recipe.title }</div>
								<a href="/user/member/detail?memberId=${ recipe.memberId }" class="badge badge-lg badge-primary">
									<span>${ recipe.extra__writerName }</span>
								</a>
								<div class="truncate text-gray-500">${ recipe.body }</div>

								<div class="card-actions justify-end">
									<div class="badge badge-outline">조회수 ${ recipe.hitCount }</div>
									<div class="badge badge-outline">
										<span class="text-red-500 mr-1">
											<i class="fa-solid fa-heart"></i>
										</span>
										${ recipe.goodRP }
									</div>
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