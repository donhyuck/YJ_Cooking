<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="검색결과 페이지" />
<%@include file="../common/head.jspf"%>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let RecipeSearch_submitFormDone = false;

	function RecipeSearch_submitForm(form) {

		if (RecipeSearch_submitFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.searchKeyword.value = form.searchKeyword.value.trim();
		form.searchRange.value = form.searchRange.value.trim();

		RecipeSearch_submitFormDone = true;
		form.submit();
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

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

			<!-- 안내문구 박스 시작 -->
			<div class="w-full px-8 mt-8 pt-10">
				<div class="toggleSearchBox inline py-3 px-5 border rounded-xl bg-white hover:bg-yellow-400">
					<span class="text-xl text-center">검색안내</span>
				</div>
				<div class="searchBox w-11/12 py-4 mx-auto border border-yellow-500 rounded-xl">
					<ul class="flex flex-col space-y-1 list-disc text-lg text-gray-600 mx-10">
						<span class="text-xl font-bold text-purple-400">검색조건 1</span>
						<li>
							<span class="font-bold">
								제목과 내용
								<i class="fa-solid fa-angle-right"></i>
							</span>
							제목과 내용에 포함된 단어로 검색
						</li>
						<span>
							예)
							<i class="fa-solid fa-arrow-pointer"></i>
							제목과 내용
							<i class="fa-solid fa-plus mx-2"></i>
							<i class="fa-regular fa-keyboard"></i>
							"고기"
							<i class="fa-solid fa-equals mx-2"></i>
							닭고기, 돼지고기, 소고기 등 "고기"가 포함된 모든 레시피
						</span>
						<li>
							<span class="font-bold">
								등록번호
								<i class="fa-solid fa-angle-right ml-4"></i>
							</span>
							레시피 번호로 바로 찾기
							<span class="ml-10">
								예)
								<i class="fa-solid fa-arrow-pointer"></i>
								등록번호
								<i class="fa-solid fa-plus mx-2"></i>
								<i class="fa-regular fa-keyboard"></i>
								"12"
							</span>
						</li>
						<li>
							<span class="font-bold">
								회원닉네임
								<i class="fa-solid fa-angle-right"></i>
							</span>
							작성한 레시피 모아보기
							<span class="ml-10">
								예)
								<i class="fa-solid fa-arrow-pointer"></i>
								회원닉네임
								<i class="fa-solid fa-plus mx-2"></i>
								<i class="fa-regular fa-keyboard"></i>
								"홍길동"
							</span>
						</li>
						<div class="border-t border-yellow-400 pt-3">
							<span class="text-xl font-bold text-purple-400">검색조건2</span>
						</div>
						<span class="text-gray-400 text-base">검색조건1과 조합하여 조건을 추가할 수 있습니다.</span>
						<li>
							예) (
							<i class="fa-solid fa-arrow-pointer"></i>
							회원닉네임
							<i class="fa-solid fa-plus mx-1"></i>
							<i class="fa-regular fa-keyboard"></i>
							"홍길동" )
							<i class="fa-solid fa-plus mx-2 text-purple-400"></i>
							(
							<i class="fa-solid fa-arrow-pointer"></i>
							레시피종류
							<i class="fa-solid fa-plus mx-1"></i>
							<i class="fa-regular fa-keyboard"></i>
							"한식" )
							<i class="fa-solid fa-equals mx-2"></i>
							홍길동 회원이 등록한 한식
						</li>
						<li>
							예) (
							<i class="fa-solid fa-arrow-pointer"></i>
							제목만
							<i class="fa-solid fa-plus mx-1"></i>
							<i class="fa-regular fa-keyboard"></i>
							"고기" )
							<i class="fa-solid fa-plus mx-2 text-purple-400"></i>
							(
							<i class="fa-solid fa-arrow-pointer"></i>
							요리방법
							<i class="fa-solid fa-plus mx-1"></i>
							<i class="fa-regular fa-keyboard"></i>
							"찜" )
							<i class="fa-solid fa-equals mx-2"></i>
							고기 제목을 가진 레시피 중 찜 요리
						</li>
						<div class="border-t border-yellow-400 pt-3">
							<span class="text-xl font-bold text-purple-400">포함여부 선택</span>
						</div>
						<span class="text-gray-400 text-base">조건1과 2로 검색할때, 적용하는 옵션입니다.</span>
						<li>
							<span class="font-bold">
								전부포함
								<i class="fa-solid fa-angle-right"></i>
							</span>
							조건1,2 모두 해당하는 레시피를 검색
						</li>
						<li>
							<span class="font-bold">
								하나라도 포함
								<i class="fa-solid fa-angle-right"></i>
							</span>
							조건1 또는 조건2 레시피 모두 검색
							<span class="ml-2">
								예)
								<i class="fa-regular fa-keyboard"></i>
								"고기"
								<i class="fa-solid fa-plus mx-1"></i>
								<i class="fa-regular fa-keyboard"></i>
								"찜"
								<i class="fa-solid fa-equals mx-2"></i>
								"고기" 제목 레시피 전체와 찜 요리전체
							</span>
						</li>
					</ul>
				</div>
			</div>
			<!-- 안내문구 박스 끝 -->

			<!-- 검색결과 영역 시작 -->
			<div class="border-b border-gray-400 p-5 mx-2 mb-8">

				<!-- 검색결과 (검색건수, 검색어) 영역 시작 -->
				<div class="flex space-x-4 items-center mt-4 pb-7 border-b border-dashed border-gray-300">
					<!-- 총 검색건수 -->
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
					<!-- 검색할 경우 '>' 아이콘 표시 -->
					<c:if test="${ searchKeyword != '' || searchRange != '' }">
						<span class="text-xl font-bold">
							<i class="fa-solid fa-angle-right"></i>
						</span>
					</c:if>
					<!-- 입력한 검색어 표시 -->
					<span class="text-xl">
						<c:if test="${ searchKeyword != '' }">
							<span>"${ searchKeyword }"</span>
						</c:if>
						<c:if test="${ searchRange != '' }">
							<c:if test="${ searchKeyword == '' }">
								<span>"${ searchRange }"</span>
							</c:if>
							<c:if test="${ searchKeyword != '' }">
								<span> + "${ searchRange }"</span>
							</c:if>
						</c:if>
					</span>
				</div>
				<!-- 검색결과 (검색건수, 검색어) 영역 끝 -->

				<!-- 검색영역 시작 -->
				<div class="flex justify-between w-full my-2">
					<form class="flex space-x-4 w-full items-center mt-3" onsubmit="RecipeSearch_submitForm(this); return false;">
						<!-- 검색조건 선택 및 검색어 입력 영역 시작 -->
						<div class="w-full pb-5">
							<div class="flex ml-2 w-7/12 justify-between text-purple-400">
								<span>검색조건1</span>
								<span class="pr-12">검색조건2</span>
							</div>
							<!-- 검색조건 1 박스 -->
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
								placeholder="레시피 기본정보">

							<!-- 검색조건 2 박스 -->
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
								<option value="ingredient" class="text-lg">재료, 양념</option>
								<option value="free" class="text-lg">상황</option>
							</select>
							<input type="text" name="searchRange" value="${ param.searchRange }" class="input input-lg input-bordered"
								placeholder="검색조건을 설정해보세요.">

							<button type="submit" class="btn btn-lg btn-success">검색</button>
						</div>
						<!-- 검색조건 선택 및 검색어 입력 영역 끝 -->

						<!-- 포함여부 선택 -->
						<div class="form-control w-60 flex border border-gray-200 rounded-xl p-2">
							<label class="label cursor-pointer">
								<span class="text-lg mr-3">전부포함</span>
								<input type="radio" name="includeOption" value="selectAll" class="radio radio-primary"
									${ (includeOption == 'selectAll') ? 'checked' : '' } />
							</label>
							<label class="label cursor-pointer">
								<span class="text-lg mr-3">하나라도 포함</span>
								<input type="radio" name="includeOption" value="atLeastOne" class="radio radio-primary"
									${ (includeOption == 'atLeastOne') ? 'checked' : '' } />
							</label>
						</div>
					</form>
				</div>
				<!-- 검색영역 끝 -->
			</div>
			<!-- 검색결과 영역 시작 -->

			<!-- 미검색 또는 검색결과 0건인 경우 -->
			<c:if test="${ searchRecipes.size() == 0 || searchRecipes == null }">
				<div class="text-yellow-500 text-2xl ml-8 mb-10">검색결과를 찾을 수 없습니다.</div>
			</c:if>

			<!-- 검색한 레시피 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ searchRecipes }">
					<c:if test="${ recipe != null }">
						<div
							class="w-64 h-80 mx-auto mb-10 flex flex-col justify-between rounded-2xl shadow-xl border-2 border-white hover:border-yellow-500">

							<!-- 레시피 대표 사진, 제목 -->
							<div class="w-full">
								<a href="/user/recipe/detail?id=${ recipe.id }"
									class=" flex flex-col justify-center items-center bg-gray-200 border rounded-xl border-gray-300">
									<img class="object-contain w-64 h-44 rounded-md" src="${rq.getMainRecipeImgUri(recipe.id)}"
										onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" alt="" />
								</a>
								<div class="recipe-title text-lg font-bold mt-3 mx-2">
									<span>${ recipe.title }</span>
								</div>
							</div>

							<!-- 레시피 정보 영역 시작 -->
							<div class="recipe-info flex flex-col">
								<!-- 작성자, 조회수, 좋아요  -->
								<div class="flex justify-between mx-2">
									<a href="/user/member/detail?memberId=${ recipe.memberId }" class="badge badge-primary">
										<span>${ recipe.extra__writerName }</span>
									</a>
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
							<!-- 레시피 정보 영역 끝 -->
						</div>
					</c:if>
				</c:forEach>
			</div>
			<!-- 검색한 레시피 영역 끝 -->
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>