<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피노트" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="bg-white rounded-md p-4 mb-5">

			<c:set var="pageMenuArmLen" value="3" />
			<c:set var="startPage" value="${page - pageMenuArmLen >= 1 ? page - pageMenuArmLen : 1}" />
			<c:set var="endPage" value="${page + pageMenuArmLen <= pagesCount ? page + pageMenuArmLen : pagesCount}" />

			<!-- 안내문구 -->
			<div class="p-3 mx-4 mb-3">
				<div class="text-3xl">내가 등록한 레시피</div>
				<c:if test="${ rq.logined == false }">
					<div class="text-xl text-gray-500 mt-2">
						<a href="${ rq.loginUri }" class="link link-primary">로그인</a>
						후 확인해보세요.
					</div>
				</c:if>
			</div>

			<div class="grid grid-cols-4 mx-6 relative">

				<!-- 좌우 이동 버튼 -->
				<div class="absolute -left-7 top-32 flex justify-center items-center text-gray-400 hover:text-yellow-500">
					<c:if test="${ page > 1 }">
						<a href="?page=${ page-1 }" class="text-6xl font-semibold">〈</a>
					</c:if>
				</div>
				<div class="absolute -right-7 top-32 flex justify-center items-center text-gray-400 hover:text-yellow-500">
					<c:if test="${ page < pagesCount }">
						<a href="?page=${ page+1 }" class="text-6xl font-semibold">〉</a>
					</c:if>
				</div>

				<!-- 등록한 레시피 영역 시작 -->
				<c:forEach var="recipe" items="${ registeredRecipes }">
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

						<!-- 등록자, 설명일부, 레시피 정보 -->
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
				<!-- 등록한 레시피 영역 끝 -->
			</div>

			<!-- 페이징 영역 -->
			<div class="page-menu mb-3">
				<div class="btn-group justify-center">

					<c:if test="${ startPage > 1 }">
						<a href="?page=1" class="btn btn-sm btn-outline">《</a>
					</c:if>

					<c:forEach begin="${ startPage }" end="${ endPage }" var="i">
						<a href="?page=${ i }" class="btn btn-sm ${ param.page == i ? 'btn-active' : '' }">${ i }</a>
					</c:forEach>

					<c:if test="${ endPage < pagesCount }">
						<a href="?page=${ pagesCount }" class="btn btn-sm btn-outline">${ pagesCount }</a>
					</c:if>
				</div>
			</div>
		</section>

		<section class="bg-white rounded-md p-4 mb-5">
			<!-- 안내문구 -->
			<div class="p-3 mx-4">
				<div class="text-3xl">스크랩한 레시피</div>
				<c:if test="${ rq.logined == false }">
					<div class="text-xl text-gray-500 mt-2">
						<a href="${ rq.loginUri }" class="link link-primary">로그인</a>
						후 확인해보세요.
					</div>
				</c:if>
			</div>

			<!-- 스크랩한 레시피 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ scrapRecipes }">
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

						<!-- 등록자, 설명일부, 레시피 정보 -->
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
			<!-- 스크랩한 레시피 영역 끝 -->
		</section>
	</div>
</div>


<%@include file="../common/foot.jspf"%>