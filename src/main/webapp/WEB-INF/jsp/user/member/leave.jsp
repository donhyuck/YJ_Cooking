<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원탈퇴" />
<%@include file="../common/head.jspf"%>

<div class="member-box w-2/5 mx-auto">
	<form class="flex flex-col space-y-10 items-center" method="POST" action="../member/doLeave">
		<!-- 비밀번호 확인 인증코드 -->
		<input type="hidden" name="memberLeaveAuthKey" value="${ param.memberLeaveAuthKey }">

		<div class="text-3xl font-bold text-red-400">
			<i class="fa-solid fa-bell"></i>
			<span>알림</span>
		</div>

		<!-- 안내문구 -->
		<div>
			<ul class="list-disc flex flex-col space-y-5 text-lg">
				<li>탈퇴시 본 계정은 더 이상 이용할 수 없습니다.</li>
				<li>등록하신 레시피, 게시물 등은 탈퇴 후에도 삭제되지 않습니다.</li>
				<li>
					<a href="/user/list/note" class="link link-primary">레시피 노트</a>
					에서 '내가 등록한 레시피'를 확인해주세요.
				</li>
				<br />
				<li>탈퇴를 원하시면 아래 <span class="text-pink-500 font-bold">회원탈퇴</span> 버튼을 클릭해주세요.</li>
			</ul>
		</div>

		<div class="btns flex gap-7">
			<a href="/user/member/myPage" class="btn btn-outline">마이홈으로</a>
			<button type="submit" class="btn btn-secondary btn-outline">회원탈퇴</button>
		</div>
	</form>

</div>

<%@include file="../common/foot.jspf"%>