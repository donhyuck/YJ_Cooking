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