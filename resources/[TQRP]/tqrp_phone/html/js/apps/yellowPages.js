var yellowPages = null;


function SetupYellowPages() {
    ads = GetData('ads');
    
    let firstname = GetData('firstname');
    let lastname = GetData('lastname');

    let myNumber = GetData('myNumber');

    if (ads == null) {
        ads = new Array();
    }
    
    ads.sort(DateSortOldest);
    
    $('.ads-body').html('');
    $.each(ads, function(index, ad) {
        if(myNumber == ad.num){
            $('.ads-body').prepend(`
                <div class="ads">
                    <div class="author"><b>${ad.author}</b></div>
                    <div class="body">${ad.pageText}</div>
                    <div class="num" data-tooltip="Ligar" data-num=${ad.num}>${ad.num}</div>
                    <div class="time">${moment(ad.time).fromNow()}</div>
                    <div><i class="fas fa-trash-alt"></i></div>
                </div>`
            );
        }
        else{
            $('.ads-body').prepend(`
                <div class="ads">
                    <div class="author"><b>${ad.author}</b></div>
                    <div class="body">${ad.pageText}</div>
                    <div class="num" data-tooltip="Ligar" data-num=${ad.num}>${ad.num}</div>
                    <div class="time">${moment(ad.time).fromNow()}</div>
                </div>`
            );
        }


        $('.ads-body .ads:first-child .num').tooltip( {
            position: top
        });

        $('.ads-body .ads:first-child').data('data', ad);
    });
}

$('#new-ads').on('submit', function(e) {
    e.preventDefault();
    
    let data = $(this).serializeArray();
    
    let firstname = GetData('firstname');
    let lastname = GetData('lastname');
    let myNumber = GetData('myNumber');

    $.post(ROOT_ADDRESS + '/NewYellowPages', JSON.stringify({
        author: firstname+" "+lastname,
        message: data[0].value,
        number: myNumber,
        time: Date.now()
    }), function(status) {
        if (status) {
            var modal = M.Modal.getInstance($('#send-ads-modal'));
            modal.close();
            $('#new-ads-msg').val('');
            M.toast({html: 'Adicionado com sucesso'});
        } else {
            var modal = M.Modal.getInstance($('#send-ads-modal'));
            modal.close();
            M.toast({html: 'Já tens um anúncio'});
        }
    })
})

$('.ads-body').on('click', '.ads .num', function() {
    let number = $(this).data('num');

    CreateCall(number, false, false);
});

$('.ads-body').on('click', '.ads .fa-trash-alt', function() {
    let $elem = $(this)
    $.post(ROOT_ADDRESS + '/DeleteYellowPages', JSON.stringify({
        
    }), function(status) {
        if (status) {
            $elem.parent().fadeOut('normal', function() {
                $elem.parent().parent().remove();
            });
            M.toast({html: 'Apagado com sucesso'});
        } else {
            var modal = M.Modal.getInstance($('#send-ads-modal'));
            M.toast({html: 'Ocorreu um erro'});
        }
    })
});

function SendToast(args) {
    var message = JSON.parse(JSON.stringify(args))
    M.toast({html: message});
}

function ReceivedYellowPages(data) {
    ads = GetData('ads');
    let myNumber = GetData('myNumber');
    
    if (ads == null) {
        ads = new Array();
    }

    let ad = {
        author: data.author,
        pageText: data.pageText,
        num: data.num,
        time: data.time
    }


    ads.push(ad);

    StoreData('ads', ads);
    if(myNumber == ad.num){
        $('.ads-body').prepend(`
            <div class="ads">
                <div class="author"><b>${ad.author}</b></div>
                <div class="body">${ad.pageText}</div>
                <div class="num" data-tooltip="Ligar" data-num=${ad.num}>${ad.num}</div>
                <div class="time">${moment(ad.time).fromNow()}</div>
                <div><i class="fas fa-trash-alt"></i></div>
            </div>`
        );
    }
    else{
        $('.ads-body').prepend(`
            <div class="ads">
                <div class="author"><b>${ad.author}</b></div>
                <div class="body">${ad.pageText}</div>
                <div class="num" data-tooltip="Ligar" data-number=${ad.num}>${ad.num}</div>
                <div class="time">${moment(ad.time).fromNow()}</div>
            </div>`
        );
    }

    $('.ads-body .ads:first-child .num').tooltip( {
        enterDelay: 0,
        exitDelay: 0,
        inDuration: 0,
    });

    $('.ads-body .ads:first-child').data('data', ad);
    let muted = GetData('not');

    if(!muted){
        $('.yellowNotification').fadeIn();
        var text = data.pageText.substring(0,80)+'...';
        document.getElementById('yellowNotID').innerHTML = "<i class='fas fa-ad'></i> <a><b>"+data.author+"</b><br>"+text+"</a>";
        setTimeout(function(){
            $(".yellowNotification").fadeOut();
        }, 8000);
    }
}

function RemoveYellowPages(id) {
    ads = GetData('ads');
    $.each(ads, function(index, ad) {
        if(id == ad.id){
            ads.splice(index, 1);
            StoreData('ads', ads);
        }
    });   
}