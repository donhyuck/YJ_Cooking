<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세페이지" />
<%@include file="../common/head.jspf"%>

<!-- 게시글 조회수 스크립트 시작 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function RecipeDetail__increaseHitCount() {
		<!-- 이미 읽은 레시피는 조회수 증가 요청이 없도록 -->
		/*
		const localStorageKey = 'recipe__' + params.id + '__viewDone';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);
		*/
		
		<!-- 조회수 증가 메서드 작동 -->
		$.get('../recipe/doIncreaseHitCount', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.recipe-detail__hitCount').empty().html(data.data1);
		}, 'json');
	}
	$(function() {
		// 실전코드
		// RecipeDetail__increaseHitCount();
		// 임시코드
		setTimeout(RecipeDetail__increaseHitCount, 300);
	})
</script>
<!-- 게시글 조회수 스크립트 끝 -->

<div class="bg-gray-200 py-4">
	<div class="detail-box w-10/12 mx-auto">

		<!-- 레시피 기본정보 영역 시작 -->
		<section class="bg-white rounded-md p-12 flex mb-5">
			<!-- 대표사진-->
			<div class="main-photo w-3/6">
				<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
					alt="" />
				<div class="text-right text-gray-400 text-lg mt-2 mr-4">
					조회수
					<span class="recipe-detail__hitCount">${ recipe.hitCount }</span>
				</div>
			</div>

			<div class="flex flex-col w-2/5 h-80 m-auto">
				<!-- 제목, 내용 -->
				<div class="text-3xl">${ recipe.title }</div>
				<div class="text-xl text-gray-400 mt-5">${ recipe.body }</div>
				<!-- 인원, 소요시간, 난이도 -->
				<div class="info-box flex justify-center items-end space-x-5 mt-auto mb-3 text-2xl">
					<div>
						<i class="fa-solid fa-user-check"></i>
						<span class="ml-1">${ recipe.amount }인분</span>
					</div>
					<div>
						<i class="fa-solid fa-clock"></i>
						<span class="ml-1">${ recipe.forPrintTime } 이내</span>
					</div>
					<div>
						<i class="fa-solid fa-star"></i>
						<span class="ml-1">${ recipe.forPrintLevel }</span>
					</div>
				</div>
			</div>
		</section>
		<!-- 레시피 기본정보 영역 끝 -->

		<!-- 회원 프로필, 리액션 영역 시작 -->
		<section class="bg-white rounded-md p-12 flex mb-5">

			<!-- 등록한 회원정보 -->
			<div class="actor-photo w-60 mr-12">
				<img class="w-full rounded-full" src="https://cdn.pixabay.com/photo/2017/06/16/13/35/chef-2409158_960_720.png"
					alt="" />
				<div class="text-center text-xl mx-auto mt-2">
					<span class="py-3 px-5">${ actorNickname }</span>
				</div>
			</div>

			<!-- 리액션 영역 -->
			<div class="rection-box p-3 w-full flex flex-col">
				<div class="upper-area flex items-center justify-around text-4xl text-center">
					<!-- 스크랩 -->
					<a href="#" class="text-yellow-400">
						<i class="fa-solid fa-paperclip"></i>
						<div class="text-lg font-bold mt-2">스크랩</div>
					</a>
					<!-- 하트 -->
					<a href="#" class="text-red-400">
						<i class="fa-solid fa-heart"></i>
						<div class="text-lg font-bold mt-2">좋아요</div>
					</a>
					<!-- 댓글 -->
					<a href="#" class="text-green-500">
						<i class="fa-solid fa-comment-dots"></i>
						<div class="text-lg font-bold mt-2">댓글보기</div>
					</a>
				</div>

				<div class="under-area flex items-center justify-around mt-12">
					<!-- 팁 / 주의사항 -->
					<div class="text-lg w-2/3 p-4 border border-gray-200 rounded-lg shadow-xl">
						<div class="mb-2 font-bold text-red-600">
							<i class="fa-solid fa-lightbulb"></i>
							<span class="ml-1">팁 / 주의사항</span>
						</div>
						<c:if test="${ recipe.tip != null }">
							<div class="ml-4">${ recipe.tip }</div>
						</c:if>
						<c:if test="${ recipe.tip == null }">
							<div class="ml-4 text-gray-400">오늘도 맛있게! 잘 챙겨드세요.</div>
						</c:if>
					</div>

					<!-- 레시피 조작 영역 시작 -->
					<div class="btns text-center">
						<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
						<div class="mt-3">
							<c:if test="${ recipe.extra__actorCanModify }">
								<a class="btn btn-primary btn-outline mr-1" href="../recipe/modify?id=${recipe.id}">수정</a>
							</c:if>
							<c:if test="${ recipe.extra__actorCanDelete }">
								<a class="btn btn-secondary btn-outline ml-1" href="../recipe/doDelete?id=${ recipe.id }"
									onclick="if ( confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
							</c:if>
						</div>
					</div>
					<!-- 레시피 조작 영역 끝 -->
				</div>
			</div>
		</section>
		<!-- 회원 프로필, 리액션 영역 끝 -->

		<!-- 재료, 양념 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold mb-8">재료 준비</div>
			<div class="flex justify-between space-x-5 text-2xl px-5">
				<div class="w-1/2">
					<div class="font-bold mb-5">[ 재료 ]</div>
					<c:forEach begin="1" end="8" step="1">
						<div class="grid grid-cols-2 mb-2 ml-4 px-3 border-b-2 border-dashed border-gray-300">
							<div class="">버섯</div>
							<div class="text-center">1개</div>
						</div>
					</c:forEach>
				</div>
				<div class="w-1/2">
					<div class="font-bold mb-5">[ 양념 ]</div>
					<c:forEach begin="1" end="5" step="1">
						<div class="grid grid-cols-2 mb-2 ml-4 px-3 border-b-2 border-dashed border-gray-300">
							<div class="">간장</div>
							<div class="text-center">1숟가락</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</section>
		<!-- 재료, 양념 영역 끝 -->

		<!-- 조리순서 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold mb-8">조리순서</div>
			<div class="w-full flex flex-col space-y-8 px-5">
				<c:forEach var="i" begin="1" end="4" step="1">
					<div class="flex">
						<div class="w-1/2 mr-5">
							<img class="rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0" alt="" />
						</div>
						<div class="w-5/6 p-5 flex">
							<div class="w-10 h-10 bg-green-500 rounded-full">
								<div class="font-bold text-center text-white pt-2">${ i }</div>
							</div>
							<div class="text-2xl text-gray-600 ml-5 mt-1 w-5/6">양파를 썬다. 일정하게 1cm간격이 되도록 썬다.</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
		<!-- 조리순서 영역 시작 -->

		<!-- 댓글 영역 시작-->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold mb-8">
				<span>요리후기/댓글</span>
				<span class="text-green-500 text-xl ml-3">11건</span>
			</div>

			<!-- 댓글 목록 영역 시작 -->
			<div class="flex flex-col border-t">
				<c:forEach var="i" begin="1" end="7" step="1">
					<div class="flex border-b p-3 pt-5">
						<div class="w-44">
							<!-- 댓글 프로필 -->
							<div class="actor-photo w-24 mx-auto mb-2">
								<c:if test="${ i == 1 || i == 3 }">
									<img class="w-full rounded-full" src="https://cdn.pixabay.com/photo/2017/06/16/13/35/chef-2409158_960_720.png"
										alt="" />
								</c:if>
								<!-- 대표사진 미등록 회원 -->
								<c:if test="${  i != 1 && i != 3 }">
									<img class="w-full rounded-full border border-gray-400"
										src="https://t4.ftcdn.net/jpg/00/65/77/27/240_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg" alt="" />
								</c:if>
							</div>

							<!-- 댓글 수정, 삭제 영역 시작 -->
							<div class="btns flex items-center space-x-3 justify-center h-12">
								<c:if test="${ i == 1 || i == 6 }">
									<a href="../reply/modify?id=${ reply.id }" class="btn btn-primary btn-outline btn-sm">
										<i class="fas fa-edit"></i>
										<div class="ml-1">수정</div>
									</a>
								</c:if>
								<c:if test="${ i == 1 || i == 6 }">
									<a href="../reply/doDelete?id=${ reply.id }&replaceUri=${rq.encodedCurrentUri}"
										class="btn btn-secondary btn-outline btn-sm" onclick="if( confirm('정말 삭제하시겠습니까?') == false ) return false;">
										<i class="fas fa-trash"></i>
										<div class="ml-1">삭제</div>
									</a>
								</c:if>
							</div>
							<!-- 댓글 수정, 삭제 영역 영역 끝 -->
						</div>

						<div class="ml-8 mr-5 w-full">
							<!-- 작성자, 등록(수정)일 -->
							<div class="flex items-center mb-2 text-gray-400 text-sm">
								<div class="text-xl font-bold text-black mr-3">${ actorNickname }</div>
								<div>
									<!-- test="${ reply.regDate == reply.updateDate } -->
									<c:if test="${ i == 1 || i == 6 }">
										<span>2022-01-01 12:00 &nbsp;(등록)</span>
									</c:if>
									<!-- test="${ reply.regDate == reply.updateDate } -->
									<c:if test="${  i != 1 && i != 6 }">
										<span>2022-01-08 12:10 &nbsp;(수정)</span>
									</c:if>
								</div>
							</div>

							<!-- 댓글 내용 -->
							<div class="ml-2">맛있어요. 12345123451234512345123451234512345123451234512345123451234512345123451234512345</div>
						</div>

						<!-- 요리후기 사진 -->
						<div class="w-80 m-auto">
							<!-- test="${ reply.regDate == reply.updateDate } -->
							<c:if test="${ i == 2 || i == 5 }">
								<img class="rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0" alt="" />
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- 댓글 목록 영역 끝 -->

			<!-- 댓글 작성 영역 시작 -->
			<div class="mt-10">
				<div class="border-b border-gray-300 pl-3 pb-2 mb-3 font-bold text-xl text-yellow-500">
					<span>후기등록</span>
				</div>
				<div class="text-lg text-gray-500 tracking-wide mb-2 ml-3">
					<div>
						<span>${ actorNickname }님</span>
						에게 궁금한점들을남겨주세요.
					</div>
					<c:if test="${ rq.loginedMember == null }">
						<a href="/user/member/login" class="link link-primary">로그인</a> 후 댓글을 남길 수 있습니다.
					</c:if>
				</div>
				<c:if test="${ rq.loginedMember != null }">
					<form class="flex items-center" method="POST" action="../reply/doWrite">
						<!-- 요리후기 사진 등록 -->
						<a href="#"
							class="flex justify-center items-center w-36 h-36 rounded-xl bg-gray-200 hover:bg-gray-300 mr-4 text-4xl">
							<i class="fa-solid fa-plus"></i>
						</a>
						<div class="border border-gray-300 rounded-xl p-2 w-10/12">
							<textarea name="body" rows="5" class="w-full" placeholder="요리후기를 사진과 함께 작성해보세요."></textarea>
						</div>
						<button type="submit" class="w-36 h-36 hover:bg-gray-100 border-double border-4 border-gray-300 rounded-xl ml-3">
							<div class="text-xl">등록</div>
						</button>
					</form>
				</c:if>
			</div>
			<!-- 댓글 작성 영역 끝 -->
		</section>
		<!-- 댓글 영역 끝 -->
	</div>
</div>

<%@include file="../common/foot.jspf"%>