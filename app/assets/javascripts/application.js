//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jcarousellite_1.0.1.min
//= require jquery.bxslider.min
//= require bootstrap.min.js
//= require answers
//= require summernote
//= require jquery-ui-1.10.3.custom.min
//= require jquery.quicksand
//= require spin
//= require summernote
//= require paloma
(function() {
	$("#leftmenu-introduce img").mouseenter(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_introduce_over.png") %>');
	}).mouseleave(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_introduce.png") %>');
	});

	$("#leftmenu-notice img").mouseenter(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_notice_over.png") %>');
	}).mouseleave(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_notice.png") %>');
	});

	$("#leftmenu-review img").mouseenter(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_review_over.png") %>');
	}).mouseleave(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_review.png") %>');
	});

	$("#leftmenu-faq img").mouseenter(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_faq_over.png") %>');
	}).mouseleave(function() {
		$(this).attr("src", '<%= asset_path("leftmenu_faq.png") %>');
	});
	
	$(document).ready(function(){
	  	$("a#nav_logout").click(function(e){
	  		e.preventDefault();
	  		if(confirm('로그아웃 하시겠습니까?')){
	  			return true;
	  		}else{
	  			e.preventDefault();
				return false;
	  		}
	  	});
		
        $("#facebook_login_button").bind("click", function(e) {
          e.preventDefault();
          var opts = {
            lines: 13, // The number of lines to draw
            length: 20, // The length of each line
            width: 10, // The line thickness
            radius: 5, // The radius of the inner circle
            corners: 1, // Corner roundness (0..1)
            rotate: 0, // The rotation offset
            direction: 1, // 1: clockwise, -1: counterclockwise
            color: '#fff', // #rgb or #rrggbb or array of colors
            speed: 1, // Rounds per second
            trail: 60, // Afterglow percentage
            shadow: false, // Whether to render a shadow
            hwaccel: false, // Whether to use hardware acceleration
            className: 'spinner', // The CSS class to assign to the spinner
            zIndex: 2e9, // The z-index (defaults to 2000000000)
            left: 57-36,
            top: 15-36
          };
          var target = document.getElementById('facebook_login_button');
          var spinner = new Spinner(opts).spin(target);
          window.location.href = "/users/auth/facebook";
        });
	});
})();
