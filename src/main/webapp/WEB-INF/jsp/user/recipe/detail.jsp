<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세페이지" />
<%@include file="../common/head.jspf"%>

<table border="1">
	<thead>
		<tr>
			<th>번호</th>
			<th>등록날짜</th>
			<th>수정날짜</th>
			<th>작성자</th>
			<th>제목</th>
			<th>내용</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>${ recipe.id }</td>
			<td>${ recipe.regDate }</td>
			<td>${ recipe.updateDate }</td>
			<td>${ recipe.extra__writerName  }</td>
			<td>${ recipe.title }</td>
			<td>${ recipe.body }</td>
		</tr>
	</tbody>
</table>

<!-- 레시피 조작 영역 시작 -->
<div class="btns mt-3">
	<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
	<c:if test="${ recipe.extra__actorCanModify }">
		<a class="btn btn-primary" href="../recipe/modify?id=${recipe.id}">수정</a>
	</c:if>
	<c:if test="${ recipe.extra__actorCanDelete }">
		<a class="btn btn-secondary" href="../recipe/doDelete?id=${ recipe.id }"
			onclick="if ( confirm('정말 삭제하시겠습니까?') == false) return false;">삭제</a>
	</c:if>
</div>
<!-- 레시피 조작 영역 끝 -->

<%@include file="../common/foot.jspf"%>