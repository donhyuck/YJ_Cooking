<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="댓글 수정페이지" />
<%@include file="../common/head.jspf"%>

<form class="" action="../reply/doModify" method="POST">
	<input type="hidden" name="id" value="${ recipe.id }" />
	<table>
		<colgroup>
			<col width="200" />
		</colgroup>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${ reply.id }</td>
			</tr>
			<tr>
				<th>등록날짜</th>
				<td>${ reply.forPrintRegDate_Type2 }</td>
			</tr>
			<tr>
				<th>수정날짜</th>
				<td>${ reply.forPrintUpdateDate_Type2 }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${ reply.extra__writerName  }</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="body" class="textarea textarea-bordered w-full" rows="10" placeholder="댓글을 수정하세요.">${ reply.body }</textarea>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="btns mt-3">
		<button type="button" class="btn btn-outline btn-sm" onclick="history.back();">뒤로가기</button>
		<button type="submit" class="btn btn-outline btn-primary btn-sm">댓글수정</button>
	</div>
</form>

<%@include file="../common/foot.jspf"%>