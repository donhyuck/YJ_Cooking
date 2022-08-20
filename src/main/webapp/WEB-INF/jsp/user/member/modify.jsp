<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원정보 수정" />
<%@include file="../common/head.jspf"%>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let MemberModify_submitFormDone = false;

	function MemberModify_submitForm(form) {
		if (MemberModify_submitFormDone) {
			alert('처리중입니다.');
			return;
		}

		// 비밀번호 변경을 위해 입력한 경우
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호확인을 입력해주세요.');
				form.loginPwConfirm.focus();
				return;
			}
			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호확인이 일치하지 않습니다.');
				form.loginPwConfirm.focus();
				return;
			}
		}

		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요.');
			form.nickname.focus();
			return;
		}
		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('연락처를 입력해주세요.');
			form.cellphoneNo.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		MemberModify_submitFormDone = true;
		form.submit();
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

<div class="mt-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" action="../member/doModify"
			onsubmit="MemberModify_submitForm(this); return false;">
			<!-- 로그인한 회원의 정보 -->
			<c:set var="member" value="${ rq.loginedMember }" />
			<!-- 비밀번호 확인 인증코드 -->
			<input type="hidden" name="memberModifyAuthKey" value="${ param.memberModifyAuthKey }">

			<div class="text-3xl font-bold mb-2">회원정보 수정</div>
			<div>
				<div class="text-gray-400 p-2">아이디</div>
				<div class="border border-gray-700 rounded-lg w-96 member-inputType flex items-center">
					<div class="ml-3">${ member.loginId }</div>
				</div>
			</div>
			<div>
				<div class="text-gray-400 p-2">신규 비밀번호</div>
				<input name="loginPw" type="password" class="input input-bordered w-96 member-inputType" placeholder="비밀번호" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<div class="text-gray-400 p-2">비밀번호 확인</div>
				<input name="loginPwConfirm" type="password" class="input input-bordered w-96 member-inputType"
					placeholder="비밀번호 확인" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<div class="text-gray-400 p-2">닉네임</div>
				<input name="nickname" type="text" value="${ member.nickname }" class="input input-bordered w-96 member-inputType"
					placeholder="닉네임" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<div class="text-gray-400 p-2">연락처</div>
				<input name="cellphoneNo" type="text" value="${ member.cellphoneNo }"
					class="input input-bordered w-96 member-inputType" placeholder="연락처 예) 하이픈(-) 제외" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<div class="text-gray-400 p-2">이메일</div>
				<input name="email" type="email" value="${ member.email }" class="input input-bordered w-96 member-inputType"
					placeholder="이메일" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>

			<div class="btns mt-2">
				<button type="button" class="btn btn-outilne" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn btn-primary btn-outline">정보수정</button>
			</div>
		</form>

	</div>
</div>

<%@include file="../common/foot.jspf"%>