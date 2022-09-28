<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 등록페이지" />
<%@include file="../common/head.jspf"%>
<%@ include file="../../common/toastUiEditorLib.jspf"%>
<script src="/recipe/WriteAndModify.js" defer="defer"></script>

<!-- 입력데이터 검사 스크립트 시작 -->
<script>
	let RecipeWrite_submitFormDone = false;

	function RecipeWrite_submitForm(form) {
		if (RecipeWrite_submitFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('요리소개를 입력해주세요.');
			form.body.focus();
			return;
		}

		form.amount.value = form.amount.value.trim();
		if (form.amount.value.length == 0) {
			alert('인원을 선택 또는 입력해주세요.');
			form.amount.focus();
			return;
		}

		form.time.value = form.time.value.trim();
		if (form.time.value.length == 0) {
			alert('소요시간을 선택 또는 입력해주세요.');
			form.time.focus();
			return;
		}

		form.level.value = form.level.value.trim();
		if (form.level.value == 0) {
			alert('난이도를 선택해주세요.');
			form.level.focus();
			return;
		}

		// 재료양념 데이터 배열처리 스크립트 시작
		var rowArrCnt = 0;
		var rowValueArrCnt = 0;
		var sauceArrCnt = 0;
		var sauceValueArrCnt = 0;
		var rowArr = $('[name="row"]');
		var rowValueArr = $('[name="rowValue"]');
		var sauceArr = $('[name="sauce"]');
		var sauceValueArr = $('[name="sauceValue"]');

		// 재료 항목
		var param = [];
		for (var i = 0; i < rowArr.length; i++) {
			rowArr[i].value = rowArr[i].value.trim();
			param.push(rowArr[i].value);
		}

		var rowStr = '';
		param.map(function(item) {
			if (item != '' && item.length - 1) {
				rowStr += item + ',';
				rowArrCnt++;
			}
		});

		// 재료 값
		param = [];
		for (var i = 0; i < rowValueArr.length; i++) {
			rowValueArr[i].value = rowValueArr[i].value.trim();
			param.push(rowValueArr[i].value);
		}

		var rowValueStr = '';
		param.map(function(item) {
			if (item != '' && item.length - 1) {
				rowValueStr += item + ',';
				rowValueArrCnt++;
			}
		});

		// 양념 항목
		param = [];
		for (var i = 0; i < sauceArr.length; i++) {
			sauceArr[i].value = sauceArr[i].value.trim();
			param.push(sauceArr[i].value);
		}

		var sauceStr = '';
		param.map(function(item) {
			if (item != '' && item.length - 1) {
				sauceStr += item + ',';
				sauceArrCnt++;
			}
		});

		// 양념 값
		param = [];
		for (var i = 0; i < sauceValueArr.length; i++) {
			sauceValueArr[i].value = sauceValueArr[i].value.trim();
			param.push(sauceValueArr[i].value);
		}

		var sauceValueStr = '';
		param.map(function(item) {
			if (item != '' && item.length - 1) {
				sauceValueStr += item + ',';
				sauceValueArrCnt++;
			}
		});

		// 항목과 값 미입력 확인
		if (rowArrCnt != rowValueArrCnt) {
			alert('[재료]의 항목 또는 수량을 확인하시고, 빈칸을 채워주세요.');
			$("#rowBox").attr("tabindex", -1).focus();
			return;
		}

		if (sauceArrCnt != sauceValueArrCnt) {
			alert('[양념]의 항목 또는 수량을 확인하시고, 빈칸을 채워주세요.');
			$("#rowBox").attr("tabindex", -1).focus();
			return;
		}

		// 마지막 구분자(,)제거
		rowStr = rowStr.substr(0, rowStr.lastIndexOf(','));
		rowValueStr = rowValueStr.substr(0, rowValueStr.lastIndexOf(','));
		sauceStr = sauceStr.substr(0, sauceStr.lastIndexOf(','));
		sauceValueStr = sauceValueStr.substr(0, sauceValueStr.lastIndexOf(','));

		// 구성된 문자열을 input테그 값으로
		document['do-write-recipe-form'].rowArr.value = rowStr;
		document['do-write-recipe-form'].rowValueArr.value = rowValueStr;
		document['do-write-recipe-form'].sauceArr.value = sauceStr;
		document['do-write-recipe-form'].sauceValueArr.value = sauceValueStr;

		form.rowArr.value = form.rowArr.value.trim();
		form.rowValueArr.value = form.rowValueArr.value.trim();
		form.sauceArr.value = form.sauceArr.value.trim();
		form.sauceValueArr.value = form.sauceValueArr.value.trim();
		// 재료양념 데이터 배열처리 스크립트 끝

		if (form.rowArr.value == 0) {
			alert('최소 1개 이상의 재료는 입력해주세요.');
			$("#rowBox").attr("tabindex", -1).focus();
			return;
		}

		// 대표사진 용량 제한
		const maxSizeMb = 10;
		const maxSize = maxSizeMb * 1204 * 1204;

		const mainRecipeImgFileInput = form["file__recipe__0__extra__mainRecipeImg__1"];

		if (mainRecipeImgFileInput.value) {
			if (mainRecipeImgFileInput.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				mainRecipeImgFileInput.focus();

				return;
			}
		}

		RecipeWrite_submitFormDone = true;
		form.submit();
	}
