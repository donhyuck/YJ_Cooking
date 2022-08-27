<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 목록페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="grid grid-cols-4">
				<!-- 레시피 목록 영역 시작 -->
				<c:forEach var="recipe" items="${ choicedRecipes }">
					<div class="card w-64 bg-base-100 shadow-xl my-8">
						<!-- 레시피 대표 사진 -->
						<figure>
							<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
								alt="" />
						</figure>
						<!-- 안내영역, 제목, 등록자, 설명일부, 하트 스크랩 수 -->
						<div class="card-body">
							<h2 class="card-title">
								${ recipe.title }
								<div class="badge badge-secondary">NEW</div>
							</h2>
							<p class="overflow-hidden">${ recipe.body }</p>
							<div class="card-actions justify-end">
								<div class="badge badge-outline">조회수 11</div>
								<div class="badge badge-outline">
									<span class="text-red-500 mr-1">
										<i class="fa-solid fa-heart"></i>
									</span>
									12
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
				<!-- 레시피 목록 영역 끝 -->
			</div>
		</section>
	</div>
</div>



<%@include file="../common/foot.jspf"%>