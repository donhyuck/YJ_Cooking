<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 수정페이지" />
<%@include file="../common/head.jspf"%>
<%@ include file="../../common/toastUiEditorLib.jspf"%>
<script src="/recipe/WriteAndModify.js" defer="defer"></script>
<script src="/recipe/Modify.js" defer="defer"></script>

<form class="bg-gray-200 py-4" action="../recipe/doModify" method="POST" enctype="multipart/form-data"
	name="do-modify-recipe-form" onsubmit="RecipeModify_submitForm(this); return false;">

	<input type="hidden" name="id" value="${ recipe.id }" />
	<input type="hidden" name="replaceUri" value="${ param.replaceUri }" />

	<div class="modify-box w-10/12 mx-auto">
		<section class="bg-white rounded-md px-12 p-7 pb-12 mb-5">
			<div class="flex w-full">
				<!-- 레시피 대표사진 -->
				<div class="main-photo w-2/6">
					<!-- 현재 레시피 대표사진 -->
					<div class="bg-gray-100 rounded-xl">
						<div class="my-2 text-center text-md">완성된 요리사진을 등록해주세요.</div>
						<div class=" flex flex-col justify-center items-center bg-gray-100 border rounded-xl border-gray-300">
							<img class="object-contain w-80 h-80 rounded-md" src="${rq.getMainRecipeImgUri(recipe.id)}"
								onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" alt="" />
						</div>
					</div>

					<!-- 레시피 대표사진 변경 박스 -->
					<div class="toggleChangePhotoBox btn btn-sm btn-outline mt-3 w-full">대표 사진 변경</div>
					<div class="changePhoto rounded-xl mt-10 hidden">
						<!-- 회원 프로필 미리보기 -->
						<div class="rounded-xl border border-gray-300">
							<img class="object-contain w-80 h-80 rounded-xl mx-auto bg-gray-100 my-3" id="preview-mainRecipe"
								src="https://cdn.pixabay.com/photo/2018/05/21/12/37/restaurant-3418134_960_720.png" />
							<div class="text-center mb-1">* 미리보기 사진입니다.*</div>
						</div>

						<!-- 레시피 대표사진 변경 -->
						<div class="p-2 mt-3">
							<input type="file" id="input-mainRecipe" accept="image/gif, image/jpeg, image/png"
								oninput="readImage(this); return false;" name="file__recipe__0__extra__mainRecipeImg__1"
								class="w-full mainRecipeBox" />
						</div>
					</div>
				</div>

				<!-- 레시피 기본정보 입력 -->
				<div class="flex flex-col space-y-4 w-3/5 h-80 ml-10">
					<!-- 제목 -->
					<div>
						<div class="ml-1 mb-2 font-medium text-slate-700 text-2xl">레시피 제목</div>
						<input name="title" type="text" value="${ recipe.title }" class="input input-lg input-bordered w-full"
							placeholder="예) 돼지듬뿍 김치찌게" />
					</div>
					<!-- 내용 -->
					<div>
						<div class="ml-1 mb-2 font-medium text-slate-700 text-2xl">
							<div>레시피 소개</div>
							<div class="text-base text-gray-400">> "어떻게 만들게 되었나요?" "직접 먹어보니 어떠셨나요?" 자유롭게 소개해보세요</div>
						</div>
						<textarea rows="5" name="body" type="text" class="w-full text-lg p-5 border border-gray-300 rounded-lg"
							placeholder="예) 아빠표 특제 레시피를 소개합니다. 저녁 한끼로도 안주로도 딱이에요.&#13;&#10;밥솥으로 조리를 하여 푹 끓인 맛이 나요.">${ recipe.body }</textarea>
					</div>
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
								<option disabled selected value="${ recipe.amount }">선택</option>
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
								<option disabled selected value="${ recipe.time }">선택</option>
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
							<input name="amount" id="changeAmountInput" type="text" value="${ recipe.amount }" maxlength="3"
								autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								class="input input-lg input-bordered w-24 text-center font-bold" placeholder="입력" />
							<span class="text-xl">인분</span>
						</div>
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">
								<i class="fa-sharp fa-solid fa-pen-to-square text-yellow-400"></i>
								소요시간
							</div>
							<input name="time" id="changeTimeInput" type="text" value="${ recipe.time }" maxlength="3" autocomplete="off"
								oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								class="input input-lg input-bordered w-24 text-center font-bold" placeholder="입력" />
							<span class="text-xl">분이내</span>
						</div>
						<div>
							<div class="ml-2 font-medium text-slate-700 text-lg">난이도</div>
							<input id="changeLevelInput" type="text" class="input input-lg input-bordered w-32 text-center font-bold"
								placeholder="미선택" disabled value="${ levelName }" />
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
					placeholder="예시) 간장을 넣으실땐 달궈진 기름 위로 눌리도록 넣으면 향이 더 강해져요.&#13;&#10;양념을 넣을땐 소금보다 설탕을 먼저 넣어야 잘 스며들어요.">${ recipe.tip }</textarea>
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
					<div class="flex">
						<div class="flex flex-col space-y-5 w-full">
							<c:forEach var="row" items="${ rows }">
								<input name="row" type="text" value="${ row }" class="input input-lg input-bordered w-60 text-center"
									placeholder="재료 이름" />
							</c:forEach>
						</div>
						<div class="flex flex-col space-y-5 w-full text-center">
							<c:forEach var="rowValue" items="${ rowValues }">
								<input name="rowValue" type="text" value="${ rowValue }"
									class="input input-lg input-bordered w-48 text-center ml-3" placeholder="재료 수량" />
							</c:forEach>
						</div>
					</div>
					<div id="rowBox" class="mt-5"></div>
					<div type="button" onclick="add_rowBox()" class="btn btn-success btn-wide mt-5">추가</div>
				</div>
				<!-- 구분선 -->
				<div class="w-1 h-max mx-3 mt-12 -mb-2 rounded-lg opacity-50 bg-gray-200"></div>

				<div class="w-1/2">
					<div class="font-bold mb-5">[ 양념 ]</div>
					<div class="flex">
						<div class="flex flex-col space-y-5 w-full">
							<c:forEach var="sauce" items="${ sauces }">
								<input name="sauce" type="text" value="${ sauce }" class="input input-lg input-bordered w-60 text-center"
									placeholder="양념 이름" />
							</c:forEach>
						</div>
						<div class="flex flex-col space-y-5 w-full text-center">
							<c:forEach var="sauceValue" items="${ sauceValues }">
								<input name="sauceValue" type="text" value="${ sauceValue }"
									class="input input-lg input-bordered w-48 text-center ml-3 mr-0" placeholder="양념 수량" />
							</c:forEach>
						</div>
					</div>
					<div id="sauceBox" class="mt-5"></div>
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
					<span>레시피 분류 수정</span>
					<span class="text-lg font-light ml-2">(선택사항)</span>
				</div>
			</div>

			<!-- 레시피 분류 이름표시 영역 시작 -->
			<c:forEach var="category" items="${ categoriesAboutRecipe }">
				<c:if test="${ category.boardId == 1 }">
					<c:set var="oldSort" value="${ category }" />
				</c:if>
				<c:if test="${ category.boardId == 2 }">
					<c:set var="oldMethod" value="${ category }" />
				</c:if>
				<c:if test="${ category.boardId == 3 }">
					<c:set var="oldContent" value="${ category }" />
				</c:if>
				<c:if test="${ category.boardId == 4 }">
					<c:set var="oldFree" value="${ category }" />
				</c:if>
			</c:forEach>

			<div class="flex mb-7 ml-5 text-xl font-medium text-slate-700 text-center">
				<span class="mr-3">
					선택하신 분류
					<i class="fa-solid fa-hand-pointer"></i>
				</span>
				<c:forEach var="category" items="${ categoriesAboutRecipe }">
					<div class="mr-3">#${ category.name }</div>
				</c:forEach>
			</div>
			<!-- 레시피 분류 이름표시 영역 끝 -->

			<div class="flex justify-around">
				<div class="w-52">
					<div class="font-medium text-slate-700 text-2xl text-center mb-3">
						<span class="font-bold">종류</span>
					</div>
					<select name="sortId" class="select select-lg select-info select-bordered w-full max-w-xs">
						<option selected class="text-gray-400" value="${ oldSort.relId }">(${ oldSort.name })</option>
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
						<option selected class="text-gray-400" value="${ oldMethod.relId }">(${ oldMethod.name })</option>
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
						<option selected class="text-gray-400" value="${ oldContent.relId }">(${ oldContent.name })</option>
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
						<option selected class="text-gray-400" value="${ oldFree.relId }">(${ oldFree.name })</option>
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
				<!-- <div>
					<i class="fa-regular fa-circle-question"></i>
					<span>어울리는 키워드가 없다면? 자유 카테고리에서 입력해보세요.</span>
				</div> -->
			</div>
		</section>
		<!-- 레시피 분류 영역 끝 -->

		<!-- 조리순서 영역 시작 -->
		<section class="bg-white rounded-md p-12 mb-5">
			<div class="text-3xl font-bold">조리순서</div>

			<!-- 안내문구 박스 시작 -->
			<div class="indicator w-full px-8 mt-8">
				<div
					class="toggleRecipeOrderBox indicator-item indicator-top indicator-start bg-white ml-16 px-4 py-2 border rounded-xl hover:bg-yellow-400">
					<span class="text-xl">작성예시</span>
				</div>
				<div class="recipeOrder text-lg mt-10 text-gray-500">조리순서를 자유롭게 작성해주시고, 작성예시를 참고해보세요</div>
				<div class="recipeOrder w-full border border-yellow-500 rounded-xl py-7 hidden">
					<ul class="flex flex-col space-y-1 list-disc text-lg text-gray-500 mx-10 mb-5">
						<li>불조절, 시간 등 조리과정을 자세히 적어주세요.</li>
						<span>
							예 1) 10분간 익혀주세요 ▷ 10분간
							<span class="text-red-500">약한불</span>
							로 익혀주세요.
						</span>
						<span>
							예 2) 팬에 기름을 두르고 고기를 볶아주세요. ▷ 팬에
							<span class="text-red-500">미리 달군 뒤</span>
							기름을 두르고
							<span class="text-red-500">겉면이 갈색이 될때까지</span>
							고기를 볶아주세요.
						</span>
						<li>조리과정 중 대체 가능한 재료가 있다면 알려주세요,</li>
						<span>예) 꿀을 조금 넣어주세요 ▷ 꿀이 없는 경우, 설탕 1스푼으로 대체 가능합니다.</span>
					</ul>
					<div class="flex mx-10 mt-5 border-t-2 border-gray-300 pt-5">
						<div class="w-2/6 mr-5">
							<img class="rounded-md"
								src="https://recipe1.ezmember.co.kr/cache/recipe/2022/05/21/47b48d0be053ddc35afc03b87e98ac3b1.jpg" alt="" />
						</div>
						<div class="flex w-full p-5">
							<div class="w-10 h-10 bg-green-500 rounded-full">
								<div class="font-bold text-center text-white pt-2">1</div>
							</div>
							<div class="text-xl text-gray-600 ml-5 mt-1 w-5/6">
								<div>채소들을 썰어 준비해주세요.</div>
								<div>이때, 서로 비슷한 크기, 모양으로 썰어주셔야 골고루 볶아져요.</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 안내문구 박스 끝 -->

			<!-- 조리순서 수정 영역 시작 -->
			<div class="w-full mx-auto mt-5">
				<!-- 사진등록 -->
				<div class="flex items-center">
					<label class="flex justify-center items-center rounded-md w-80 h-12 bg-gray-200 hover:bg-yellow-100 ml-3 p-3"
						for="input-recipeOrder">
						<i class="fa-solid fa-plus text-2xl"></i>
						<span class="text-lg font-bold ml-2">사진등록</span>
					</label>

					<!-- 일정 스크롤 아래로 가면 나타나는 사진등록 버튼 -->
					<label for="input-recipeOrder"
						class="ScrollBtn absolute hidden flex justify-center items-center w-24 h-10 left-4 bottom-80 bg-black hover:bg-yellow-100 hover:text-black rounded-lg text-white">
						<i class="fa-solid fa-plus text-lg"></i>
						<span class="text-md font-bold ml-1">사진</span>
					</label>
					<div class="text-lg ml-6">사진등록버튼으로 조리순서 사진을 추가할 수 있어요.</div>

					<input type="file" id="input-recipeOrder" multiple="multiple" accept="image/gif, image/jpeg, image/png"
						oninput="readImage(this); return false;" name="file__order__0__extra__recipeOrderImg__1"
						class="hidden recipeOrderBox" />
				</div>

				<!-- 조리순서 내용작성 시작 -->
				<div class="ScrollMarkForOrderPhoto flex">
					<!-- 사진등록 미리보기 -->
					<div class="bg-gray-100 w-5/12 mt-5">
						<div id="multiple-container" class="w-full text-right"></div>
					</div>

					<div class="recipeOrder-textarea w-full">
						<div class="mt-8 ml-8">
							<div id="order">
								<div class="flex justify-center items-center w-full bg-gray-100 rounded-md p-4 mt-7">
									<textarea name="orderText" class="w-full h-full text-lg p-3 border border-gray-300 rounded-lg" rows="5"
										placeholder="조리순서를 입력해주세요."></textarea>
									<div class='w-16'></div>
								</div>
							</div>
							<div class="ml-5 mt-4 font-bold">
								<div onclick="add_orderBox();" class="flex justify-center items-center w-36 h-10 bg-yellow-200 rounded-lg">
									<span>추가</span>
								</div>
							</div>
						</div>
					</div>
					<!-- 조리순서 데이터 -->
					<input type="hidden" name="orderBody" />
				</div>
				<!-- 조리순서 수정 영역 끝 -->

				<!-- 기존 조리순서 데이터 -->
				<div class="flex flex-col space-y-5 w-full form-control mt-8">
					<c:forEach var="cookingOrder" varStatus="status" items="${ cookingOrderList }">
						<div class="text-lg flex items-center">
							<div class="w-10 h-10 bg-green-500 rounded-full">
								<div class="font-bold text-center text-white pt-2">${ status.count }</div>
							</div>
							<textarea name="orderText" class="w-5/6 text-lg p-3 ml-3 border border-gray-300 rounded-lg" rows="3">${ cookingOrder }</textarea>
						</div>
					</c:forEach>
				</div>

				<!-- 레시피 조작 영역 시작 -->
				<div class="btns flex justify-end space-x-5" id="downTarget">
					<button type="button" class="btn btn-lg btn-outline" onclick="history.back();">뒤로가기</button>
					<button type="submit" class="btn btn-lg btn-primary btn-outline">수정하기</button>
				</div>
				<!-- 레시피 조작 영역 끝 -->

				<!-- 스크롤 버튼 -->
				<div class="fixed right-12 bottom-52 text-4xl text-center hover:text-purple-500 hover:underline">
					<button type="submit">
						<i class="fa-solid fa-bookmark"></i>
						<div class="text-xl font-black">수정</div>
					</button>
				</div>
				<div class="fixed right-12 bottom-28 text-4xl text-center hover:text-red-500">
					<button type="button" onclick="history.back();">
						<i class="fa-solid fa-xmark"></i>
						<div class="text-xl font-black">취소</div>
					</button>
				</div>
				<div class="fixed right-20 bottom-6 text-4xl text-center hover:text-yellow-400">
					<a href="#topTarget" class="scroll">
						<i class="fa-solid fa-circle-arrow-up"></i>
						<div class="text-sm font-black">UP</div>
					</a>
				</div>
				<div class="fixed right-2 bottom-6 text-4xl text-center hover:text-yellow-400">
					<a href="#downTarget" class="scroll">
						<i class="fa-solid fa-circle-arrow-down"></i>
						<div class="text-sm font-black">DOWN</div>
					</a>
				</div>
		</section>
		<!-- 조리순서 영역 끝 -->
	</div>
</form>

<%@include file="../common/foot.jspf"%>