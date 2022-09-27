// 로그인 아이디 확인 스크립트 시작
let validLoginId = "";

function checkLoginIdDup(el) {

	const form = $(el).closest('form').get(0);

	if (form.loginId.value.length == 0) {
		validLoginId = '';
		return;
	}

	if (validLoginId == form.loginId.value) {
		return;
	}

	$.get('../member/getLoginIdDup', {
		isAjax: 'Y',
		loginId: form.loginId.value
	}, function(data) {

		var $message = $(form.loginId).next();

		if (data.resultCode.substr(0, 3) == 'F-1') {
			$message.empty().append(
				'<div class="text-gray-400">' + data.msg + '</div>');
			validLoginId = '';
		} else if (data.resultCode.substr(0, 3) == 'F-A') {
			$message.empty().append(
				'<div class="text-red-400">' + data.msg + '</div>');
			validLoginId = '';
		} else if (data.resultCode.substr(0, 2) == 'S-') {
			$message.empty().append(
				'<div class="text-green-400">' + data.msg + '</div>');
			validLoginId = data.body.loginId;
		}

		if (data.success) {
			validLoginId = data.data1;
		} else {
			validLoginId = '';
		}

		if (data.resultCode == 'F-B') {
			alert(data.msg);
		}

	}, 'json');
};

const checkLoginIdDupAsDebounce = _.debounce(checkLoginIdDup, 300);
// 로그인 아이디 확인 스크립트 끝

// 닉네임, 이메일 확인 스크립트 시작
let validNickname = "";
let validEmail = "";

function checkNicknameAndEmailDup(el) {

	const form = $(el).closest('form').get(0);

	if (form.nickname.value.length == 0) {
		validNickname = '';
		return;
	}

	if (form.email.value.length == 0) {
		validEmail = '';
		return;
	}

	if (validNickname == form.nickname.value) {
		return;
	}

	if (validEmail == form.email.value) {
		return;
	}

	$.get('../member/getNicknameAndEmailDup', {
		isAjax: 'Y',
		nickname: form.nickname.value,
		email: form.email.value
	}, function(data) {

		var $message = $(form.email).next();

		if (data.resultCode.substr(0, 3) == 'F-A') {
			$message.empty().append(
				'<div class="text-red-400">' + data.msg + '</div>');
			validNickname = '';
			validEmail = '';
		} else if (data.resultCode.substr(0, 2) == 'F-') {
			$message.empty().append(
				'<div class="text-gray-400">' + data.msg + '</div>');
			validNickname = '';
			validEmail = '';
		} else if (data.resultCode.substr(0, 2) == 'S-') {
			$message.empty().append(
				'<div class="text-green-400">' + data.msg + '</div>');
			validNickname = data.body.nickname;
			validEmail = data.body.email;
		}

		if (data.success) {
			validNickname = data.data1;
			validEmail = data.data2;
		} else {
			validNickname = '';
			validEmail = '';
		}

	}, 'json');
};
const checkNicknameAndEmailDupAsDebounce = _.debounce(checkNicknameAndEmailDup, 300);

// 닉네임, 이메일 확인 스크립트 끝
var autoHypenPhone = function(str) {
	str = str.replace(/[^0-9]/g, '');
	var tmp = '';
	if (str.length < 4) {
		return str;
	} else if (str.length < 7) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3);
		return tmp;
	} else if (str.length < 11) {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 3);
		tmp += '-';
		tmp += str.substr(6);
		return tmp;
	} else {
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 4);
		tmp += '-';
		tmp += str.substr(7);
		return tmp;
	}

	return str;
};


var phoneNum = document.getElementById('phoneNum');

phoneNum.onkeyup = function() {
	this.value = autoHypenPhone(this.value);
};

// 연락처 입력시 자동 하이픈(-) 삽입 스크립트 끝

// 프로필 미리보기 스크립트 시작
function readImage(input) {
	// 인풋 태그에 파일이 있는 경우
	if (input.files && input.files[0]) {

		// FileReader 인스턴스 생성
		const reader = new FileReader();
		// 이미지가 로드가 된 경우
		reader.onload = e => {
			const previewImage = document.getElementById("preview-profile");
			previewImage.src = e.target.result;
		}
		// reader가 이미지 읽도록 하기
		reader.readAsDataURL(input.files[0]);
	}
};

// input file에 change 이벤트 부여
const inputImage = document.getElementById("input-profile");

inputImage.addEventListener("change", e => {
	readImage(e.target);
});
// 프로필 미리보기 스크립트 끝