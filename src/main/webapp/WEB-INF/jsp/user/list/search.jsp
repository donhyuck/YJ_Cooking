<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="검색결과 페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">

		<!-- TOP 버튼 -->
		<div class="fixed bottom-10 right-10 text-4xl text-center hover:text-yellow-400">
			<a href="#topTarget" class="scroll">
				<i class="fa-solid fa-circle-arrow-up"></i>
				<div class="text-xl font-black">TOP</div>
			</a>
		</div>

		<section class="bg-white rounded-md px-4 mb-5">

			<!-- 안내영역 시작 -->
			<div class="border-b border-gray-400 p-5 mx-2 mb-8">
				<!-- 선택 상황 보기 -->
				<div class="flex space-x-4 items-center mt-4 pb-7 border-b border-dashed border-gray-300">
					<span class="text-2xl">
						검색결과
						<c:if test="${ searchRecipes.size() == 0 || searchRecipes == null }">
							<span class="text-gray-400 font-bold text-xl">( 0건 )</span>
						</c:if>
						<c:if test="${ searchRecipes.size() != 0 && searchRecipes != null }">
							<c:if test="${ searchKeyword != '' || searchRange != '' }">
								<span class="text-gray-400 font-bold text-xl">( ${ searchRecipes.size() }건 )</span>
							</c:if>
						</c:if>
					</span>
					<c:if test="${ searchKeyword != '' || searchRange != '' }">
						<span class="text-xl font-bold">
							<i class="fa-solid fa-angle-right"></i>
						</span>
					</c:if>
					<span class="text-xl">
						<c:if test="${ searchKeyword != '' }">
							<span>"${ searchKeyword }"</span>
						</c:if>
						<c:if test="${ searchRange != '' }">
							<span> + "${ searchRange }"</span>
						</c:if>
					</span>
				</div>

				<!-- 추가 검색영역 시작-->
				<div class="my-2">
					<div class="text-gray-400 ml-2 mb-2">다른 레시피를 검색해보세요.</div>
					<form class="flex space-x-4 w-full">
						<!-- 검색타입 -->
						<select id="keywordType" name="keywordType" class="select select-lg select-bordered">
							<c:if test="${ keywordTypeName == '미선택' }">
								<option selected disabled class="text-lg bg-green-100">검색타입</option>
							</c:if>
							<c:if test="${ keywordTypeName != '미선택' }">
								<option selected disabled value="${ param.keywordType }" class="text-lg bg-yellow-100">${ keywordTypeName }</option>
							</c:if>
							<option value="keywordTotal" class="text-lg">전체</option>
							<option value="recipeTitle" class="text-lg">제목만</option>
							<option value="titleAndBody" class="text-lg">제목과 내용</option>
							<option value="recipeId" class="text-lg">등록번호</option>
							<option value="recipeWriter" class="text-lg">회원닉네임</option>
						</select>
						<input type="text" name="searchKeyword" value="${ param.searchKeyword }" class="input input-lg input-bordered"
							placeholder="레시피의 제목 또는 내용">

						<!-- 검색분류 -->
						<select id="rangeType" name="rangeType" class="select select-lg select-bordered">
							<c:if test="${ rangeTypeName == '미선택' }">
								<option selected disabled class="text-lg bg-green-100">분류타입</option>
							</c:if>
							<c:if test="${ rangeTypeName != '미선택' }">
								<option selected disabled value="${ param.rangeType }" class="text-lg bg-yellow-100">${ rangeTypeName }</option>
							</c:if>
							<option value="total" class="text-lg">전체</option>
							<option value="sort" class="text-lg">레시피종류</option>
							<option value="method" class="text-lg">요리방법</option>
							<option value="ingredient" class="text-lg">재료,양념</option>
							<option value="free" class="text-lg">상황</option>
						</select>
						<input type="text" name="searchRange" value="${ param.searchRange }" class="input input-lg input-bordered"
							placeholder="검색조건을 설정해보세요.">

						<button type="submit" class="btn btn-lg btn-success">검색</button>
					</form>
				</div>
				<!-- 추가 선택영역 끝-->
			</div>

			<!-- 미검색 -->
			<c:if test="${ searchRecipes.size() == 0 || searchRecipes == null }">
				<div class="text-yellow-500 text-2xl ml-8 mb-10">검색결과를 찾을 수 없습니다.</div>
			</c:if>
			<!-- 안내영역 끝-->

			<!-- 검색한 레시피 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ searchRecipes }">
					<c:if test="${ recipe != null }">
						<div
							class="w-64 h-80 mx-auto mb-10 flex flex-col justify-between rounded-2xl shadow-xl border-2 border-white hover:border-yellow-500">

							<div class="w-full">
								<!-- 레시피 대표 사진 -->
								<a href="/user/recipe/detail?id=${ recipe.id }"
									class=" flex flex-col justify-center items-center bg-gray-200 border rounded-xl border-gray-300">
									<img class="object-contain w-64 h-44 rounded-md" src="${rq.getMainRecipeImgUri(recipe.id)}"
										onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" alt="" />
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
					</c:if>
				</c:forEach>
			</div>
			<!-- 검색한 레시피 영역 끝 -->
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>