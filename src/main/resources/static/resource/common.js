jQuery(document).ready(function($) {
	$(".scroll").click(function(event) {
		vent.preventDefault();
		('html,body').animate({
			scrollTop: $(this.hash).offset().top
		}, 500);
		;

	});