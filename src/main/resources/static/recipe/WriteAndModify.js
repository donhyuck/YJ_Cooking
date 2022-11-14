// 요리정보 입력 스크립트 시작

var changeAmountBox = function(value) {

	$("#changeAmountInput").val(value);
}
var changeTimeBox = function(value) {

	$("#changeTimeInput").val(value);
}
var changeLevelBox = function(value) {

	let valueName = "미선택";

	if (value == "1") {
		valueName = "누구나";
	} else if (value == "2") {
		valueName = "초급";
	} else if (value == "3") {
		valueName = "중급";
	} else if (value == "4") {
		valueName = "고급";
	}

	$("#changeLevelInput").val(valueName);
}
// 요리정보 입력 스크립트 끝

// 재료양념 입력칸 추가/삭제 스크립트 시작
const add_rowBox = () => {
	const rowBox = document.getElementById("rowBox");
	const newRowP = document.createElement('p');
	newRowP.innerHTML = "<input name='row' type='text' class='input input-lg input-bordered w-60 text-center mb-5' placeholder='당근'/>"
		+ "<input name='rowValue' type='text' class='input input-lg input-bordered w-48 text-center ml-12 mr-0 mb-5' placeholder='1/2개'/>"
		+ "<div type='button' onclick='removeRow(this);' class='btn btn-circle ml-3 hover:text-red-400'>삭제</div>";
	rowBox.appendChild(newRowP);
}

const removeRow = (obj) => {
	document.getElementById('rowBox').removeChild(obj.parentNode);
}

const add_sauceBox = () => {
	const sauceBox = document.getElementById("sauceBox");
	const newSauceP = document.createElement('p');
	newSauceP.innerHTML = "<input name='sauce' type='text' class='input input-lg input-bordered w-60 text-center mb-5' placeholder='소금'/>"
		+ "<input name='sauceValue' type='text' class='input input-lg input-bordered w-48 text-center ml-12 mr-0 mb-5' placeholder='1t'/>"
		+ "<div type='button' onclick='removeSauce(this);' class='btn btn-circle ml-3 hover:text-red-400'>삭제</div>";
	sauceBox.appendChild(newSauceP);
}

const removeSauce = (obj) => {
	document.getElementById('sauceBox').removeChild(obj.parentNode);
}
// 재료양념 입력칸 추가/삭제 스크립트 끝

// 조리순서 내용작성 박스 추가/삭제 스크립트 시작
var orderNum = 1;
var lastOrderNum = 1;

const add_orderBox = () => {
	// 수정페이지에서 마지막 번호 가져오기
	if (document.getElementById("lastOrderNum")) {
		lastOrderNum = document.getElementById("lastOrderNum").value;
		// 처음 한번만 orderNum를 lastOrderNum로 설정하기
		if (lastOrderNum > orderNum) {
			orderNum = lastOrderNum;
		}
	}
	
	++orderNum;
	const orderBox = document.getElementById("order");
	const newOrderP = document.createElement('p');

	newOrderP.innerHTML = "<div class='flex mt-5'><div class='flex w-6/12 h-full bg-gray-100 rounded-lg p-3'>"
		+ "<div class='flex justify-center items-center w-16 h-10 hover:bg-white rounded-xl my-auto mr-2'>"
		+ "<label for='input-recipeOrder__" + orderNum + "'><i class='fa-solid fa-camera text-3xl text-yellow-500'></i></label>"
		+ "<input type='file' id='input-recipeOrder__" + orderNum + "' accept='image/gif, image/jpeg, image/png'"
		+ "name='file__order__0__extra__recipeOrderImg__" + orderNum + "' class='hidden recipeOrderBox'/></div>"
		+ "<img class='object-contain w-full max-h-56 rounded-md' id='preview-recipeOrder__" + orderNum + "' src='https://via.placeholder.com/600/FFFFFF?text=...' /></div>"
		+ "<div class='recipeOrder-textarea w-full ml-6 my-auto'>"
		+ "<div class='flex justify-center items-center w-full bg-gray-100 rounded-md p-4 py-6'>"
		+ "<textarea name='orderText' class='w-full h-full text-lg p-3 border border-gray-300 rounded-lg' rows='5' "
		+ "onkeyup='characterCheck(this);' onkeydown='characterCheck(this);' required placeholder='조리순서를 입력해주세요.'></textarea>"
		+ "<div onclick='remove_orderBox(this);' class='btn btn-circle ml-3 hover:text-red-400'>"
		+ "<span>삭제</span></div></div></div></div></div>";

	orderBox.appendChild(newOrderP);
};

