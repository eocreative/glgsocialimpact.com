$(function() {

// start smooth scroll for careers
  $('a[href*=#browse]:not([href=#])').click(function() {
    $('html,body').animate({
        scrollTop: $(".partner-section").offset().top},
        'slow');
  });
  // end smooth scroll for careers

});
