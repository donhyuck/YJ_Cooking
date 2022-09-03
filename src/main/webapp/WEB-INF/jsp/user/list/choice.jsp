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

<!-- 다중 셀렉트박스 동적 생성 스크립트 시작 -->
<script type="text/javascript">
	$(function() {
		<!-- 기본상태 -->
		choiceCategory('1', '1');
	});
</script>

<script type="text/javascript">
	function choiceCategory(type, select) {

		$('#relId').empty();

		<!-- 현재 선택사항 -->
		$('#relId').append("<option select>${ nowCategoryName }</option>'");
		$('#relId').append("<option disabled>소분류</option>'");
		
		if (type == '1') {
			$('#relId').append("<option value='11' >aa</option>'");
		} else if (type == '2') {
			$('#relId').append("<option value='21' >bb</option>'");
		} else if (type == '3') {
			$('#relId').append("<option value='31' >cc</option>'");
		} else if (type == '4') {
			$('#relId').append("<option value='41' >dd</option>'");
		} else {
			$('#relId').append("<option value='00' >전체</option>'");
		}

		document.getElementById("relId").style.display = "";

		if ($.trim(select) != "") {
			$('#selectBoard').val(type);
			$('#relId').val(select);
		}
	}
</script>
<!-- 다중 셀렉트박스 동적 생성 스크립트 끝 -->

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
					<span class="text-3xl">${ nowBoardName }</span>
					<span class="text-2xl font-bold">
						<i class="fa-solid fa-angle-right"></i>
					</span>
					<span class="text-2xl">${ nowCategoryName }</span>
				</div>

				<!-- 추가 선택영역 시작-->
				<div class="ml-auto mr-20 w-5/12">
					<div class="text-gray-400 ml-2 mb-2">다른 레시피를 찾아보세요.</div>
					<form class="flex w-full max-w-xs space-x-4">

						<!-- 대분류 선택 -->
						<select id="selectBoard" name="boardId" class="select select-bordered w-3/5" onChange="choiceCategory(this.value)">
							<option select class="text-lg bg-green-100">${ nowBoardName }</option>
							<option disabled class="text-lg text-gray-400">대분류</option>
							<option value="0" class="text-lg">전체</option>
							<c:forEach var="board" items="${ boards }">
								<option value="${ board.id }" class="text-lg">${ board.boardName }</option>
							</c:forEach>
						</select>
						<!-- 소분류 선택 -->
						<select id="relId" name="relId" class="select select-bordered w-3/5 text-lg"></select>

						<button type="submit" class="btn btn-success">찾기</button>
					</form>
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