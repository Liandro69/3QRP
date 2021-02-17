$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "openNUI"){
            $('#main').css('display', 'block').fadeIn();
            $('#companyName').html(event.data.storeName);
            $('#woodTitle').html("Madeira (" + event.data.wood + "%)");
            $('#foodTitle').html("Alimento (" + event.data.food + "%)");
            $('#mineTitle').html("Minerais (" + event.data.mine + "%)");
            $('#waterTitle').html("Vinhaça (" + event.data.water + "%)");
            $('.wood-bar-fill').css('width',event.data.wood + '%');
            $('.food-bar-fill').css('width',event.data.food + '%');
            $('.mine-bar-fill').css('width',event.data.mine + '%');
            $('.water-bar-fill').css('width',event.data.water + '%');
        }else if(event.data.type == "closeUI"){
            $('#main').css('display', 'none');  
        }
    });

    $( "#sell" ).click(function() {
        $('#main').css('display', 'none');
        $.post('http://tqrp_jobs/sell', JSON.stringify({
            companyName: $("#companyName").html()
        }));
        $.post('http://tqrp_jobs/NUIFocusOff', JSON.stringify({}));
    });

    $( "#get" ).click(function() {
        $('#main').css('display', 'none');
        $.post('http://tqrp_jobs/get', JSON.stringify({
            companyName: $("#companyName").html()
        }));
        $.post('http://tqrp_jobs/NUIFocusOff', JSON.stringify({}));
    });
});

document.onkeyup = function(data){
    if (data.which == 27){
        $('#main').css('display', 'none');
        $.post('http://tqrp_jobs/NUIFocusOff', JSON.stringify({}));
    }
}
