// 버튼 클릭시 이동 효과 스크립트 시작
jQuery(document).ready(function($) {
	$(".scroll").click(function(event) {
		event.preventDefault();
		$("html,body").animate({
			scrollTop: $(this.hash).offset().top
		}, 400);
	});
	
	$(".toggleSearchBox").click(function() {
		$(".searchBox").toggleClass("hidden");
	});
	
	$(".toggleChangePhotoBox").click(function() {
		$(".changePhoto").toggleClass("hidden");
	});

	$(".toggleRecipeOrderBox").click(function() {
		$(".recipeOrder").toggleClass("hidden");
	});

});
// 버튼 클릭시 이동 효과 스크립트 끝