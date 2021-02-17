var instas = null;
let muted = false;

$('#create_new_insta').on('click', function() {
    $.post(ROOT_ADDRESS + '/takeInstaPhoto', JSON.stringify({
    }), function(photo) {
        if(photo != null){
            OpenApp('insta-addNew', photo)
            $.post(ROOT_ADDRESS + '/phoneAnimInsta', JSON.stringify({}));
        }
    })
});

$('.insta-body').on('click', '.insta .fa-trash-alt', function() {
    let $elem = $(this)
    let data = $elem.parent().parent().data('data');

    $.post(ROOT_ADDRESS + '/DeleteInsta', JSON.stringify({
        link: data.photo
    }), function(status) {
        if (status) {
            $elem.parent().fadeOut('normal', function() {
                $elem.parent().parent().remove();
            });
            M.toast({html: 'Apagado com sucesso'});
        } else {
            M.toast({html: 'Ocorreu um erro'});
        }
    })
});

function SetupInsta(){
    instas = GetData('instas');

    let identifier = GetData('myData').id;

    if (instas == null) {
        instas = new Array();
    }

    instas.sort(DateSortOldest);

    $('.insta-body').html('');

    $.each(instas, function(index, insta) {
        if(identifier == insta.identifier){
            $('.insta-body').prepend(`
                <div class="insta">
                    <img class="photo" src="${insta.photo}">
                    <div class="time" data-tooltip="${moment(insta.time).format('MM/DD/YYYY')} ${moment(insta.time).format('hh:mmA')}">${moment(insta.time).fromNow()}</div>
                    <div class="desc"><b>${insta.author}:</b> ${insta.descricao}</div>
                    <div><i class="fas fa-trash-alt"></i></div>
                </div>`
            );
        }
        else{
            $('.insta-body').prepend(`
                <div class="insta">
                    <img class="photo" src="${insta.photo}">
                    <div class="time" data-tooltip="${moment(insta.time).format('MM/DD/YYYY')} ${moment(insta.time).format('hh:mmA')}">${moment(insta.time).fromNow()}</div>
                    <div class="desc"><b>${insta.author}:</b> ${insta.descricao}</div>
                </div>`
            );
        }

        $('.insta-body .insta:first-child .time').tooltip( {
            position: top
        });

        $('.insta-body .insta:first-child').data('data', insta);
    });
}

function ShareNewPhoto(photo){
    $(".phone-wrapper").css('display', 'block')

    $(".insta-addNew-photo").attr("src", photo);
}

$('#insta-addNew-cancel').on('click', function() {
    if (!navDisabled) {
        GoBack();
        navDisabled = true;
        setTimeout(function() {
            navDisabled = false;
        }, 500);
    }
});

$('#insta-addNew-submit').on('click', function() {
    var img = $('.insta-addNew-photo').attr('src');
    var desc = $('#insta-addNew-desc-text').val();

    let newInsta = {
        img: img,
        desc: desc,
    }

    $.post(ROOT_ADDRESS + '/SumbitNewInsta', JSON.stringify({
        newInsta : newInsta
    }), function(photo) {
        if(photo){
            OpenApp('insta')
        }
    })
});

function AddNewInstaPhoto(data){
    instas = GetData('instas');

    let identifier = GetData('myData').id;

    if (instas == null) {
        instas = new Array();
    }

    let newInsta = {
        identifier: data.identifier,
        author: data.author,
        descricao: data.descricao,
    //    likes: data.likes,
        photo: data.photo,
        time: Date.now()
    }

    instas.push(newInsta);

    StoreData('instas', instas);

    let muted = GetData('not');

    if(!muted){
        $('.instaNotification').fadeIn();
        document.getElementById('instaNotID').innerHTML = "<img class='photo' src="+data.photo+"><br><i class='fas fa-crown'></i> <b>"+data.author+"</b>: "+data.descricao;
        setTimeout(function(){
            $(".instaNotification").fadeOut();
        }, 8000);
    }
}

function RemoveInsta(photo) {
    instas = GetData('instas');

    $.each(instas, function(index, insta) {
        if(photo == insta.photo){
            instas.splice(index);
        }
    });

    StoreData('instas', instas);
}