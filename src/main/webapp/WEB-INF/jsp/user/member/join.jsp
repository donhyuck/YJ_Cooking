<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
<%@include file="../common/head.jspf"%>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let MemberJoin_submitFormDone = false;
	let validLoginId = "";

	function MemberJoin_submitForm(form) {
		if (MemberJoin_submitFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('로그인아이디를 입력해주세요.');
			form.loginId.focus();
			return;
		}

		if (form.loginId.value != validLogind) {
			alert('해당 로그인아이디는 사용할 수 없습니다.');
			form.loginId.focus();
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPw.focus();
			return;
		}
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

		MemberJoin_submitFormDone = true;
		form.submit();
	}

	// 로그인 아이디 확인
	var checkLoginIdDup = _.debounce(function(form) {
		// $message.empty().append('<div class="mt-2"> 아이디를 입력해주세요. </div>');

		$.get('../member/getLoginIdDup', {
			isAjax : 'Y',
			loginId : form.loginId.value
		}, function(data) {

			var $message = $(form.loginId).next();

			if (data.resultCode.substr(0, 2) == 'S-') {
				$message.empty().append(
						'<div class="text-green-400 mt-2 ml-4">' + data.msg
								+ '</div>');
				validLoginId = data.body.loginId;
			} else {
				$message.empty().append(
						'<div class="text-red-400 mt-2 ml-4">' + data.msg
								+ '</div>');
				validLoginId = '';
			}

			if (data.success) {
				validLoginId = data.data1;
			} else {
				validLoginId = '';
			}
		}, 'json');

	}, 1000);

	function MemberJoin_checkLoginIdDupForm(input) {

		var form = input.form;
		form.loginId.value = form.loginId.value.trim();

		var $message = $(form.loginId).next();

		if (form.loginId.value.length == 0) {
			$message.empty();
			return;
		}

		checkLoginIdDup(form);
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

<div class="mt-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" enctype="multipart/form-data"
			action="../member/doJoin" onsubmit="MemberJoin_submitForm(this); return false;">
			<input type="hidden" name="afterLoginUri" value="${ param.afterLoginUri }" />

			<div class="text-3xl font-bold mb-2">회원가입</div>
			<div>
				<input name="loginId" type="text" class="input input-bordered w-96 member-inputType"
					onkeyup="MemberJoin_checkLoginIdDupForm(this);" autocomplete="off" placeholder="아이디" />
				<div class="message-msg"></div>
			</div>
			<div>
				<input name="loginPw" type="password" class="input input-bordered w-96 member-inputType" placeholder="비밀번호" />
				<div class="text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="loginPwConfirm" type="password" class="input input-bordered w-96 member-inputType"
					placeholder="비밀번호 확인" />
				<div class="text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="nickname" type="text" class="input input-bordered w-96 member-inputType" placeholder="닉네임" />
				<div class="text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="cellphoneNo" type="text" class="input input-bordered w-96 member-inputType"
					placeholder="연락처 예) 하이픈(-) 제외" />
				<div class="text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="email" type="email" class="input input-bordered w-96 member-inputType" placeholder="이메일" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="profileImg" type="file" class="input input-bordered w-96 member-inputType"
					placeholder="프로필 이미지를 선택해주세요." />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>

			<div class="btns mt-2">
				<button type="button" class="btn btn-outilne" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn btn-primary btn-outline">회원가입</button>
			</div>
		</form>

	</div>
</div>

<%@include file="../common/foot.jspf"%>