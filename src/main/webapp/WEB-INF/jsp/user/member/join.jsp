<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원가입" />
<%@include file="../common/head.jspf"%>

<div class="mt-4">
	<div class="member-box w-2/5 mx-auto">
		<form class="flex flex-col space-y-3 items-center" method="POST" action="../member/doJoin">
			<div>
				<input name="loginId" type="text" class="member-inputType" placeholder=" 아이디" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="loginPw" type="password" class="member-inputType" placeholder=" 비밀번호" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="name" type="text" class="member-inputType" placeholder=" 닉네임" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="cellphoneNo" type="text" class="member-inputType"
					placeholder=" 연락처 예) 하이픈(-) 제외" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>
			<div>
				<input name="email" type="email" class="member-inputType" placeholder=" 이메일" />
				<div class="member-msgType text-green-400 mt-1 ml-4">사용가능합니다.</div>
			</div>

			<div class="btns mt-3">
				<button type="button" class="btn" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn">회원가입</button>
			</div>
		</form>

	</div>
</div>

<%@include file="../common/foot.jspf"%>