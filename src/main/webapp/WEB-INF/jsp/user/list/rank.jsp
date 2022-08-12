<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 랭킹" />
<%@include file="../common/head.jspf"%>

<div class="list-box w-10/12 h-full mx-auto bg-red-400">
	<section class="honor-list">
		<div>명예의 전당</div>
		<div>BEST10</div>
	</section>
	<section class="together-list">
		<div>함께 먹어요</div>
		<div>최근 많은 사람들이 스크랩 했어요</div>
	</section>
</div>

<%@include file="../common/foot.jspf"%>