

  




$(document).ready(function(){

	window.addEventListener("message", function(event){

	
		$(".masini").html("<span class='symbol'></span>"+event.data.masini);
		$(".pret").html("<span class='symbol'>Vinde pentru</span>"+event.data.pret);
        $(".numemasina").html("<span class='symbol'>Nume masina </span>"+event.data.numemasina);
        $(".pret").html("<span class='symbol'>Pret  </span> "+event.data.pret+"<br>Model "+event.data.nume+"<br>Masina "+event.data.cat);
        $(".title").html("<span class='symbol'>Detalii:</span>");
        var frane = event.data.frane
       
        var index1 = $(".index-1");
        var index2 = $(".index-2");
        var index3 = $(".index-3");
   
   
        var progress1 = index1.data("progress");
        $(".progress", index1).css("width", event.data.topspead + "%"); 
     
        var progress2 = index2.data("progress");
        $(".progress", index2).css("width", event.data.frane + "%"); 
        
        var progress3 = index3.data("progress");
        $(".progress", index3).css("width", event.data.acceleratie + "%"); 
        
        
	});
  });


$(function () {
    function display(bool) {
        if (bool) {
            
            $("#bag-column").show();
            $("#asd").show();
            $("#container").show();
            $("#hud").show();
            $("#contain").show();
        } else {
            $("#asd").show();
            $("#bag-column").hide();
            $("#container").hide();
            $("#hud").hide();
            $("#contain").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://oxy_showroom/exit', JSON.stringify({}));
            return
        }
    };






 
 









    
    $("#close").click(function () {
        $.post('http://oxy_showroom/exit', JSON.stringify({}));
        return
    })

    $("#urmatoareamasina").click(function () {
        $.post('http://oxy_showroom/urmatoareamasina', JSON.stringify({}));
        return
    })
    $("#masinanaterioara").click(function () {
        $.post('http://oxy_showroom/masinanaterioara', JSON.stringify({}));
        return
    })
    
    $("#cumparamasina").click(function () {
        $.post('http://oxy_showroom/cumparamasina', JSON.stringify({}));
        return
    })



    //when the user clicks on the submit button, it will run
    $("#submit").click(function () {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("http://oxy_showroom/error", JSON.stringify({
                error: "Input was greater than 100"
            }))
            return
        } else if (!inputValue) {
            $.post("http://oxy_showroom/error", JSON.stringify({
                error: "There was no value in the input field"
            }))
            return
        }
        // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
        $.post('http://oxy_showroom/main', JSON.stringify({
            text: inputValue,
        }));
        return;
    })
})



function raspuns() {
	$.post('http://oxy_showroom/select', JSON.stringify({}));
}
var $targetImages = $('.bag-column');
$targetImages.append('<div class="slide-show-holder"></div>');
$('.slide-show-holder').attr('id', function(i) {
   return 'slideshow_'+(i+1);
});
var slideShowID = $('.slide-show-holder').attr('id');


//Add the Controls
$targetImages.append('<div class="circle-holder"></div>');
$('.avia-image-container', $targetImages).each(function(){
  $(this).addClass("slider-image");
  $('.circle-holder', $targetImages).append('<div class="circle"></div>')
});
$(".slider-image").wrapAll("<div class='slider'></div>");
//Give each image an id
$('.slider-image', $targetImages).attr('id', function(i) {
   return 'slider-image_'+(i+1);
});
//Give image controller an id
$('.circle', $targetImages).attr('id', function(i) {
   return 'slider-circle_'+(i+1);
});
// Set defaults
$('.circle:first', $targetImages).addClass("active");

// Arrows
$targetImages.append('<div class="prev-arrow slide-arrow"></div>');
$targetImages.append('<div class="next-arrow slide-arrow"></div>');

//Navigating Through Slideshow
$('.slide-arrow, .circle').click(function(){
  var activeDot = $('.circle.active', $targetImages).attr('id').split('_').pop(),
      slideNumber = $('.slider-image', $targetImages).length;
      if($(this).hasClass('prev-arrow')) {
          if (Number(activeDot) >1){
            var moveX = Number(activeDot)-1;
            $.post('http://oxy_showroom/selectiaanterioara', JSON.stringify({}));
          }else{
            var moveX = Number(activeDot);
          }
      }
      if($(this).hasClass('next-arrow')) {
        var moveX = Number(activeDot)+1;
        $.post('http://oxy_showroom/selectiaurmatoare', JSON.stringify({}));
      }
      
  
      if(moveX < 1) {
        var moveX = 1;
      }
      if(moveX > slideNumber) {
        var moveX = slideNumber;
      }
      if($(this).hasClass('circle')) {
        var moveX = Number($(this).attr('id').split('_').pop());
      }
  //On the site it's not a fraction of 100 but a multiple of one hundred.
  //Ex. 1st Image translateX=0, 2nd = -100%, 3rd = -200%
  var slideIncrement = 100/slideNumber,
      slideMove = ((moveX-1) * slideIncrement);

  $('.circle', $targetImages).removeClass('active');
  $('#slider-circle_'+moveX).addClass('active');
  $('.slider').css('transform', 'translateX(-'+slideMove+'%)');
});

$('.slider').swipe({
  swipe:function(event, direction, distance, duration, fingerCount) {
    switch(direction) {
      case "left":
        $(".next-arrow").trigger("click");
        break;
      case "right":
        $(".prev-arrow").trigger("click");
        break;
    }
  }
});





function culoare(culoareselectata) {

    $.post('http://oxy_showroom/schimbaCuloare', JSON.stringify({culoareselectata}));
}
function cumparamasina() {

    $.post('http://oxy_showroom/cumparamasina', JSON.stringify({}));
}
function testeaza() {

    $.post('http://oxy_showroom/testeaza', JSON.stringify({}));
}
