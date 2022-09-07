<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 등록페이지" />
<%@include file="../common/head.jspf"%>

<!-- 요리정보 입력 스크립트 시작 -->
<script>
	var changeAmountBox = function(value) {
		$("#changeAmountInput").val(value + "인분");
	}
	var changeTimeBox = function(value) {
		$("#changeTimeInput").val(value + "분이내");
	}
	var changeLevelBox = function(value) {

		if (value == "1") {
			value = "누구나";
		} else if (value == "2") {
			value = "초급";
		} else if (value == "3") {
			value = "중급";
		} else if (value == "4") {
			value = "고급";
		}

		$("#changeLevelInput").val(value);
	}
</script>
<!-- 요리정보 입력 스크립트 끝 -->

<form class="" action="../recipe/doWrite" method="POST">

	<div class="bg-gray-200 py-4">
		<div class="write-box w-10/12 mx-auto">

			<section class="bg-white rounded-md p-12 flex mb-5">
				<!-- 대표사진 등록 -->
				<a href="#"
					class="main-photo w-2/6 flex flex-col justify-center items-center rounded-xl bg-gray-100 hover:bg-gray-300">
					<div class="rounded-md text-8xl">
						<i class="fa-solid fa-camera-retro"></i>
					</div>
					<div class="mt-3 text-md">완성된 요리사진이나 레시피 대표사진을 등록해주세요.</div>
				</a>

				<!-- 레시피 기본정보 입력 -->
				<div class="flex flex-col space-y-4 w-3/5 h-80 m-auto mb-8">
					<!-- 제목 -->
					<div>
						<div class="ml-1 mb-2 font-medium text-slate-700 text-lg">레시피 제목</div>
						<input name="title" type="text" class="input input-lg input-bordered w-full" placeholder="예) 돼지듬뿍 김치찌게" />
					</div>
					<!-- 내용 -->
					<div>
						<div class="ml-1 mb-2 font-medium text-slate-700 text-lg">
							<div>레시피 소개</div>
							<div class="text-base text-gray-400">"어떻게 만들게 되었나요?" "직접 먹어보니 어떠셨나요?" 자유롭게 적어보세요</div>
						</div>
						<textarea rows="5" name="title" type="text" class="w-full text-lg p-5 border border-gray-300 rounded-lg"
							placeholder="예) 아빠표 특제 레시피를 소개합니다. 저녁 한끼로도 안주로도 딱이에요.&#13;&#10;밥솥으로 조리를 하여 푹 끓인 맛이 나요."></textarea>
					</div>
				</div>
			</section>

			<!-- 요리정보 입력 영역 시작(인원, 소요시간, 난이도) -->
			<section class="bg-white rounded-md p-12 pt-8 mb-5 flex justify-between">

				<div class="select-box w-full">
					<!-- 안내문구 -->
					<div class="text-xl text-gray-600 mb-10">
						<i class="fa-regular fa-square-check text-green-400"></i>
						<span>선택란을 클릭하여 요리정보를 입력할 수 있습니다.</span>
					</div>
					<!-- 선택영역 시작 -->
					<div class="flex justify-around">
						<div class="select-amount w-48">
							<div class="mr-2 font-medium text-slate-700 text-2xl text-center">
								<i class="fa-solid fa-user-check"></i>
								<span class="ml-1">인원</span>
							</div>
							<select name="amount" id="changeAmount" onchange="changeAmountBox(this.value)"
								class="select select-lg select-accent w-full max-w-xs mt-4">
								<option disabled selected>선택</option>
								<option class="text-xl" value="1">1인분</option>
								<option class="text-xl" value="2">2인분</option>
								<option class="text-xl" value="3">3인분</option>
								<option class="text-xl" value="4">4인분</option>
								<option class="text-xl" value="5">5인분</option>
								<option class="text-xl" value="6">6인분 이상</option>
							</select>
						</div>

						<div class="select-time w-48">
							<div class="mr-2 font-medium text-slate-700 text-2xl text-center">
								<i class="fa-solid fa-clock"></i>
								<span class="ml-1">소요시간</span>
							</div>
							<select name="time" id="changeTime" onchange="changeTimeBox(this.value)"
								class="select select-lg select-accent w-full max-w-xs mt-4">
								<option disabled selected>선택</option>
								<option class="text-xl" value="5">5분이내</option>
								<option class="text-xl" value="10">10분이내</option>
								<option class="text-xl" value="30">30분이내</option>
								<option class="text-xl" value="60">1시간이내</option>
								<option class="text-xl" value="120">2시간이내</option>
								<option class="text-xl" value="180">3시간이내</option>
							</select>
						</div>

						<div class="select-level w-48">
							<div class="mr-2 font-medium text-slate-700 text-2xl text-center">
								<i class="fa-solid fa-star"></i>
								<span class="ml-1">난이도</span>
							</div>
							<select name="level" id="changeLevel" onchange="changeLevelBox(this.value)"
								class="select select-lg select-accent w-full max-w-xs mt-4">
								<option disabled selected>선택</option>
								<option class="text-xl" value="1">누구나</option>
								<option class="text-xl" value="2">초급</option>
								<option class="text-xl" value="3">중급</option>
								<option class="text-xl" value="4">고급</option>
							</select>
						</div>
					</div>
					<!-- 선택영역 끝 -->
					<!-- 안내문구 -->
					<ul class="list-disc text-lg leading-loose mt-10 mx-20">
						<!-- 우측 요리정보 입력란에서 직접 입력가능 -->
						<li>등록하신 요리재료를 기준으로 "인원"을 선택해주세요.</li>
						<li>재료손질부터 요리완성까지를 기준으로 "소요시간"을 선택해주세요.</li>
						<li>
							당신은 당신의 요리가 어떤가요?
							<br />
							자유롭게 "난이도"를 판단해보세요.
						</li>
					</ul>
				</div>

				<!-- 요리정보 안내영역 시작 -->
				<div class="info-box bg-gray-100 w-3/6 rounded-xl ml-4 p-3 pb-6">
					<!-- 안내문구 -->
					<div class="text-2xl text-center text-green-400 text-bold my-3">
						<i class="fa-regular fa-square-check"></i>
						요리정보
					</div>
					<div class="px-10 flex flex-col space-y-4">
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">인원</div>
							<input name="amount" id="changeAmountInput" type="text" class="input input-lg input-bordered w-full" value="" />
						</div>
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">소요시간</div>
							<input name="time" id="changeTimeInput" type="text" class="input input-lg input-bordered w-full" value="" />
						</div>
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">난이도</div>
							<input name="level" id="changeLevelInput" type="text" class="input input-lg input-bordered w-full" value="" />
						</div>
					</div>
				</div>
				<!-- 요리정보 안내영역 끝 -->

			</section>
			<!-- 요리정보 입력 영역 끝(인원, 소요시간, 난이도) -->

			<!-- 팁 / 주의사항 시작 -->
			<section class="bg-white rounded-md p-12 flex mb-5">
				<div class="text-lg w-full p-4 border border-gray-200 rounded-lg flex flex-col">
					<div class="mb-2 font-bold text-red-600">
						<i class="fa-solid fa-lightbulb"></i>
						<span class="ml-1">팁 / 주의사항</span>
						<div class="text-black font-normal">* 알아두면 좋은 점들이나 주의사항을 남길 수 있어요.</div>
					</div>
					<textarea type="text" name="tip" class="p-3 mx-4 border border-gray-300 rounded-lg" rows="3"
						placeholder="예시) 간장을 넣으실땐 기름에 눌리도록 넣으면 향이 더 강해져요.&#13;&#10;양념을 넣을땐 소금보다 설탕을 먼저 넣어야 잘 스며들어요."></textarea>
				</div>
			</section>
			<!-- 팁 / 주의사항 끝 -->

			<!-- 재료, 양념 영역 시작 -->
			<section class="bg-white rounded-md p-12 mb-5">
				<div class="text-3xl font-bold mb-8">재료 준비</div>
				<div class="flex justify-between space-x-5 text-2xl px-5">
					<div class="w-1/2">
						<div class="font-bold mb-5">[ 재료 ]</div>
						<c:forEach begin="1" end="8" step="1">
							<div class="grid grid-cols-2 mb-2 ml-4 px-3 border-b-2 border-dashed border-gray-300">
								<div class="">버섯</div>
								<div class="text-center">1개</div>
							</div>
						</c:forEach>
					</div>
					<div class="w-1/2">
						<div class="font-bold mb-5">[ 양념 ]</div>
						<c:forEach begin="1" end="5" step="1">
							<div class="grid grid-cols-2 mb-2 ml-4 px-3 border-b-2 border-dashed border-gray-300">
								<div class="">간장</div>
								<div class="text-center">1숟가락</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
			<!-- 재료, 양념 영역 끝 -->

			<!-- 조리순서 영역 시작 -->
			<section class="bg-white rounded-md p-12 mb-5">
				<div class="text-3xl font-bold mb-8">조리순서</div>
				<div class="w-full flex flex-col space-y-8 px-5">
					<c:forEach var="i" begin="1" end="4" step="1">
						<div class="flex">
							<div class="w-1/2 mr-5">
								<img class="rounded-md" src="https://tse4.mm.bing.net/th?id=OIP.kwt4oKZDd-goVuBezaVQRQHaE7&pid=Api&P=0" alt="" />
							</div>
							<div class="w-5/6 p-5 flex">
								<div class="w-10 h-10 bg-green-500 rounded-full">
									<div class="font-bold text-center text-white pt-2">${ i }</div>
								</div>
								<div class="text-2xl text-gray-600 ml-5 mt-1 w-5/6">양파를 썬다. 일정하게 1cm간격이 되도록 썬다.</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>
			<!-- 조리순서 영역 시작 -->

			<!-- 레시피 조작 영역 시작 -->
			<div class="btns text-center">
				<button type="button" class="btn btn-outline" onclick="history.back();">뒤로가기</button>
				<button type="button" class="btn btn-primary btn-outline">등록</button>
			</div>
			<!-- 레시피 조작 영역 끝 -->
		</div>
	</div>

</form>

<%@include file="../common/foot.jspf"%>