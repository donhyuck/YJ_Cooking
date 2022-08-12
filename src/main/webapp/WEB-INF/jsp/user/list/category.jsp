<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 모아보기" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 pt-5 absolute inset-0 top-44">
	<div class="list-box w-10/12 mx-auto">
		<section class="cookMethod-list bg-white rounded-md p-4">
			<div>
				<div class="text-xl mb-1">조리방법</div>
			</div>
		</section>
		<section class="sort-list bg-white rounded-md p-4 mt-4">
			<div>
				<div class="text-xl mb-1">종류별</div>
			</div>
		</section>
		<section class="food-list bg-white rounded-md p-4 mt-4">
			<div>
				<div class="text-xl mb-1">재료별</div>
			</div>
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>