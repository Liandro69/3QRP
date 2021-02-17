$(function() {

  var meterVisible = false;
  var currencyPrefix = '';
  var rateSuffix = '';
  var rateType = 'distance';
  var rateAmount = null;
  var currentFare = 5.00;
  var pause = false;
  var moving = false;

  $('#greenlight').hide();
  $('#redlight').hide();

	window.addEventListener("message", function(event) {
    switch(event.data.type) {
      case 'show_config':
        showConfig();
        break;
      case 'hide_config':
        hideConfig();
      case 'update_meter':
        updateMeterAttributes(event.data.attributes);
        //refreshMeterDisplay(); TESTEAR ESTO
      default:
    }
  });

  $('.toggle-meter').on('click', function(){
    attrs = {'meterVisible' : 'toggle'}
    $.post('http://tqrp_taximeter/updateAttrs', JSON.stringify(attrs));
  });

  $('.fare-distance').on('click', function(){
    attrs = {'rateType' : 'distance'}
    $.post('http://tqrp_taximeter/updateAttrs', JSON.stringify(attrs));
  });

  $('.fare-flat').on('click', function(){
    attrs = {'rateType' : 'flat'}
    $.post('http://tqrp_taximeter/updateAttrs', JSON.stringify(attrs));
  });

  $('.close').on('click', function(){
    $.post('http://tqrp_taximeter/closeConfig', JSON.stringify({}));
  });

  $('.set-rate').on('click', function(){
    $.post('http://tqrp_taximeter/setRate', JSON.stringify({}));
  });

  $('.reset-trip').on('click', function(){
    $.post('http://tqrp_taximeter/resetFare', JSON.stringify({}));
  });


  function showConfig(){
    $('#config').show();
  }

  function hideConfig(){
    $('#config').hide();
  }

  function showMeter() {
    $('#meter').show();
  }

  function hideMeter() {
    $('#meter').hide();
  }

  function setRate(rate) {
    updateFareType();
  }

  function updateMeterAttributes(attributes) {
    if (attributes) {
      meterVisible = attributes['meterVisible'];
      rateType = attributes['rateType'];

      rateAmount = attributes['rateAmount'];
      currentFare = attributes['currentFare'];
      currencyPrefix = attributes['currencyPrefix'];
      rateSuffix = attributes['rateSuffix'];
      pause = attributes['meterPause'];
      //moving = attributes['isMoving'];
      if (moving != attributes['isMoving']){
        moving = attributes['isMoving'];
        updateLight()
      }
      refreshMeterDisplay();
    }
  }

  function updateLight(){
    if(moving){
      $('#greenlight').show();
      $('#redlight').hide();
    }else{
      $('#redlight').show();
      $('#greenlight').hide();
    }
  }

  function refreshMeterDisplay(){
    toggleMeterVisibility();
    updateRateType();
    updateCurrentFare();
    updatePauseState();
    //updateLight();
  }

  function toggleMeterVisibility(){
    if(meterVisible){
      showMeter();
    } else {
      hideMeter();
    }
  }

  function updateCurrentFare(){
    if(rateType == 'flat'){
      string = currencyPrefix + (rateAmount || '--');
    }else{
      string = currencyPrefix + (currentFare || '0.00');
    }

    $('.meter-field.fare').text(string);
  }

  function updateRateType() {
    if(rateType == 'flat'){
      string = 'FLAT'
    }else{
      string = currencyPrefix + (rateAmount || '--') + rateSuffix
    }

    $('.meter-field.rate').text(string);
  }

  function updatePauseState() {
    if(pause){
      string = 'OFF'
    }else{
      string = 'ON'
    }

    $('.meter-field.state').text(string);
  }

});
