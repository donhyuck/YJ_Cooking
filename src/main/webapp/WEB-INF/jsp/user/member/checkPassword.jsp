<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀번호 확인 페이지" />
<%@include file="../common/head.jspf"%>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let MemberCheckPassword_submitFormDone = false;

	function MemberCheckPassword_submitForm(form) {

		if (MemberCheckPassword_submitFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.inputLoginPw.value = form.inputLoginPw.value.trim();
		if (form.inputLoginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.inputLoginPw.focus();
			return;
		}

		// 비밀번호 암호화
		if (form.inputLoginPw.value.length != 0) {
			form.loginPw.value = sha256(form.inputLoginPw.value);
			form.inputLoginPw.value = '';
		}

		MemberCheckPassword_submitFormDone = true;
		form.submit();
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

<div class="mt-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" action="../member/doCheckPassword"
			onsubmit="MemberCheckPassword_submitForm(this); return false;">

			<!-- 비밀번호가 확인된 경우 이동할 경로 -->
			<input type="hidden" name="replaceUri" value="${ param.replaceUri }">
			<!-- 암호화된 비밀번호 -->
			<input type="hidden" name="loginPw">

			<!-- 안내영역 -->
			<div class="text-3xl font-bold mb-2">비밀번호 재확인</div>
			<div class="text-lg text-gray-500">본인확인을 위해 비밀번호를 다시 한 번 입력해주세요.</div>

			<!-- 아이디 (고정) -->
			<div class="pt-5">
				<label class="input-group">
					<span class="text-2xl">
						<i class="fa-solid fa-user"></i>
					</span>
					<input type="text" value="${ rq.loginedMember.loginId }" class="input input-lg input-bordered w-96 max-w-xs"
						disabled="disabled" />
				</label>
			</div>
			
			<!-- 비밀번호 입력 -->
			<div class="pt-5">
				<label class="input-group">
					<span class="text-2xl">
						<i class="fa-solid fa-lock"></i>
					</span>
					<input name="inputLoginPw" type="password" class="input input-lg input-bordered w-96 max-w-xs"
						placeholder="현재 비밀번호" />
				</label>
			</div>

			<div class="flex flex-col pt-5 text-center">
				<div class="flex justify-center space-x-7">
					<button type="button" class="btn btn-outilne" onclick="history.back();">뒤로가기</button>
					<button type="submit" class="btn btn-primary btn-outline">확인</button>
				</div>
				<div class="pl-8">
					<div class="text-red-400 mt-8">* 아이디/비밀번호가 기억안나시나요? *</div>
					<div class="flex justify-center space-x-1">
						<a href="${rq.findLoginIdUri}" type="submit" class="btn btn-sm btn-link">아이디 찾기</a>
						<a href="${rq.findLoginPwUri}" type="submit" class="btn btn-sm btn-link">비밀번호 찾기</a>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<%@include file="../common/foot.jspf"%>