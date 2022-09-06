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
}

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
}
const checkNicknameAndEmailDupAsDebounce = _.debounce(checkNicknameAndEmailDup, 300);

// 닉네임, 이메일 확인 스크립트 끝

// 연락처 입력시 자동 하이픈(-) 삽입 스크립트 시작
// 버전 1
const autoHyphenByReplace = (target) => {
	target.value = target.value
		.replace(/[^0-9]/g, '')
		.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}

// 버전 2
function autoHyphenBySplit(target) {
	// 특수문자 제거
	target.value = target.value.replace(/[^0-9]/g, "");

	const value = target.value.split("");

	const textArr = [
		// 첫번째 구간 (00 or 000)
		[0, value.length > 9 ? 3 : 2],
		// 두번째 구간 (000 or 0000)
		[0, value.length > 10 ? 4 : 3],
		// 남은 마지막 모든 숫자
		[0, 4]
	];

	// 총 3번의 반복 ({2,3}) - ({3,4}) - ({4})
	target.value = textArr
		.map(function(v) {
			return value.splice(v[0], v[1]).join("")
		})
		.filter(function(text) {
			return text
		})
		.join("-");
}

// 연락처 입력시 자동 하이픈(-) 삽입 스크립트 끝