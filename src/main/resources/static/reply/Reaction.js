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
					const scrapCnt = data.data1;

					var newScrapIcon = "<a action='cancel' id='scrapIcon' class='scrapIcon' onclick='Scrap_AjaxForm(this);'>"
						+ "<i class='fa-solid fa-file-circle-check'></i>"
						+ "<div class='text-lg font-bold mt-2'>스크랩" + scrapCnt + "</div></a>";
					$('#scrapIcon').replaceWith(newScrapIcon);
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
					const scrapCnt = data.data1;

					var newScrapIcon = "<a action='make' id='scrapIcon' onclick='Scrap_AjaxForm(this);'>"
						+ "<i class='fa-solid fa-file'></i>"
						+ "<div class='text-lg font-bold mt-2'>스크랩" + scrapCnt + "</div></a>";
					$('#scrapIcon').replaceWith(newScrapIcon);
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
					const likeCnt = data.data1;

					var newLikeIcon = "<a action='cancel' id='likeIcon' onclick='Like_AjaxForm(this);'>"
						+ "<i class='fa-solid fa-heart-circle-check'></i>"
						+ "<div class='text-lg font-bold mt-2'>좋아요" + likeCnt + "</div></a>";
					$('#likeIcon').replaceWith(newLikeIcon);
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
					const likeCnt = data.data1;

					var newLikeIcon = "<a action='make' id='likeIcon' onclick='Like_AjaxForm(this);'>"
						+ "<i class='fa-solid fa-heart'></i>"
						+ "<div class='text-lg font-bold mt-2'>좋아요" + likeCnt + "</div></a>";
					$('#likeIcon').replaceWith(newLikeIcon);
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