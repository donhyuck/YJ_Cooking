<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="아이디 찾기" />
<%@include file="../common/head.jspf"%>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let MemberFindLoginId_submitFormDone = false;

	function MemberFindLoginId_submitForm(form) {
		if (MemberFindLoginId_submitFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();
			return;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		MemberFindLoginId_submitFormDone = true;
		form.submit();
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

<div class="mt-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" action="../member/doFindLoginId"
			onsubmit="MemberFindLoginId_submitForm(this); return false;">
			<!-- 아이디를 찾은 후 이동할 경로 -->
			<input type="hidden" name="afterFindLoginIdUri" value="${ param.afterFindLoginIdUri }">

			<!-- 안내영역 -->
			<div class="text-3xl font-bold mb-2">아이디 찾기</div>
			<div class="text-lg text-gray-500">회원가입시 입력한 닉네임과 이메일을 입력해주세요.</div>

			<!-- 닉네임, 이메일 입력 -->
			<div>
				<input name="nickname" type="text" class="input input-bordered w-96 max-w-xs member-inputType" placeholder=" 닉네임" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="email" type="email" class="input input-bordered w-96 max-w-xs member-inputType" placeholder=" 이메일" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>

			<div class="flex flex-col pt-5 text-center">
				<div class="flex justify-center space-x-7">
					<button type="button" class="btn btn-outilne" onclick="history.back();">뒤로가기</button>
					<button type="submit" class="btn btn-primary btn-outline">찾기</button>
				</div>
				<div class="text-red-400 mt-8">* 비밀번호가 기억안나시나요? *</div>
				<div class="flex justify-center">
					<a href="${rq.findLoginPwUri}" type="submit" class="btn btn-sm btn-link">비밀번호 찾기</a>
				</div>
			</div>
		</form>

	</div>
</div>

<%@include file="../common/foot.jspf"%>