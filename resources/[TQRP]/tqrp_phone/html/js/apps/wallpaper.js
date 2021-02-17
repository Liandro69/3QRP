$('.wallpaper-body').on('click', '.wallpaper .wall', function() {
    let data = $(this).attr('data-wall');
    if(data != "wall_custom"){
    	$('.phone-screen').css('background-image','url(img/background'+data+'.png)');

    	SaveWallpaper(data);
    	StoreData('wallpaper', data);
    }
    else{
    	M.toast({html: 'Ocorreu um erro'});
    }
});

$('#new-wallpaper').on('submit', function(e) {
    e.preventDefault();

    let data = $(this).serializeArray();

    if (data[0].value.indexOf("https://i.imgur") >= 0){
		$('.phone-screen').css('background-image','url('+data[0].value+')');
	    var modal = M.Modal.getInstance($('#custom-wallpaper-modal'));
	    modal.close();
	    $('#new-wallpaper-msg').val('');
	    SaveWallpaper(data[0].value);
	    StoreData('wallpaper', data[0].value);
	}
	else{
		M.toast({html: 'Coloca um link do imgur.com'});
	}
})

function SaveWallpaper(wallpaper) {
    $.post(ROOT_ADDRESS + '/SaveWallpaper', JSON.stringify({
        wallpaper: wallpaper,
    }), function(status) {
        if (status) {
            M.toast({html: 'Wallpaper atualizado'});
        } else {
            M.toast({html: 'Ocorreu um erro'});
        }
    })
}