<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 모아보기" />
<%@include file="../common/head.jspf"%>

<div class="list-box w-10/12 h-full mx-auto bg-red-400">
	<section class="cookMethod-list">
		<div>조리방법</div>
	</section>
	<section class="sort-list">
		<div>종류별</div>
	</section>
	<section class="food-list">
		<div>재료별</div>
	</section>
</div>

<%@include file="../common/foot.jspf"%>