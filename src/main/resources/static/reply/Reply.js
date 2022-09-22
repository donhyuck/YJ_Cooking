// 댓글 작성시 유효성 검사 스크립트 시작
let ReplyWrite__submitFormDone = false;

function ReplyWrite__submitForm(form) {

	if (ReplyWrite__submitFormDone) {
		return;
	}

	form.body.value = form.body.value.trim();
	if (form.body.value.length < 3) {
		alert('최소 3글자 이상 입력해주세요.');
		form.body.focus();
		return;
	}

	ReplyWrite__submitFormDone = true;
	form.submit();
}
// 댓글 작성시 유효성 검사 스크립트 끝

// 댓글 수정시 유효성 검사 스크립트 시작
let ReplyModify__submitFormDone = false;

function ReplyModify__submitForm(form) {

	if (ReplyModify__submitFormDone) {
		return;
	}

	form.body.value = form.body.value.trim();
	if (form.body.value.length == 0) {
		alert('수정내용을 입력해주세요.');
		form.body.focus();
		return;
	}

	ReplyModify__submitFormDone = true;
	form.submit();
}
// 댓글 수정시 유효성 검사 스크립트 끝

// 댓글 수정 모달 활성화/비활성화 스크립트 시작
// 수정 클릭시 활성화
function ReplyModify__showModal(el) {

	const $target = $(el).closest('[data-id]');
	const replyId = $target.attr('data-id');
	const replyBody = $target.find('.reply-body').html();

	$('.ReplyModify_box [name="id"]').val(replyId);
	$('.ReplyModify_box [name="body"]').val(replyBody);

	$('.ReplyModify_box').css('display', 'flex');
}

// 닫기 클릭시 비활성화
function ReplyModify__hideModal() {

	$('.ReplyModify_box').hide();
}

// 외부영역 클릭시 비활성화	
$('.ReplyModify_box').click(function(e) {
	if (!$(e.target).hasClass("ReplyModify_area")) {
		$('.ReplyModify_box').hide();
	}
});

// 댓글 수정 모달 활성화/비활성화 스크립트 끝

// 댓글 작성후 스크롤 이동 스크립트 시작
function ReplyList__goToReply(id) {
	setTimeout(function() {
		const $target = $('.reply-list [data-id="' + id + '"]');
		const targetOffset = $target.offset();
		$(window).scrollTop(targetOffset.top - 50);
		$target.addClass('focus');

		setTimeout(function() {
			$target.removeClass('focus');
		}, 1000);
	}, 1000);
}

if (param.focusReplyId) {
	ReplyList__goToReply(param.focusReplyId);
}
// 댓글 작성후 스크롤 이동 스크립트 끝

// 댓글 삭제 ajax 시작
function ReplyDelete_AjaxForm(btn) {

	const $clicked = $(btn);
	const $target = $clicked.closest('[data-id]');
	const id = $target.attr('data-id');

	$clicked.text('삭제중...');

	$.post(
		'/user/reply/doDeleteAjax',
		{
			id: id
		},
		function(data) {

			if (data.success) {
				$target.remove();
			}
			else {
				if (data.msg) {
					alert(data.msg);
				}

				$clicked.text('삭제중에러발생');
			}

		},
		'json'
	);
}
// 댓글 삭제 ajax 끝