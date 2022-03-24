(function($) {

	"use strict";

	// sticky menu 
	$(window).on("load scroll resize", function(e){
		if ($(document).scrollTop() >= 50 || $('.navbar-toggler').is(":visible") ) {
			$('#topnav').addClass('scrolled');
		} else {
			$('#topnav').removeClass('scrolled');
		}

	});

	$(window).on("load", function(){

		if (location.hash[0] == "#") {
			var target = $(location.hash);

			if ($('.navbar-toggler').is(":visible"))
				var menu_offset = 60;
			else var menu_offset = 70;

			$('html,body').animate({
				scrollTop: target.offset().top-menu_offset
			}, 1000);

			$('#navigation ul li a[href="'+location.href+'"]').parent().addClass('active');
			return false;
		}
	});

	$('.navbar-nav>li>a').on('click', function(){
		$('.navbar-collapse').collapse('hide');
	});
	
	$('a[href*=#]').not('[data-toggle="tab"]').click(function() {

		if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
			var target = $(this.hash);
			target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
			if (target.length) {

				if ($('.navbar-toggler').is(":visible"))
					var menu_offset = 60;
				else var menu_offset = 70;

				$('html,body').animate({
					scrollTop: target.offset().top-menu_offset
				}, 1000);
				$(this).closest('ul').find('.active').removeClass('active');
				$(this).parent().addClass('active');
				return false;
			}
		}
	});

	//mobile stop hover effect
	$('a').on('touchend', function(){
		$(this).addClass('uppy');
	});


})(jQuery);