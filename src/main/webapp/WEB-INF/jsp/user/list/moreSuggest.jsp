<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 추천페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="bg-white rounded-md p-4 mb-5">
			<!-- 안내문구 -->
			<div class="p-3 mx-4 mb-3">
				<div class="text-3xl">추천 레시피</div>
				<div class="text-2xl">TOP 50 -</div>
				<div class="text-xl">
					<span class="text-black">
						<i class="fa-solid fa-arrow-pointer"></i>
					</span>
					<span class="text-red-500 mr-1">
						<i class="fa-solid fa-heart"></i>
					</span>
					<span class="text-yellow-400 mr-1">
						<i class="fa-solid fa-file"></i>
					</span>
				</div>
			</div>

			<!-- 추천 전체 레시피 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ moreSuggestRecipes }">
					<div
						class="w-64 h-80 mx-auto mb-10 flex flex-col justify-between rounded-2xl shadow-xl border-2 border-white hover:border-yellow-500">

						<div class="w-full">
							<!-- 레시피 대표 사진 -->
							<a href="/user/recipe/detail?id=${ recipe.id }">
								<img class="w-full rounded-t-2xl"
									src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0" alt="" />
							</a>

							<!-- 제목 -->
							<div class="recipe-title text-lg font-bold mt-3 mx-2">
								<span>${ recipe.title }</span>
							</div>
						</div>

						<!-- 작성자, 설명일부, 레시피 정보 -->
						<div class="recipe-info flex flex-col">
							<div class="flex justify-between mx-2">
								<!-- 작성자 -->
								<a href="/user/member/detail?memberId=${ recipe.memberId }" class="badge badge-primary">
									<span>${ recipe.extra__writerName }</span>
								</a>

								<!-- 조회수 좋아요 -->
								<div>
									<div class="badge badge-outline">
										<span>조회수 ${ recipe.hitCount }</span>
									</div>
									<div class="badge badge-outline">
										<span class="text-red-500 mr-1">
											<i class="fa-solid fa-heart"></i>
										</span>
										${ recipe.goodRP }
									</div>
								</div>
							</div>

							<!-- 내용일부 -->
							<div class="text-gray-500 m-2 truncate ...">${ recipe.body }</div>

						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 추천 전체 레시피 영역 영역 끝 -->
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>