<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="추천레시피" />
<%@include file="../common/head.jspf"%>

<div class="list-box w-10/12 h-full bg-red-400 mx-auto">
	<section class="today-list">
		<div>오늘 뭐 먹지?</div>
		<div>끼니 고민 덜어드려요</div>
	</section>
	<section class="recent-list">
		<div>최근 본 레시피</div>
	</section>
</div>

<%@include file="../common/foot.jspf"%>