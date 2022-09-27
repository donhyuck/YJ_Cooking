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

// 페이지 시작시 스크롤 상단에 위치
$(document).ready(function() {
	$(function() {
		window.scrollTo({
			top: 0,
			left: 0,
			behavior: 'auto'
		});
	});
});