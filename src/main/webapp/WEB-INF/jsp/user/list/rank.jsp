<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 랭킹" />
<%@include file="../common/head.jspf"%>

<div class="bg-gray-200 py-4">
	<div class="list-box w-10/12 mx-auto">
		<section class="today-list bg-white rounded-md p-4">
			<div class="mb-2">
				<div class="text-xl mb-1">명예의 전당</div>
				<div class="text-lg">BEST 10</div>
			</div>
			<div class="flex">
				<c:forEach begin="1" end="4" var="i">
					<div class="mx-3 relative">
						<div class="rank-number absolute top-0 w-10 h-10 bg-white border border-2 border-gray-400 rounded-lg">
							<span>${ i }</span>
						</div>
						<div class="p-1">
							<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
								alt="" />
							<div class="ml-3 mt-2">
								<div class="text-lg">이건 감자볶음</div>
								<div>홍길동</div>
								<span class="text-sm">
									<i class="fa-solid fa-heart text-red-500"></i>
									(12) 조회수 85
								</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
		<section class="recent-list bg-white rounded-md p-4 mt-4">
			<div class="mb-2">
				<div class="text-xl mb-1">함께 먹어요</div>
				<div class="text-lg">최근 많은 사람들이 스크랩 했어요</div>
			</div>
			<div class="flex">
				<c:forEach begin="1" end="4">
					<div class="mx-3">
						<img class="w-full rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0"
							alt="" />
						<div class="ml-3 mt-2">
							<div class="text-lg">이건 감자볶음</div>
							<div>홍길동</div>
							<span class="text-sm">
								<i class="fa-solid fa-heart text-red-500"></i>
								(12) 조회수 85
							</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
	</div>
</div>

<%@include file="../common/foot.jspf"%>