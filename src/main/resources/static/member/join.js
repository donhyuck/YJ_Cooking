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

	}, 'json');
}

const checkLoginIdDupAsDebounce = _.debounce(checkLoginIdDup, 300);


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

		if (data.resultCode.substr(0, 3) == 'F-1') {
			$message.empty().append(
				'<div class="text-gray-400">' + data.msg + '</div>');
			validNickname = '';
			validEmail = '';
		} else if (data.resultCode.substr(0, 3) == 'F-A') {
			$message.empty().append(
				'<div class="text-red-400">' + data.msg + '</div>');
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