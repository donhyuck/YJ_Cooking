<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="추천레시피" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 pt-5 absolute inset-0 top-44">
	<div class="list-box w-10/12 mx-auto">
		<section class="today-list bg-white rounded-md p-4">
			<div>
				<div class="text-xl mb-1">오늘 뭐 먹지?</div>
				<div class="text-lg">끼니 고민 덜어드려요</div>
			</div>
		</section>
		<section class="recent-list bg-white rounded-md p-4 mt-4">
			<div>
				<div class="text-xl mb-1">최근 본 레시피</div>
			</div>
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>