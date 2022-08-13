<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My홈" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="myPage-box bg-white rounded-md p-4">
			<div class="text-xl mb-1">My홈</div>
			<div class="myInfo-box flex p-3">
				<div class="w-80">
					<img class="w-full rounded-lg" src="https://cdn.pixabay.com/photo/2017/06/16/13/35/chef-2409158_960_720.png" alt="" />
				</div>
				<div class="ml-5 mt-5">
					<div class="mb-5">
						<div>이메일 : aaaa@ccc.com</div>
						<div>연락처 : 010-1111-1111</div>
						<div>닉네임 : 가가</div>
					</div>
					<div class="flex">
						<a href="">프로필 사진 변경</a>
						<a href="">회원정보 수정</a>
						<a href="">회원탈퇴</a>
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
						<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
							alt="" />
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