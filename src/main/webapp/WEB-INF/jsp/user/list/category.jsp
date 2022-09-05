<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 모아보기" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">

		<!-- TOP 버튼 -->
		<div class="fixed bottom-10 right-10 text-4xl text-center hover:text-yellow-400">
			<a href="#topTarget" class="scroll">
				<i class="fa-solid fa-circle-arrow-up"></i>
				<div class="text-xl font-black">TOP</div>
			</a>
		</div>
		
		<div class="flex flex-col space-y-6">
			<!-- 대분류 -->
			<c:forEach var="board" items="${ boards }">
				<section class="bg-white rounded-md p-8">
					<div class="text-3xl border-b border-gray-400 mb-4 p-3 mx-4">${ board.boardName }</div>
					<div class="flex grid grid-cols-5 text-center mx-20">

						<!-- 중분류 -->
						<c:forEach var="category" items="${ categories }">

							<!--소분류, 선택한 카테고리의 레시피 보기 -->
							<c:if test="${ category.boardId == board.id }">
								<a href="/user/list/choice?boardId=${ category.boardId }&relId=${category.relId}"
									class="flex justify-center items-center w-32 h-16 my-4 border border-gray-400 rounded-full mx-auto hover:bg-yellow-200">
									<div class="text-gray-600 text-xl">${ category.name }</div>
								</a>
							</c:if>
						</c:forEach>
					</div>
				</section>
			</c:forEach>
		</div>
	</div>
</div>

<%@include file="../common/foot.jspf"%>