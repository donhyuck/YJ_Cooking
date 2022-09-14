// 버튼 클릭시 이동 효과 스크립트 시작
jQuery(document).ready(function($) {
	$(".scroll").click(function(event) {
		event.preventDefault();
		$("html,body").animate({
			scrollTop: $(this.hash).offset().top
		}, 400);
	});
});
// 버튼 클릭시 이동 효과 스크립트 끝