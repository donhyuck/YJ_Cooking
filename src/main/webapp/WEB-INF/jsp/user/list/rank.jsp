<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 랭킹" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">

		<section class="bg-white rounded-md p-4 mb-5">
			<!-- 안내문구 -->
			<div class="p-3 mx-4">
				<div class="text-3xl">명예의 전당</div>
				<div class="text-2xl text-red-400 font-bold">BEST 10</div>
			</div>

			<!-- 레시피 랭킹 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ rankRecipes }">
					<div
						class="w-64 h-80 mx-auto mb-10 flex flex-col justify-between rounded-2xl shadow-xl border-2 border-white hover:border-yellow-500">

						<div class="w-full relative">
							<!-- 랭킹 번호 -->
							<div class="rank-number w-10 h-10 absolute -top-2 -left-2 bg-white border-2 rounded-lg">
								<div class="font-bold text-center mt-2">${ recipe.extra__rank }</div>
							</div>

							<!-- 레시피 대표 사진 -->
							<a href="/user/recipe/detail?id=${ recipe.id }&listUri=${ Ut.getUriEncoded('/user/list/rank') }"
								class=" flex flex-col justify-center items-center bg-gray-200 border rounded-xl border-gray-300">
								<img class="object-contain w-64 h-44 rounded-md" src="${rq.getMainRecipeImgUri(recipe.id)}"
									onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" alt="" />
							</a>

							<!-- 제목 -->
							<div class="recipe-title text-lg font-bold mt-3 mx-2 truncate ...">
								<span>${ recipe.title }</span>
							</div>
						</div>

						<!-- 등록자, 설명일부, 레시피 정보 -->
						<div class="recipe-info flex flex-col">
							<div class="mx-2">
								<!-- 작성자 -->
								<a href="/user/member/detail?memberId=${ recipe.memberId }" class="badge badge-primary">
									<span>${ recipe.extra__writerName }</span>
								</a>

								<!-- 조회수 좋아요 스크랩 -->
								<div>
									<div class="badge badge-outline">
										<span class="text-black mr-1">
											<i class="fa-solid fa-arrow-pointer"></i>
										</span>
										${ recipe.hitCount }
									</div>
									<div class="badge badge-outline">
										<span class="text-red-500 mr-1">
											<i class="fa-solid fa-heart"></i>
										</span>
										${ recipe.goodRP }
									</div>
									<div class="badge badge-outline">
										<span class="text-yellow-400 mr-1">
											<i class="fa-solid fa-file"></i>
										</span>
										${ recipe.scrap }
									</div>
								</div>
							</div>

							<!-- 내용일부 -->
							<div class="text-gray-500 m-2 truncate ...">${ recipe.body }</div>

						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 레시피 랭킹 영역 끝 -->
		</section>

		<section class="bg-white rounded-md p-4 mb-5">
			<!-- 안내문구 -->
			<div class="p-3 mx-4">
				<div class="text-3xl">함께 먹어요</div>
				<div class="text-2xl text-red-400 font-bold">스크랩순 BEST 10</div>
			</div>

			<!-- 최다 스크랩된 레시피 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ manyScrapRecipes }">
					<div
						class="w-64 h-80 mx-auto mb-10 flex flex-col justify-between rounded-2xl shadow-xl border-2 border-white hover:border-yellow-500">

						<div class="w-full relative">
							<!-- 랭킹 번호 -->
							<div class="rank-number w-10 h-10 absolute -top-2 -left-2 bg-white border-2 rounded-lg">
								<div class="font-bold text-center mt-2">${ recipe.extra__rank }</div>
							</div>

							<!-- 레시피 대표 사진 -->
							<a href="/user/recipe/detail?id=${ recipe.id }&listUri=${ Ut.getUriEncoded('/user/list/rank') }"
								class=" flex flex-col justify-center items-center bg-gray-200 border rounded-xl border-gray-300">
								<img class="object-contain w-64 h-44 rounded-md" src="${rq.getMainRecipeImgUri(recipe.id)}"
									onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" alt="" />
							</a>

							<!-- 제목 -->
							<div class="recipe-title text-lg font-bold mt-3 mx-2">
								<span>${ recipe.title }</span>
							</div>
						</div>

						<!-- 등록자, 설명일부, 레시피 정보 -->
						<div class="recipe-info flex flex-col">
							<div class="flex justify-between mx-2">
								<!-- 작성자 -->
								<a href="/user/member/detail?memberId=${ recipe.memberId }" class="badge badge-primary">
									<span>${ recipe.extra__writerName }</span>
								</a>

								<!-- 스크랩 -->
								<div class="badge badge-outline">
									<span class="text-yellow-400 mr-1">
										<i class="fa-solid fa-file"></i>
									</span>
									${ recipe.scrap }
								</div>
							</div>

							<!-- 내용일부 -->
							<div class="text-gray-500 m-2 truncate ...">${ recipe.body }</div>

						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 최다 스크랩된 레시피 영역 끝 -->
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>