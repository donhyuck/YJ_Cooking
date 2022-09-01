<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="추천레시피" />
<%@include file="../common/listhead.jspf"%>

<section class="second-bar bg-green-400 opacity-80 w-full h-16">
	<div class="menu-box flex items-center justify-around h-full text-center text-lg font-bold px-40">
		<a href="/user/list/suggest?page=1" class="">
			<div class="text-yellow-300">추천 레시피</div>
			<div class="text-xs">오늘 뭐 먹지?</div>
		</a>
		<a href="/user/list/category" class="">
			<div class="text-white hover:text-yellow-300">레시피 모아보기</div>
			<div class="text-xs font-normal text-black">맛있는 한 끼를 찾아서</div>
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
		<section class="bg-white rounded-md p-4 mb-5">
			<!-- 안내문구 -->
			<div class="px-3 pt-3 mx-4">
				<div class="text-3xl">추천 레시피</div>
				<div class="text-xl text-gray-500 mt-1">원하시는 추천순서를 선택하세요. ${tabCode}</div>

				<!-- 탭메뉴 -->
				<div class="tabs mt-4 font-bold text-center">
					<a href="?tabCode=1"
						class="tab tab-lg tab-bordered rounded-t-xl ${ param.tabCode == 1 ? 'tab-active bg-yellow-200' : '' }">
						<span class="text-2xl">종합</span>
					</a>
					<a href="?tabCode=2"
						class="tab tab-lg tab-bordered rounded-t-xl ${ param.tabCode == 2 ? 'tab-active bg-yellow-200' : '' }">
						<span class="text-2xl">조회수</span>
						<span class="text-black ml-1">
							<i class="fa-solid fa-arrow-pointer"></i>
						</span>
					</a>
					<a href="?tabCode=3"
						class="tab tab-lg tab-bordered rounded-t-xl ${ param.tabCode == 3 ? 'tab-active bg-yellow-200' : '' }">
						<span class="text-2xl">스크랩</span>
						<span class="text-yellow-400 ml-1">
							<i class="fa-solid fa-file"></i>
						</span>
					</a>
					<a href="?tabCode=4"
						class="tab tab-lg tab-bordered rounded-t-xl ${ param.tabCode == 4 ? 'tab-active bg-yellow-200' : '' }">
						<span class="text-2xl">좋아요</span>
						<span class="text-red-500 ml-1">
							<i class="fa-solid fa-heart"></i>
						</span>
					</a>
				</div>
			</div>

			<!-- 추천 전체 레시피 영역 시작 -->
			<div class="grid grid-cols-4 border-2 rounded-xl border-gray-300 pt-5">
				<c:forEach var="recipe" items="${ moreSuggestRecipes }">
					<input type="hidden" name="tabCode" value="${ param.tabCode }">
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