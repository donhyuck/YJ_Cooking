<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 등록페이지" />
<%@include file="../common/head.jspf"%>

<form class="" action="../recipe/doWrite" method="POST">
	<table>
		<colgroup>
			<col width="200" />
		</colgroup>
		<tbody>
			<tr>
				<th>작성자</th>
				<td>${ rq.loginedMember.nickname }</td>
			</tr>
			<tr>
				<th>요리제목</th>
				<td>
					<input type="text" name="title" class="input input-bordered w-96 border p-2" placeholder="제목을 입력하세요." />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="body" class="textarea textarea-bordered w-full" rows="10" placeholder="요리 설명을 입력하세요."></textarea>
				</td>
			</tr>
		</tbody>
	</table>

	<div class="btns mt-3">
		<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
		<button type="submit" class="btn btn-primary">등록</button>
	</div>
</form>

<%@include file="../common/foot.jspf"%>