const remove_orderBox = (obj) => {
	document.getElementById("order").removeChild(obj.parentNode.parentNode.parentNode.parentNode);
}

// 특수문자 입력 방지 스크립트
function characterCheck(obj) {
	// 방지할 특수문자 구분자로 사용되는 문자 '@' 제외
	var regExp = /@/gi;
	if (regExp.test(obj.value)) {
		alert("해당 특수문자는 입력하실수 없습니다.");
		obj.value = obj.value.substring(0, obj.value.length - 1); // 입력한 특수문자 한자리 지움
	};
};
// 조리순서 내용작성 박스 추가/삭제 스크립트 끝

$(document).ready(function() {

	// 페이지 시작시 스크롤 상단에 위치
	$(function() {
		window.scrollTo({
			top: 0,
			left: 0,
			behavior: 'auto'
		});
	});

	// 대표사진 미리보기 스크립트 시작
	function readMainRecipeImage(input) {
		// 인풋 태그에 파일이 있는 경우
		if (input.files && input.files[0]) {

			// FileReader 인스턴스 생성
			const reader = new FileReader();
			// 이미지가 로드가 된 경우
			reader.onload = e => {
				const previewImage = document.getElementById("preview-mainRecipe");
				previewImage.src = e.target.result;
			}
			// reader가 이미지 읽도록 하기
			reader.readAsDataURL(input.files[0]);
		}
	};

	// input file에 change 이벤트 부여
	const inputMainRecipeImage = document.getElementById("input-mainRecipe");

	inputMainRecipeImage.addEventListener("change", e => {
		readMainRecipeImage(e.target);
	});
	// 대표사진 미리보기 스크립트 끝

	// 조리순서 미리보기 스크립트 시작
	function readRecipeOrderImage(order) {

		// 조리순서 번호 가져오기
		var inputNameStr = order.name;
		var inputNum = inputNameStr.substring(39);

		// 인풋 태그에 파일이 있는 경우
		if (order.files && order.files[0]) {
			// FileReader 인스턴스 생성
			const reader = new FileReader();
			// 이미지가 로드가 된 경우
			reader.onload = e => {
				const previewImage = document.getElementById("preview-recipeOrder__" + inputNum);
				previewImage.src = e.target.result;
			}
			// reader가 이미지 읽도록 하기
			reader.readAsDataURL(order.files[0]);
		};
	};

	// input file에 change 이벤트 부여
	$(function() {
		$(document).on("change", ".recipeOrderBox", function() {
			readRecipeOrderImage(this);
		});
	});
	// 조리순서 미리보기 스크립트 끝

	// 조리순서 다중 미리보기 스크립트 시작
	function readMultipleImage(input) {

		const multipleContainer = document.getElementById("multiple-container");

		// 인풋 태그에 파일들이 있는 경우
		if (input.files) {
			// 이미지 파일 검사 (생략)
			console.log(input.files);

			// 유사배열을 배열로 변환 (forEach문으로 처리하기 위해)
			const fileArr = Array.from(input.files);
			const $colDiv1 = document.createElement("div");
			const $colDiv2 = document.createElement("div");
			$colDiv1.classList.add("column");
			$colDiv2.classList.add("column");

			fileArr.forEach((file, index) => {
				const reader = new FileReader();
				const $imgDiv = document.createElement("div");
				const $img = document.createElement("img");
				$img.classList.add("image");
				const $label = document.createElement("label");
				$label.classList.add("image-label");
				$label.textContent = file.name;
				$imgDiv.appendChild($img);
				$imgDiv.appendChild($label);

				reader.onload = e => {
					$img.src = e.target.result;
				};

				// 파일 확인 콘솔
				console.log(file.name);

				// 업로드 파일 이름 불러오기
				if (index % 2 == 0) {
					$colDiv1.appendChild($imgDiv);
				} else {
					$colDiv2.appendChild($imgDiv);
				};

				reader.readAsDataURL(file);
			});

			multipleContainer.appendChild($colDiv1);
			multipleContainer.appendChild($colDiv2);
		};
	};

	// 다중 이미지 등록 비활성화
	// const inputMultipleImage = document.getElementById("input-recipeOrder");
	//inputMultipleImage.addEventListener("change", e => {
	// readMultipleImage(e.target);
	// });
	// 조리순서 다중 미리보기 스크립트 끝

});