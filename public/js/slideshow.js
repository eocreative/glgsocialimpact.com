jQuery(document).ready(function($) {
  // code here, using $ as usual

  function detectMobile() {
    if(window.innerWidth <= 450) {
       return true;
    } else {
       return false;
    }
  }

  // If it's not mobile, run this script.
  if(!detectMobile()){
    // START SLIDESHOW
    if($(".slide-show").length > 0){
      //preload-images
    
      var slideshowContainer = $(".slide-show");
      var slideImages = [ "home-2", "home-3", "home-4", "home-5" ]
      
      $.each(slideImages, function(i, e){
        var slide = $('<div>');
        slide.addClass('slide').hide();
        slide.css("backgroundImage", "url(/img/banners/" + e + ".jpg)");
        slideshowContainer.append(slide);
      });
    
      var slides = $(slideshowContainer.children());
      slides.currentSlide = 0;
      slides.lastSlide = slides.length - 1;
      window.s = slides;
    
      var rotateSlides = function(slides){
        $(slides[slides.currentSlide]).fadeOut(1200);
        slides.currentSlide = (slides.currentSlide < slides.length -1) ? (slides.currentSlide +1) : 0;
        $(slides[slides.currentSlide]).fadeIn(1200);
      }
    
      setInterval(function(){rotateSlides(slides)}, 6000);
    }
    // END SLIDESHOW
  }

});
