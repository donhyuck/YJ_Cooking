<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.ldh.exam.demo.util.Ut"%>
<c:set var="pageTitle" value="My홈" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<!-- 로그인한 회원의 정보 -->
		<c:set var="member" value="${ rq.loginedMember }" />

		<section class="myPage-box bg-white rounded-md p-4">
			<div class="text-2xl mb-1">회원정보</div>
			<div class="myInfo-box flex p-3">
				<div class="w-80">
					<img class="w-full rounded-lg" src="https://cdn.pixabay.com/photo/2017/06/16/13/35/chef-2409158_960_720.png" alt="" />
				</div>
				<div class="p-5 w-3/5 relative text-lg">
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
							<div>${ member.forPrintCellphoneNo }</div>
						</div>
						<div>
							<div class="badge badge-lg badge-outline mb-2 -ml-2">닉네임</div>
							<div>${ member.nickname }</div>
						</div>
					</div>
					<div class="flex space-x-4 absolute bottom-8">
						<a href="/user/member/changePhoto" class="btn btn-outline">프로필 사진 변경</a>
						<a href="/user/member/checkPassword?replaceUri=${ Ut.getUriEncoded('../member/modify') }"
							class="btn btn-outline btn-primary">회원정보 수정</a>
						<a href="/user/member/doLeave" class="btn btn-outline btn-secondary"
							onclick="if (confirm('회원 탈퇴를 하시겠습니까?') == false) return false;">회원탈퇴</a>
					</div>
				</div>
			</div>
		</section>
		<section class="myAction-list bg-white rounded-md p-4 mt-4">
			<div class="mb-2">
				<div class="text-xl mb-1">내가 좋아요 한 레시피</div>
			</div>
			<div class="flex">
				<c:forEach begin="1" end="4">
					<div class="mx-3">
						<a href="/user/recipe/detail?id=1">
							<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
								alt="" />
						</a>
						<div class="ml-3 mt-2">
							<div class="text-lg">이건 감자볶음</div>
							<div>홍길동</div>
							<span class="text-sm">
								<i class="fa-solid fa-heart text-red-500"></i>
								(12) 조회수 85
							</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>

		<section class="myAction-list bg-white rounded-md p-4 mt-4">
			<div class="mb-2">
				<div class="text-xl mb-1">내가 스크랩 한 레시피</div>
			</div>
			<div class="flex">
				<c:forEach begin="1" end="4">
					<div class="mx-3">
						<a href="/user/recipe/detail?id=1">
							<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
								alt="" />
						</a>
						<div class="ml-3 mt-2">
							<div class="text-lg">이건 감자볶음</div>
							<div>홍길동</div>
							<span class="text-sm">
								<i class="fa-solid fa-heart text-red-500"></i>
								(12) 조회수 85
							</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>