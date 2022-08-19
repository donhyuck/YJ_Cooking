<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
<%@include file="../common/head.jspf"%>

<script>
	let submitLoginFormDone = false;

	function submitLoginForm(form) {
		if (submitLoginFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('로그인아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}

		submitLoginFormDone = true;
		form.submit();
	}
</script>

<div class="mt-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" action="../member/doLogin"
			onsubmit="submitLoginForm(this); return false;">
			<div class="text-3xl font-bold mb-2">로그인</div>
			<div>
				<input name="loginId" type="text" class="input input-bordered w-96 max-w-xs member-inputType" placeholder=" 아이디" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="loginPw" type="password" class="input input-bordered w-96 max-w-xs member-inputType" placeholder=" 비밀번호" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>

			<div class="btns mt-2">
				<button type="button" class="btn btn-outilne" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn btn-primary btn-outline">로그인</button>
			</div>
		</form>

	</div>
</div>

<%@include file="../common/foot.jspf"%>