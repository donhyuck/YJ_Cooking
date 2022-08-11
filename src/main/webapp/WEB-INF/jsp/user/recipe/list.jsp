<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 목록</title>
<link rel="stylesheet" href="/resource/common.css">
<script src="resource/common.js" defer="defer"></script>
</head>
<body>
	<h1>레시피 목록</h1>
	<header>
		<a href="/">요리조리</a>

		<ul>
			<li>
				<a href="/">홈</a>
			</li>
			<li>
				<a href="/user/recipe/list">목록</a>
			</li>
		</ul>
	</header>
	<hr />
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
					<td>${ recipe.regDate }</td>
					<td>${ recipe.updateDate }</td>
					<td>${ recipe.memberId }</td>
					<td>
						<a href="../recipe/detail?id=${ recipe.id }">${ recipe.title }</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>