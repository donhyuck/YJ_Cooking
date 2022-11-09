<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="" />
<%@include file="../common/head.jspf"%>

<form class="" action="/user/home/doUpload" method="POST" enctype="multipart/form-data">

	<div class="w-10/12 mx-auto">

		<div class="p-2">
			<!-- 사진등록 -->
			<input type="file" accept="image/gif, image/jpeg, image/png" name="file__etc__0__extra__defaultImg__1" class="w-full" />
		</div>

		<div class="btns flex justify-end space-x-5 mt-5">
			<button type="button" class="btn btn-lg btn-outline" onclick="history.back();">뒤로가기</button>
			<button type="submit" class="btn btn-lg btn-primary btn-outline">등록하기</button>
		</div>

		</section>
	</div>
</form>

<%@include file="../common/foot.jspf"%>