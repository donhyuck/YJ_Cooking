<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피노트" />
<%@include file="../common/head.jspf"%>

<div class="list-box w-10/12 h-full bg-red-400 mx-auto">
	<section class="write-list">
		<div>내가 등록한 레시피</div>
	</section>
	<section class="scrap-list">
		<div>스크랩한 레시피</div>
	</section>
</div>

<%@include file="../common/foot.jspf"%>