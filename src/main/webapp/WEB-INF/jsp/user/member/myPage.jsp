<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.ldh.exam.demo.util.Ut"%>
<c:set var="pageTitle" value="My홈" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<!-- 로그인한 회원의 정보 -->
		<c:set var="member" value="${ rq.loginedMember }" />

		<section class="myPage-box bg-white rounded-md p-4 mb-5">
			<div class="text-2xl mb-1">회원정보</div>
			<div class="myInfo-box flex p-3">

				<!-- 회원 프로필 -->
				<div class="w-80 h-80 flex flex-col justify-center bg-gray-200 border rounded-xl border-gray-300">
					<img class="w-full rounded-xl" src="${rq.getProfileImgUri(rq.loginedMemberId)}"
						onerror="${rq.profileFallbackImgOnErrorHtml}" alt="" />
				</div>

				<div class="p-5 pl-10 w-3/5 relative text-xl">
					<div class="grid grid-cols-3 gap-7 absolute top-8 w-full">
						<div>
							<div class="badge badge-lg badge-outline mb-2">최초 가입일</div>
							<div>${ member.forPrintRegDate_Type2 }</div>
						</div>
						<div class="col-span-2">
							<div class="badge badge-lg badge-outline mb-2">최근 수정일</div>
							<div>${ member.forPrintUpdateDate_Type2 }</div>
						</div>
						<div>
							<div class="badge badge-lg badge-outline mb-2">이메일</div>
							<div>${ member.email }</div>
						</div>
						<div>
							<div class="badge badge-lg badge-outline mb-2">연락처</div>
							<div>${ member.cellphoneNo }</div>
						</div>
						<div>
							<div class="badge badge-lg badge-outline mb-2">닉네임</div>
							<div class="ml-4">${ member.nickname }</div>
						</div>
					</div>
					<div class="flex space-x-4 absolute bottom-8">
						<a href="/user/member/changePhoto" class="btn btn-outline">프로필 사진 변경</a>
						<a href="/user/member/checkPassword?replaceUri=${ Ut.getUriEncoded('../member/modify') }"
							class="btn btn-outline btn-primary">회원정보 수정</a>
						<a href="/user/member/checkPassword?replaceUri=${ Ut.getUriEncoded('../member/leave') }"
							onclick="if (confirm('회원 탈퇴를 하시겠습니까?\n본인확인을 진행해주세요.') == false) return false;"
							class="btn btn-outline btn-secondary">회원탈퇴</a>
					</div>
				</div>
			</div>
		</section>

		<section class="bg-white rounded-md p-4">

			<c:set var="pageMenuArmLen" value="3" />
			<c:set var="startPage" value="${page - pageMenuArmLen >= 1 ? page - pageMenuArmLen : 1}" />
			<c:set var="endPage" value="${page + pageMenuArmLen <= pagesCount ? page + pageMenuArmLen : pagesCount}" />

			<!-- 안내문구 -->
			<div class="p-3 mx-4 mb-1">
				<div class="text-3xl">내가 쓴 댓글</div>
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

				<!-- 댓글 남긴 레시피 영역 시작 -->
				<c:forEach var="recipe" items="${ haveReplyRecipes }">
					<div
						class="w-64 h-84 mx-auto mb-10 flex flex-col justify-between rounded-2xl shadow-xl border-2 border-white hover:border-yellow-500">

						<div class="w-full">
							<!-- 레시피 대표 사진 -->
							<a href="${ rq.getRecipeDetailUriFromList(recipe) }">
								<img class="w-full rounded-t-2xl"
									src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0" alt="" />
							</a>

							<!-- 레시피 번호 -->
							<div class="m-2">
								<span class="badge badge-outline">${ recipe.id }</span>
							</div>

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

							<!-- 댓글일부 -->
							<div class="text-gray-500 m-2 truncate ...">댓글 "${ recipe.extra__replyBody }"</div>

						</div>
					</div>
				</c:forEach>
				<!-- 최근 등록된 레시피 영역 끝 -->
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
	</div>
</div>

<%@include file="../common/foot.jspf"%>