<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 목록페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="bg-white rounded-md p-8 mb-5">

			<!-- 선택 안내영역 -->
			<div class="text-3xl border-b border-gray-300 p-3 mx-4">${ boardName }</div>

			<!-- 레시피 목록 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ choicedRecipes }">
					<div class="card w-64 bg-base-100 shadow-xl my-6 bg-red-400">

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
							<a href="/user/member/detail?memberId=${ recipe.memberId }">
								<div class="badge badge-lg badge-primary">${ recipe.extra__writerName }</div>
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
			<!-- 레시피 목록 영역 끝 -->
		</section>
	</div>
</div>



<%@include file="../common/foot.jspf"%>