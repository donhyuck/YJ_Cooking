<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 목록페이지" />
<%@include file="../common/listhead.jspf"%>

<section class="second-bar bg-green-400 opacity-80 w-full h-16">
	<div class="menu-box flex items-center justify-around h-full text-center text-lg font-bold px-40">
		<a href="/user/list/suggest?page=1" class="">
			<div class="text-white hover:text-yellow-300">추천 레시피</div>
			<div class="text-xs font-normal text-black">오늘 뭐 먹지?</div>
		</a>
		<a href=/user/list/category class="">
			<div class="text-yellow-300">레시피 모아보기</div>
			<div class="text-xs">맛있는 한 끼를 찾아서</div>
		</a>
		<a href="/user/list/rank" class="">
			<div class="text-white hover:text-yellow-300">랭킹보기</div>
			<div class="text-xs font-normal text-black">명예의 전당</div>
		</a>
		<a href="/user/list/note?page=1" class="">
			<div class="text-white hover:text-yellow-300">레시피 노트</div>
			<div class="text-xs font-normal text-black">나만의 요리사전</div>
		</a>
	</div>
</section>

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
			<div class="flex border-b border-gray-400 p-5 mx-4 mb-8">
				<!-- 선택 상황 보기 -->
				<div class="flex space-x-4 items-center">
					<span class="text-3xl">${ boardName }</span>
					<span class="text-2xl font-bold">
						<i class="fa-solid fa-angle-right"></i>
					</span>
					<span class="text-2xl">${ category.name }</span>
				</div>

				<!-- 추가 선택영역 시작-->
				<div class="ml-10">
					<span class="text-gray-400 ml-2">다른 레시피를 찾아보세요.</span>
					<div class="form-control mt-2">
						<div class="flex w-full max-w-xs space-x-4">
							<select class="select w-3/5">
								<option disabled selected>선택1</option>
								<option>종류</option>
								<option>방법</option>
								<option>재료</option>
								<option>자유</option>
							</select>
							<select class="select w-3/5">
								<option disabled selected>선택2</option>
								<option>Star Wars</option>
								<option>Harry Potter</option>
								<option>Lord of the Rings</option>
								<option>Planet of the Apes</option>
								<option>Star Trek</option>
							</select>
						</div>
					</div>
				</div>
				<!-- 추가 선택영역 끝-->
			</div>
			<!-- 안내영역 끝-->

			<!-- 선택한 레시피 영역 시작 -->
			<div class="grid grid-cols-4">
				<c:forEach var="recipe" items="${ choicedRecipes }">
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
			<!-- 선택한 레시피 영역 끝 -->
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>