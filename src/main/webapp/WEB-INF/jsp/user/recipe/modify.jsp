<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 수정페이지" />
<%@include file="../common/head.jspf"%>

<form class="" action="../recipe/doModify" method="POST">
	<input type="hidden" name="id" value="${ recipe.id }" />
	<table>
		<colgroup>
			<col width="200" />
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${ recipe.id }</td>
			</tr>
			<tr>
				<th>등록날짜</th>
				<td>${ recipe.forPrintRegDate_Type2 }</td>
			</tr>
			<tr>
				<th>수정날짜</th>
				<td>${ recipe.forPrintUpdateDate_Type2 }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${ recipe.extra__writerName  }</td>
			</tr>
			<tr>
				<th>요리제목</th>
				<td>
					<input type="text" name="title" value="${ recipe.title }" class="w-96 border" placeholder="수정할 제목을 입력하세요." />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="body" class="w-full textarea textarea-bordered" rows="10" placeholder="요리설명을 수정하세요.">${ recipe.body }</textarea>
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