</script>
<!-- 입력데이터 검사 스크립트 끝 -->

<form class="bg-gray-200 py-4" action="../recipe/doWrite" method="POST" enctype="multipart/form-data"
	name="do-write-recipe-form" onsubmit="RecipeWrite_submitForm(this); return false;">

	<div class="write-box w-10/12 mx-auto">
		<section class="bg-white rounded-md p-12 flex mb-5">

			<!-- 레시피 대표사진 -->
			<div class="main-photo w-2/6 flex flex-col justify-between bg-gray-100 rounded-xl">
				<div class="mt-2 text-center text-md">완성된 요리사진을 등록해주세요.</div>

				<!-- 레시피 대표사진 미리보기 -->
				<img class="object-contain mainRecipe max-h-80 rounded-md" id="preview-mainRecipe"
					src="https://cdn.pixabay.com/photo/2018/05/21/12/37/restaurant-3418134_960_720.png" />
				<!-- 레시피 대표사진 등록 -->
				<div class="p-2">
					<input type="file" id="input-mainRecipe" accept="image/gif, image/jpeg, image/png"
						oninput="readImage(this); return false;" name="file__recipe__0__extra__mainRecipeImg__1"
						class="hover:bg-gray-300 w-full mainRecipeBox" />
				</div>
			</div>

			<!-- 레시피 기본정보 입력 -->
			<div class="flex flex-col space-y-4 w-3/5 h-80 m-auto mb-8">
				<!-- 제목 -->
				<div>
					<div class="ml-1 mb-2 font-medium text-slate-700 text-2xl">레시피 제목</div>
					<input name="title" type="text" class="input input-lg input-bordered w-full" placeholder="예) 돼지듬뿍 김치찌게" />
				</div>
				<!-- 내용 -->
				<div>
					<div class="ml-1 mb-2 font-medium text-slate-700 text-2xl">
						<div>레시피 소개</div>
						<div class="text-base text-gray-400">> "어떻게 만들게 되었나요?" "직접 먹어보니 어떠셨나요?" 자유롭게 소개해보세요</div>
					</div>
					<textarea rows="5" name="body" type="text" class="w-full text-lg p-5 border border-gray-300 rounded-lg"
						placeholder="예) 아빠표 특제 레시피를 소개합니다. 저녁 한끼로도 안주로도 딱이에요.&#13;&#10;밥솥으로 조리를 하여 푹 끓인 맛이 나요."></textarea>
				</div>
			</div>
		</section>

		<!-- 요리정보 입력 영역 시작(인원, 소요시간, 난이도) -->
		<section class="bg-white rounded-md p-12 pt-8 mb-5">

			<div class="flex justify-between">
				<div class="select-box w-full">
					<!-- 안내문구 -->
					<div class="text-xl text-gray-600 mb-10">
						<i class="fa-regular fa-square-check text-green-400"></i>
						<span>
							아래의 선택란을 이용하여
							<span class="text-green-400">요리정보</span>
							를 입력할 수 있습니다.
						</span>
					</div>
					<!-- 선택영역 (인원, 소요시간, 난이도) 시작 -->
					<div class="flex justify-around">
						<div class="select-amount w-48">
							<div class="mr-2 font-medium text-slate-700 text-2xl text-center">
								<i class="fa-solid fa-user-check"></i>
								<span class="ml-1">인원</span>
							</div>
							<select onchange="changeAmountBox(this.value)" class="select select-lg select-accent w-full max-w-xs mt-4">
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
							<select onchange="changeTimeBox(this.value)" class="select select-lg select-accent w-full max-w-xs mt-4">
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
							<select name="level" onchange="changeLevelBox(this.value)"
								class="select select-lg select-accent w-full max-w-xs mt-4">
								<option disabled selected value="0">선택</option>
								<option class="text-xl" value="1">누구나</option>
								<option class="text-xl" value="2">초급</option>
								<option class="text-xl" value="3">중급</option>
								<option class="text-xl" value="4">고급</option>
							</select>
						</div>
					</div>
					<!-- 선택영역 (인원, 소요시간, 난이도) 끝 -->
					<!-- 안내문구 -->
					<ul class="list-disc text-lg flex flex-col space-y-5 mt-10 mx-20">
						<li>등록하신 요리재료를 기준으로 "인원"을 선택해주세요.</li>
						<li>재료손질부터 요리완성까지를 기준으로 "소요시간"을 선택해주세요.</li>
						<li>간단한 소개로서 자유롭게 "난이도"를 판단해보세요.</li>
						<li>
							원하는 선택지가 없다면 우측의
							<span class="text-yellow-400">
								<i class="fa-sharp fa-solid fa-pen-to-square"></i>
								<span>입력칸</span>
							</span>
							을 이용해보세요.
						</li>
					</ul>
				</div>

				<!-- 요리정보 안내영역 시작 -->
				<div class="info-box bg-gray-100 w-3/6 rounded-xl ml-4 p-3 pb-6">
					<!-- 안내문구 -->
					<div class="text-2xl text-center text-green-400 text-bold my-3">
						<div class="mb-1">
							<i class="fa-regular fa-square-check"></i>
							<span>요리정보</span>
						</div>
						<div class="text-sm">(숫자만 입력, 최대 세자리까지 가능)</div>
					</div>
					<div class="px-10 flex flex-col space-y-4">
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">
								<i class="fa-sharp fa-solid fa-pen-to-square text-yellow-400"></i>
								인원
							</div>
							<input name="amount" id="changeAmountInput" type="text" maxlength="3" autocomplete="off"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								class="input input-lg input-bordered w-24 text-center font-bold" placeholder="입력" />
							<span class="text-xl">인분</span>
						</div>
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">
								<i class="fa-sharp fa-solid fa-pen-to-square text-yellow-400"></i>
								소요시간
							</div>
							<input name="time" id="changeTimeInput" type="text" maxlength="3" autocomplete="off"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								class="input input-lg input-bordered w-24 text-center font-bold" placeholder="입력" />
							<span class="text-xl">분이내</span>
						</div>
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">난이도</div>
							<input id="changeLevelInput" type="text" class="input input-lg input-bordered w-32 text-center font-bold"
								placeholder="미선택" disabled value="" />
						</div>
					</div>
				</div>
				<!-- 요리정보 안내영역 끝 -->
			</div>

			<!-- 팁 / 주의사항 시작 -->
			<div class="flex flex-col w-full p-4 mt-10  border border-gray-200 rounded-lg text-lg">
				<div class="mb-2 font-bold text-red-600">
					<i class="fa-solid fa-lightbulb"></i>
					<span class="ml-1">팁 / 주의사항</span>
					<span class="text-black font-normal">- 알아두면 좋은 점들이나 주의사항을 남길 수 있어요. (선택사항)</span>
				</div>
				<textarea type="text" name="tip" class="p-3 mx-4 border border-gray-300 rounded-lg" rows="4"
					placeholder="예시) 간장을 넣으실땐 달궈진 기름 위로 눌리도록 넣으면 향이 더 강해져요.&#13;&#10;양념을 넣을땐 소금보다 설탕을 먼저 넣어야 잘 스며들어요."></textarea>
			</div>
			<!-- 팁 / 주의사항 끝 -->

		</section>
		<!-- 요리정보 입력 영역 끝(인원, 소요시간, 난이도) -->

		<!-- 재료, 양념 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold">재료 준비</div>

			<!-- 재료양념 데이터 문자열을 넘기기 -->
			<input type="hidden" name="rowArr" />
			<input type="hidden" name="rowValueArr" />
			<input type="hidden" name="sauceArr" />
			<input type="hidden" name="sauceValueArr" />

			<!-- 안내문구 -->
			<ul class="list-disc text-lg flex flex-col space-y-4 m-10">
				<li>부족해지거나 낭비를 막기 위해 계량정보를 입력해주세요.</li>
				<li>
					계량컵, 계량스푼 등 대신에 주방용품으로 확인할 수 있어요.
					<i class="fa-solid fa-right-long"></i>
					1T = 1숟가락, 1t = 1티스푼, 1종이컵 = 약180ml
				</li>
			</ul>

			<div class="flex justify-between text-2xl px-5">
				<div class="w-1/2">
					<div class="font-bold mb-5">[ 재료 ]</div>
					<div id="rowBox">
						<input name="row" type="text" class="input input-lg input-bordered w-60 text-center mb-5" placeholder="양파" />
						<input name="rowValue" type="text" class="input input-lg input-bordered w-48 text-center ml-10 mr-0 mb-5"
							placeholder="2개" />
						<input name="row" type="text" class="input input-lg input-bordered w-60 text-center mb-5" placeholder="돼지고기" />
						<input name="rowValue" type="text" class="input input-lg input-bordered w-48 text-center ml-10 mr-0 mb-5"
							placeholder="300g" />
					</div>
					<div type="button" onclick="add_rowBox()" class="btn btn-success btn-wide mt-5">추가</div>
				</div>
				<!-- 구분선 -->
				<div class="w-1 h-max mx-3 mt-12 -mb-2 rounded-lg opacity-50 bg-gray-200"></div>

				<div class="w-1/2">
					<div class="font-bold mb-5">[ 양념 ]</div>
					<div id="sauceBox">
						<input name="sauce" type="text" class="input input-lg input-bordered w-60 text-center mb-5" placeholder="간장" />
						<input name="sauceValue" type="text" class="input input-lg input-bordered w-48 text-center ml-10 mr-0 mb-5"
							placeholder="2T" />
						<input name="sauce" type="text" class="input input-lg input-bordered w-60 text-center mb-5" placeholder="고추장" />
						<input name="sauceValue" type="text" class="input input-lg input-bordered w-48 text-center ml-10 mr-0 mb-5"
							placeholder="3T" />
					</div>
					<div type="button" onclick="add_sauceBox()" class="btn btn-success btn-wide mt-5">추가</div>
				</div>
			</div>
		</section>
		<!-- 재료, 양념 영역 끝 -->

		<!-- 레시피 분류 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<!-- 안내문구 -->
			<div class="mb-7">
				<div class="text-3xl font-bold flex items-center">
					<i class="fa-regular fa-square-check text-blue-400 mr-2"></i>
					<span>레시피 분류 선택</span>
					<span class="text-lg font-light ml-2">(선택사항)</span>
				</div>
			</div>

			<div class="flex justify-around">
				<div class="w-52">
					<div class="font-medium text-slate-700 text-2xl text-center mb-3">
						<span class="font-bold">종류</span>
					</div>
					<select name="sortId" class="select select-lg select-info select-bordered w-full max-w-xs">
						<option disabled selected>(미선택)</option>
						<c:forEach var="category" items="${ categories }">
							<c:if test="${ category.boardId == 1 }">
								<option class="text-2xl" value="${ category.relId }">${ category.name }</option>
							</c:if>
						</c:forEach>
						<option class="text-xl text-red-600" value="0">(선택취소)</option>
					</select>
				</div>
				<div class="w-52">
					<div class="font-medium text-slate-700 text-2xl text-center mb-3">
						<span class="font-bold">방법</span>
					</div>
					<select name="methodId" class="select select-lg select-info select-bordered w-full max-w-xs">
						<option disabled selected>(미선택)</option>
						<c:forEach var="category" items="${ categories }">
							<c:if test="${ category.boardId == 2 }">
								<option class="text-2xl" value="${ category.relId }">${ category.name }</option>
							</c:if>
						</c:forEach>
						<option class="text-xl text-red-600" value="0">(선택취소)</option>
					</select>
				</div>
				<div class="w-52">
					<div class="font-medium text-slate-700 text-2xl text-center mb-3">
						<span class="font-bold">재료</span>
					</div>
					<select name="contentId" class="select select-lg select-info select-bordered w-full max-w-xs">
						<option disabled selected>(미선택)</option>
						<c:forEach var="category" items="${ categories }">
							<c:if test="${ category.boardId == 3 }">
								<option class="text-2xl" value="${ category.relId }">${ category.name }</option>
							</c:if>
						</c:forEach>
						<option class="text-xl text-red-600" value="0">(선택취소)</option>
					</select>
				</div>
				<div class="w-52">
					<div class="font-medium text-slate-700 text-2xl text-center mb-3">
						<span class="font-bold">상황</span>
					</div>
					<select name="freeId" class="select select-lg select-info select-bordered w-full max-w-xs">
						<option disabled selected>(미선택)</option>
						<c:forEach var="category" items="${ categories }">
							<c:if test="${ category.boardId == 4 }">
								<option class="text-2xl" value="${ category.name }">${ category.name }</option>
							</c:if>
						</c:forEach>
						<option class="text-xl text-red-600" value="0">(선택취소)</option>
					</select>
				</div>
			</div>

			<!-- 안내문구 -->
			<div class="text-lg text-gray-600 mt-7">
				<ul class="list-disc text-lg mx-10">
					<li>선택하신 키워드를 통해 다른 분들이 쉽게 레시피를 검색할 수 있어요.</li>
					<li>분류 선택을 윈하지 않는 항목은 (미선택)으로 그대로 넘어가시면 됩니다.</li>
					<li>
						이미 키워드 선택을 했다면
						<span class="text-red-600">(선택취소)</span>
						를 해주세요.
					</li>
				</ul>
			</div>
		</section>
		<!-- 레시피 분류 영역 끝 -->

		<!-- 조리순서 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold mb-8">조리순서</div>

			<!-- 토스트 에디터 적용 -->
			<div class="toast-ui-editor">
				<script type="text/x-template"></script>
			</div>

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

			<!-- 레시피 조작 영역 시작 -->
			<div class="btns flex justify-end space-x-5" id="downTarget">
				<button type="button" class="btn btn-lg btn-outline" onclick="history.back();">뒤로가기</button>
				<button type="submit" class="btn btn-lg btn-primary btn-outline">등록하기</button>
			</div>
			<!-- 레시피 조작 영역 끝 -->

			<!-- 스크롤 버튼 -->
			<div class="fixed right-10 bottom-28 text-4xl text-center hover:text-yellow-400">
				<a href="#topTarget" class="scroll">
					<i class="fa-solid fa-circle-arrow-up"></i>
					<div class="text-xl font-black">TOP</div>
				</a>
			</div>
			<div class="fixed right-7 bottom-6 text-4xl text-center hover:text-yellow-400">
				<a href="#downTarget" class="scroll">
					<i class="fa-solid fa-circle-arrow-down"></i>
					<div class="text-xl font-black">DOWN</div>
				</a>
			</div>
		</section>
		<!-- 조리순서 영역 끝 -->
	</div>
</form>

<%@include file="../common/foot.jspf"%>