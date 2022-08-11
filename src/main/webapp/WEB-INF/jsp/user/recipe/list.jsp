<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피목록" />
<%@include file="../common/head.jspf"%>

<table border="1">
	<thead>
		<tr>
			<th>번호</th>
			<th>등록날짜</th>
			<th>수정날짜</th>
			<th>작성자</th>
			<th>제목</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="recipe" items="${ recipes }">
			<tr>
				<td>${ recipe.id }</td>
				<td>${ recipe.regDate.substring(2,16) }</td>
				<td>${ recipe.updateDate.substring(2,16) }</td>
				<td>${ recipe.extra__writerName  }</td>
				<td>
					<a href="../recipe/detail?id=${ recipe.id }">${ recipe.title }</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<%@include file="../common/foot.jspf"%>