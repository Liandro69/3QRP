var lastStreet = null

$(document).ready(function(){

  window.addEventListener("message", function(event){

    if(event.data.showHud == true){  

      if (!$(".huds").is(":visible")) {

        $('.huds').fadeIn();

      }

      setProgressSpeed(event.data.Speed,'.progress-speed');

      setProgressFuel(event.data.Fuel,'.progress-fuel');

      $(".direction").find(".image").attr('style', 'transform: translate3d(' + event.data.Direction + 'px, 0px, 0px)');

      if (lastStreet != event.data.Street) {

        $("#street_text").html(event.data.Street);

      }

      if (event.data.Fuel <= 10) {

        $('.progress-fuel').css("stroke", "#f54242");

      } else if (event.data.Fuel <= 20) {

        $('.progress-fuel').css("stroke", "#ffaf02");

      } else {

        $('.progress-fuel').css("stroke", "#fff");

      }
  
      if (event.data.showKeys == false) {
  
        if (!$("#keys_status").is(":visible")) {

          $("#keys_status").fadeIn();

        }
  
      } else {

        if ($("#keys_status").is(":visible")) {

          $("#keys_status").fadeOut();

        }

      }

      if (event.data.BeltOn == true) {

        if ($("#belt_status").is(":visible")) {

          $("#belt_status").fadeOut();

        }
  
      } else {

        if (!$("#belt_status").is(":visible")) {

          $("#belt_status").fadeIn();

        }

      }

      if (event.data.updateEngine == 3) {

        if ($("#engine_status").is(":visible")) {

          $("#engine_status").fadeOut();

        }
  
      } else if (event.data.updateEngine == 2) {

        if (!$("#engine_status").is(":visible")) {

          $("#engine_status").attr("src", "assets/engine1.png");
          $("#engine_status").fadeIn();

        }

      } else if (event.data.updateEngine == 1) {

        if (!$("#engine_status").is(":visible") || $("#engine_status").src == "assets/engine1.png") {

          $("#engine_status").attr("src", "assets/engine2.png");
          $("#engine_status").fadeIn();

        }

      }

      if ( event.data.cruiseOn == true ) {

        if (!$("#cruise_status").is(":visible")){
  
          $("#cruise_status").fadeIn();
  
        }
  
      } else {
  
        if ($("#cruise_status").is(":visible")){

          $("#cruise_status").fadeOut();
  
        }

      }

      lastStreet = event.data.Street

    } else if (event.data.showHud == false) {

      if ($(".huds").is(":visible")) {

        $("#belt_status").fadeIn();

        $("#keys_status").fadeIn();

        $('#street').fadeIn();

        $("#cruise_status").fadeOut();

        $('.huds').fadeOut();

      }
        
    }

  });

  // Functions

  // Fuel

  function setProgressFuel(percent, element){

    var circle = document.querySelector(element);

    var radius = circle.r.baseVal.value;

    var circumference = radius * 2 * Math.PI;

    var html = $(element).parent().parent().find('span');



    circle.style.strokeDasharray = `${circumference} ${circumference}`;

    circle.style.strokeDashoffset = `${circumference}`;



    const offset = circumference - ((-percent*73)/100) / 100 * circumference;

    circle.style.strokeDashoffset = -offset;



    html.text(Math.round(percent));

  }



  // Speed

  function setProgressSpeed(value, element){

    var circle = document.querySelector(element);

    var radius = circle.r.baseVal.value;

    var circumference = radius * 2 * Math.PI;

    var html = $(element).parent().parent().find('span');

    var percent = value*100/450;



    circle.style.strokeDasharray = `${circumference} ${circumference}`;

    circle.style.strokeDashoffset = `${circumference}`;



    const offset = circumference - ((-percent*73)/100) / 100 * circumference;

    circle.style.strokeDashoffset = -offset;



    html.text(value);

  }



  // setProgress(input.value,element);

  // setProgressFuel(85,'.progress-fuel');

  // setProgressSpeed(124,'.progress-speed');



});

