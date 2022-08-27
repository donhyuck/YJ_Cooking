<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 목록페이지" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<c:forEach var="recipe" items="${ choicedRecipes }">
		<!-- 레시피 기본정보 영역 시작 -->
		<section class="bg-white rounded-md p-12 flex mb-5">

			<div class="flex flex-col w-2/5 h-80 m-auto">
				<!-- 제목, 내용 -->
				<div class="text-3xl">${ recipe.title }</div>
				<div class="text-xl text-gray-400 mt-5">${ recipe.body }</div>

			</div>
		</section>
		<!-- 레시피 기본정보 영역 끝 -->
	</c:forEach>
</div>

<%@include file="../common/foot.jspf"%>