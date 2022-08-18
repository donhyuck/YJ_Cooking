<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 수정페이지" />
<%@include file="../common/head.jspf"%>

<form class="" action="../recipe/doModify" method="POST">
	<input type="hidden" name="id" value="${ recipe.id }" />
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
				<td>
					<input type="text" name="title" value="${ recipe.title }" class="w-96 border" placeholder="수정할 제목을 입력하세요." />
				</td>
				<td>
					<textarea name="body" class="w-full textarea textarea-bordered" rows="10">${ recipe.body }</textarea>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="btns mt-3">
		<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
		<button type="submit" class="btn btn-primary">수정</button>
	</div>
</form>

<%@include file="../common/foot.jspf"%>