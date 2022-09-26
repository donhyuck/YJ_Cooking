<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원정보 수정" />
<%@include file="../common/head.jspf"%>
<script src="/member/join.js" defer="defer"></script>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let MemberModify_submitFormDone = false;

	function MemberModify_submitForm(form) {
		if (MemberModify_submitFormDone) {
			alert('처리중입니다.');
			return;
		}

		// 비밀번호 변경을 위해 입력한 경우
		form.newLoginPw.value = form.newLoginPw.value.trim();
		if (form.newLoginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호확인을 입력해주세요.');
				form.loginPwConfirm.focus();
				return;
			}
			if (form.newLoginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호확인이 일치하지 않습니다.');
				form.loginPwConfirm.focus();
				return;
			}

			// 신규 비밀번호 암호화
			form.loginPw.value = sha256(form.newLoginPw.value);
			form.newLoginPw.value = '';
			form.loginPwConfirm.value = '';
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
		
		if( profileImgFileInput.value ) {
			if ( profileImgFileInput.files[0].size > maxSize ) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				profileImgFileInput.focus();
				
				return;
			}
		}

		MemberModify_submitFormDone = true;
		form.submit();
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

<div class="mt-6">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-4 items-center" method="POST" enctype="multipart/form-data"
			action="../member/doModify" onsubmit="MemberModify_submitForm(this); return false;">
			<!-- 로그인한 회원의 정보 -->
			<c:set var="member" value="${ rq.loginedMember }" />
			<!-- 비밀번호 확인 인증코드 -->
			<input type="hidden" name="memberModifyAuthKey" value="${ param.memberModifyAuthKey }">
			<!-- 암호화된 신규 비밀번호 -->
			<input type="hidden" name="loginPw">

			<div class="text-3xl font-bold mb-2">회원정보 수정</div>

			<!-- 아이디 (고정) -->
			<div>
				<label class="input-group">
					<span class="text-2xl">
						<i class="fa-solid fa-user"></i>
					</span>
					<input type="text" value="${ member.loginId }" class="input input-lg input-bordered w-96 max-w-xs"
						disabled="disabled" />
				</label>
			</div>
			<div>
				<div class="text-slate-700 p-2">신규 비밀번호</div>
				<input name="newLoginPw" type="password" class="input input-lg input-bordered w-96 member-inputType"
					placeholder="비밀번호" />
			</div>
			<div>
				<div class="text-slate-700 p-2">비밀번호 확인</div>
				<input name="loginPwConfirm" type="password" class="input input-lg input-bordered w-96 member-inputType"
					placeholder="비밀번호 확인" />
			</div>

			<div class="flex flex-col mt-3">
				<div class="ml-1 mt-2 font-medium text-slate-700">닉네임</div>
				<input name="nickname" type="text" value="${ member.nickname }" class="input input-lg input-bordered w-96"
					placeholder="레시피와 댓글에서 사용될 닉네임입니다." autocomplete="off" />
				<div class="ml-1 mt-2 font-medium text-slate-700">이메일</div>
				<input name="email" type="text" value="${ member.email }" class="input input-lg input-bordered w-96"
					placeholder="예) abc@email.com" autocomplete="off" />
				<div class="message mt-1 ml-4">
					<div class="text-gray-400">닉네임과 이메일을 입력해주세요.</div>
				</div>
			</div>

			<div>
				<div class="ml-1 mt-2 font-medium text-slate-700">연락처</div>
				<input id="phoneNum" name="cellphoneNo" type="text" value="${ member.cellphoneNo }"
					class="input input-lg input-bordered w-96" maxlength="13" required="required" placeholder="예) 01012341234" />
				<div class="mt-1 ml-4">하이픈(-)을 제외하고 입력해주세요.</div>
			</div>

			<div class="btns mt-2">
				<button type="button" class="btn btn-outilne" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn btn-primary btn-outline">정보수정</button>
			</div>
		</form>

	</div>
</div>

<%@include file="../common/foot.jspf"%>