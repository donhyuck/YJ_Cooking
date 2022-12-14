<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
<%@include file="../common/head.jspf"%>
<!-- ajax 메세지 스크립트 -->
<script src="/member/join.js" defer="defer"></script>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let MemberJoin_submitFormDone = false;

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

		form.inputLoginPw.value = form.inputLoginPw.value.trim();
		if (form.inputLoginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.inputLoginPw.focus();
			return;
		}
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value.length == 0) {
			alert('비밀번호확인을 입력해주세요.');
			form.loginPwConfirm.focus();
			return;
		}

		if (form.inputLoginPw.value != form.loginPwConfirm.value) {
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

		// 프로필 이미지 용량 제한
		const maxSizeMb = 10;
		const maxSize = maxSizeMb * 1204 * 1204;

		const profileImgFileInput = form["file__member__0__extra__profileImg__1"];

		if (profileImgFileInput.value) {
			if (profileImgFileInput.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				profileImgFileInput.focus();

				return;
			}
		}

		// 비밀번호 암호화
		if (form.inputLoginPw.value.length != 0
				&& form.inputLoginPw.value == form.loginPwConfirm.value) {
			form.loginPw.value = sha256(form.inputLoginPw.value);
			form.inputLoginPw.value = '';
			form.loginPwConfirm.value = '';
		}

		MemberJoin_submitFormDone = true;
		form.submit();
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

<div class="my-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" enctype="multipart/form-data"
			action="../member/doJoin" onsubmit="MemberJoin_submitForm(this); return false;">
			<input type="hidden" name="afterLoginUri" value="${ param.afterLoginUri }" />
			<!-- 암호화된 비밀번호 -->
			<input type="hidden" name="loginPw">

			<div class="text-3xl font-bold mb-2">회원가입</div>
			<div>
				<div class="ml-1 mt-2 font-medium text-slate-700">아이디</div>
				<input name="loginId" type="text" class="input input-lg input-bordered w-96" placeholder="로그인시 사용할 아이디입니다."
					onkeyup="checkLoginIdDupAsDebounce(this);" autocomplete="off" />
				<div class="message mt-1 ml-4">
					<div class="text-gray-400">아이디를 입력해주세요.</div>
				</div>
			</div>
			<div class="flex flex-col mt-3">
				<div class="ml-1 mt-2 font-medium text-slate-700">비밀번호</div>
				<input name="inputLoginPw" type="password" class="input input-lg input-bordered w-96"
					placeholder="로그인시 사용할 비밀번호입니다." />
				<div class="ml-1 mt-2 font-medium text-slate-700">비밀번호 재입력</div>
				<input name="loginPwConfirm" type="password" class="input input-lg input-bordered w-96"
					placeholder="비밀번호를 다시 입력해주세요." />
			</div>
			<div onkeyup="checkNicknameAndEmailDupAsDebounce(this);" class="flex flex-col mt-3">
				<div class="ml-1 mt-2 font-medium text-slate-700">닉네임</div>
				<input name="nickname" type="text" class="input input-lg input-bordered w-96" placeholder="레시피와 댓글에서 사용될 닉네임입니다."
					autocomplete="off" />
				<div class="ml-1 mt-2 font-medium text-slate-700">이메일</div>
				<input name="email" type="text" class="input input-lg input-bordered w-96" placeholder="예) abc@email.com"
					autocomplete="off" />
				<div class="message mt-1 ml-4">
					<div class="text-gray-400">닉네임과 이메일을 입력해주세요.</div>
				</div>
			</div>
			<div>
				<div class="ml-1 mt-2 font-medium text-slate-700">연락처</div>
				<input id="phoneNum" name="cellphoneNo" type="text" class="input input-lg input-bordered w-96" maxlength="13"
					required="required" placeholder="예) 01012341234" />
				<div class="mt-1 ml-4">하이픈(-)을 제외하고 입력해주세요.</div>
			</div>
			<div>
				<div class="ml-1 mt-2 font-medium text-slate-700">프로필 사진</div>

				<!-- 회원 프로필 미리보기 -->
				<div class="border border-gray-300 rounded-xl">
					<img class="object-contain w-80 h-80 rounded-xl mx-auto" id="preview-profile"
						src="https://dummyimage.com/300x300/ffffff/000000.png&text=preview+image" />
				</div>
				<div class="text-center mb-5">* 미리보기 사진입니다.*</div>

				<!-- 회원 프로필 등록 -->
				<div class="border border-gray-300 rounded-xl">
					<input type="file" id="input-profile" accept="image/gif, image/jpeg, image/png"
						oninput="readImage(this); return false;" name="file__member__0__extra__profileImg__1" class="p-3 w-96" />
				</div>
			</div>

			<div class="btns mt-2">
				<button type="button" class="btn btn-outilne" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn btn-primary btn-outline">회원가입</button>
			</div>
		</form>
	</div>
</div>

<%@include file="../common/foot.jspf"%>