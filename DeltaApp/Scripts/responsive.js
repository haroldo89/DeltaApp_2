
/*Checking if it's touch device we disable some functionality due to inconsistency*/
if (Modernizr.touch) { 

/////////////////////*Touch Devices*////////////////////////////////////

		$('.animation').css('opacity', '1');
		
		/*Scripts Executed on Page Load*/
		var wrapper = $('#wrapper');
		$(window).on('load', function(){
			
			/*Curtain Effect*/
			wrapper.css('margin-top', $(window).height()-90);
			
			/*Stiky Header*/
			$(".stiky").waypoint('sticky');
			
		});
		
		/*Scripts Executed on Page Resize*/	
		$(window).on('resize', function(){
			wrapper.css('margin-top', $(window).height()-90);
		});
		
		/*iOS Dropdowns Bug Fixes*/
		$('.dropdown-toggle').click(function(e) {
			e.preventDefault();
			setTimeout($.proxy(function() {
				if ('ontouchstart' in document.documentElement) {
					$(this).siblings('.dropdown-backdrop').off().remove();
				}
			}, this), 0);
		});		
} else {
/////////////////////*No-touch Devices*////////////////////////////////////
		/*Scripts Executed on Page Load*/
		$(window).on('load', function(){
		    $('.main-content-login').css('height', $(window).height() - 306);
		    $('.overlay').css('height', $(window).height() - 212);
		    if ($(window).height() < 690) {
		        $('.form-bg').css('margin-top', -30);
		    } else {
		        $('.form-bg').css('margin-top', '5%');
		    }
		    if ($(window).width() < 530) {
		        $('.navbar-header-layout').css('right', 8);
		    } else {
		        $('.navbar-header-layout').css('right', '20%');
		    }
		});
		/*Scripts Executed on Page Resize*/	
        $(window).on('resize', function () {
            //$(".windowWidht").text($(window).width() + "x" + $(window).height());
            $('.main-content-login').css('height', $(window).height() - 306);
            $('.overlay').css('height', $(window).height() - 212);
            if ($(window).height() < 690) {
                $('.form-bg').css('margin-top', -30);
            } else {
                $('.form-bg').css('margin-top', '5%');
            }
            if ($(window).width() < 530) {
                $('.navbar-header-layout').css('right', 8);
            } else {
                $('.navbar-header-layout').css('right', '20%');
            }
		});

}//Close Modernizr.touch




/*Document Ready*/
$(document).ready(function(e) {
	
	 
		
});/*/Document ready*/

