<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀번호 확인 페이지" />
<%@include file="../common/head.jspf"%>

<div class="mt-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" action="../member/doCheckPassword">
			<!-- 비밀번호가 확인된 경우 이동할 경로 -->
			<input type="hidden" name="replaceUri" value="${ param.replaceUri }">

			<!-- 안내영역 -->
			<div class="text-3xl font-bold mb-2">비밀번호 재확인</div>
			<div class="text-lg text-gray-500">본인확인을 위해 비밀번호를 다시 한 번 입력해주세요.</div>

			<!-- 비밀번호 입력 -->
			<div>
				<div class="text-gray-400 p-2">아이디</div>
				<div class="border border-gray-700 rounded-lg w-96 max-w-xs member-inputType flex items-center">
					<div class="ml-3">${ rq.loginedMember.loginId }</div>
				</div>
			</div>
			<div>
				<div class="text-gray-400 p-2">비밀번호</div>
				<input name="loginPw" type="password" required="required"
					class="input input-bordered w-96 max-w-xs member-inputType" placeholder="현재 비밀번호" />
			</div>

			<div class="btns mt-3 text-center">
				<button type="button" class="btn btn-outilne mr-3" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn btn-primary btn-outline">확인</button>
				<div>
					<div class="mb-1 mt-3">* 비밀번호가 기억안나시나요? *</div>
					<a href="/user/member/findLoginPw" class="btn btn-sm btn-warning">비밀번호 찾기</a>
				</div>
			</div>
		</form>
	</div>
</div>

<%@include file="../common/foot.jspf"%>