<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피노트" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 pt-5 absolute inset-0 top-44">
	<div class="list-box w-10/12 mx-auto">
		<section class="write-list bg-white rounded-md p-4">
			<div>
				<div class="text-xl mb-1">내가 등록한 레시피</div>
			</div>
		</section>
		<section class="scrap-list bg-white rounded-md p-4 mt-4">
			<div>
				<div class="text-xl mb-1">스크랩한 레시피</div>
			</div>
		</section>
	</div>
</div>


<%@include file="../common/foot.jspf"%>