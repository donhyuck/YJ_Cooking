// 스크랩 처리 ajax 시작
function Scrap_AjaxForm(btn) {

	const $clicked = $(btn);
	const $targetCode = $clicked.closest('[reaction-code]');
	const code = $targetCode.attr('reaction-code');
	const $targetId = $clicked.closest('[reaction-id]');
	const id = $targetId.attr('reaction-id');
	const $actionName = $clicked.closest('[action]');
	const action = $actionName.attr('action');

	if (action == "make") {
		$.post(
			'/user/reaction/doMakeScrapAjax',
			{
				relTypeCode: code,
				relId: id
			},
			function(data) {

				if (data.success) {
					alert('스크랩 처리');
				}
				else {
					if (data.msg) {
						alert(data.msg);
					}
				}

			},
			'json'
		);
	}
	else if (action == "cancel") {
		$.post(
			'/user/reaction/doCancelScrapAjax',
			{
				relTypeCode: code,
				relId: id
			},
			function(data) {

				if (data.success) {
					alert('스크랩 취소');
				}
				else {
					if (data.msg) {
						alert(data.msg);
					}
				}

			},
			'json'
		);
	}
}
// 스크랩 처리 ajax 끝

// 좋아요 처리 ajax 시작
function Like_AjaxForm(btn) {

	const $clicked = $(btn);
	const $targetCode = $clicked.closest('[reaction-code]');
	const code = $targetCode.attr('reaction-code');
	const $targetId = $clicked.closest('[reaction-id]');
	const id = $targetId.attr('reaction-id');
	const $actionName = $clicked.closest('[action]');
	const action = $actionName.attr('action');

	if (action == "make") {
		$.post(
			'/user/reaction/doMakeLikeAjax',
			{
				relTypeCode: code,
				relId: id
			},
			function(data) {

				if (data.success) {
					alert('좋아요 처리');
				}
				else {
					if (data.msg) {
						alert(data.msg);
					}
				}

			},
			'json'
		);
	}
	else if (action == "cancel") {
		$.post(
			'/user/reaction/doCancelLikeAjax',
			{
				relTypeCode: code,
				relId: id
			},
			function(data) {

				if (data.success) {
					alert('좋아요 취소');
				}
				else {
					if (data.msg) {
						alert(data.msg);
					}
				}

			},
			'json'
		);
	}
}
// 좋아요 처리 ajax 끝