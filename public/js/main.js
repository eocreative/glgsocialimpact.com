$(function() {

// start smooth scroll for careers
  $('a[href*=#partners]:not([href=#])').click(function() {
    $('html,body').animate({
        scrollTop: $(".partners").offset().top},
        'slow');
  });
  // end smooth scroll for careers

});
