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
		+ "<div type='button' onclick='removeRow(this)' class='btn btn-circle ml-3 hover:text-red-400'>삭제</div>";
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
		+ "<div type='button' onclick='removeSauce(this)' class='btn btn-circle ml-3 hover:text-red-400'>삭제</div>";
	sauceBox.appendChild(newSauceP);
}

const removeSauce = (obj) => {
	document.getElementById('sauceBox').removeChild(obj.parentNode);
}
// 재료양념 입력칸 추가/삭제 스크립트 끝

$(document).ready(function() {

	// 페이지 시작시 스크롤 상단에 위치
	$(function() {
		window.scrollTo({
			top: 0,
			left: 0,
			behavior: 'auto'
		});
	});

	$(".toggleChangePhotoBox").click(function() {
		$(".changePhoto").toggleClass("hidden");
	});

	$(".toggleRecipeOrderBox").click(function() {
		$(".recipeOrder").toggleClass("hidden");
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
	const inputImage = document.getElementById("input-mainRecipe");

	inputImage.addEventListener("change", e => {
		readMainRecipeImage(e.target);
	});
	// 대표사진 미리보기 스크립트 끝

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

	const inputMultipleImage = document.getElementById("input-recipeOrder");
	inputMultipleImage.addEventListener("change", e => {
		readMultipleImage(e.target);
	});
	// 조리순서 다중 미리보기 스크립트 끝

});