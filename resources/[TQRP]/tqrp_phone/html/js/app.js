document.addEventListener("DOMContentLoaded", function() {
    var elements = document.getElementsByTagName("INPUT");
    for (var i = 0; i < elements.length; i++) {
        elements[i].oninvalid = function(e) {
            e.target.setCustomValidity("");
            if (!e.target.validity.valid) {
                e.target.setCustomValidity("Preencha este campo");
            }
        };
        elements[i].oninput = function(e) {
            e.target.setCustomValidity("");
        };
    }
})

var ROOT_ADDRESS = 'http://tqrp_phone'

var appTrail = [{
    app: null,
    data: null
}];

var navDisabled = false;

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case 'setup':
            SetupData(event.data.data);
            break;
        case 'show':
            $('.phone-wrapper').show("slide", { direction: "down" }, 500);
            if (!IsCallPending()) {
                OpenApp('home', null, true);
            } else {
                appTrail = [{
                    app: 'home',
                    data: null
                }];

                OpenApp('phone-call', { number: event.data.number, receiver: !event.data.initiator }, false);
            }
            break;
        case 'hide':
            ClosePhone();
            break;
        case 'logout':
            ClearData();
            break;
        case 'setmute':
            SetMute(event.data.muted);
            break;
        case 'setnot':
            SetNot(event.data.muted);
            break;
        case 'updateTime':
            UpdateClock(event.data.time);
            break;
        case 'receiveText':
            ReceiveText(event.data.data);
            break;
        case 'receiveCall':
            OpenApp('phone-call', { number: event.data.number, receiver: true }, false);
            break;
        case 'acceptCallSender':
            CallAnswered();
            break;
        case 'acceptCallReceiver':
            CallAnswered();
            break;
        case 'endCall':
            CallHungUp();
            break;
        case 'receiveTweet':
            ReceivedTweet(event.data.data);
            break;
        case 'updateUnread':
            UpdateUnread(event.data.app, event.data.unread);
            break;
        case 'receiveYellow':
            ReceivedYellowPages(event.data.data);
            break;
        case 'removeYellow':
            RemoveYellowPages(event.data.num);
            break;
        case 'removeTweet':
            RemoveTweets(event.data.data);
            break;
        case 'updateCarConfigs':
            UpdateVehicle(event.data.data);
            break;
        case 'updateVehState':
            UpdateVehicleState(event.data.data);
            break;
        case 'updateHistory':
            UpdateHistory(event.data.data);
            break;
        case 'toastNotify':
            SendToast(event.data.data);
            break;
        case 'receiveInsta':
            AddNewInstaPhoto(event.data.data);
            break;
        case 'removeInsta':
            RemoveInsta(event.data.data.photo);
            break;
    }
});

$(document).ready(function(){
    $('.modal').modal();
    $('.dropdown-trigger').dropdown({
        constrainWidth: false
    });
    $('.tabs').tabs();
    $('.char-count-input').characterCounter();
    $('.phone-number').mask("000000000", {placeholder: "#########"});
});

$( function() {
    document.onkeyup = function ( data ) {
        if ( data.which == 27 ) {
            ClosePhone();
        }
    };
});

$('.back-button').on('click', function(e) {
    if (!navDisabled) {
        GoBack();
        navDisabled = true;
        setTimeout(function() {
            navDisabled = false;
        }, 500);
    }
});

$('.home-button').on('click', function(e) {
    if (!navDisabled) {
        GoHome();
        navDisabled = true;
        setTimeout(function() {
            navDisabled = false;
        }, 500);
    }
});

$('.close-button').on('click', function(e) {
    ClosePhone()
});

$('.mute').on('click', function(e) {
    let muted = GetData('muted');
    SetMute(!muted);
});

$('.not').on('click', function(e) {
    let muted = GetData('not');
    SetNot(!muted);
});

function ClosePhone() {
    $.post(ROOT_ADDRESS + '/ClosePhone', JSON.stringify({}));
    $('.phone-wrapper').hide("slide", { direction: "down" }, 500, function() {
        $('#toast-container').remove();
        $('.material-tooltip').remove();
        $('.app-container').hide();
        appTrail = [{
            app: null,
            data: null
        }];
    });
}



function OpenApp(app, data = null, pop = false) {
    if ($('#' + app + '-container').length == 0 || appTrail.length == 0) return;    
    if (appTrail[appTrail.length - 1].app !== app) {
        if ($('.active-container').length > 0) {
            $('.active-container').fadeOut('fast', function() {
                $('.active-container').removeClass('active-container');
                
                $('#' + app + '-container').fadeIn('fast', function() {
                    $('.active-container').removeClass('active-container');
                    $('#' + app + '-container').addClass('active-container');
        
                    CloseAppAction(appTrail[appTrail.length - 1].app);
                    if (pop) {
                        appTrail.pop();
                        appTrail.pop();
                    }
                    
                    appTrail.push({
                        app: app,
                        data: data
                    });
                });
        
                $('.material-tooltip').remove();
                OpenAppAction(app, data);
            });
        } else {  
            $('#' + app + '-container').fadeIn('fast', function() {
                $('.active-container').removeClass('active-container');
                $('#' + app + '-container').addClass('active-container');
    
                CloseAppAction(appTrail[appTrail.length - 1].app);
                if (pop) {
                    appTrail.pop();
                    appTrail.pop();
                }
                
                appTrail.push({
                    app: app,
                    data: data
                });
            });

            $('.material-tooltip').remove();
            OpenAppAction(app, data);
        }
    }
}

function RefreshApp() {
    $('.material-tooltip').remove();
    OpenAppAction(appTrail[appTrail.length - 1].app, appTrail[appTrail.length - 1].data)
}

function OpenAppAction(app, data) {
    switch(app) {
        case 'home':
            SetupHome();
            break;
        case 'contacts':
            SetupContacts();
            break;
        case 'message':
            SetupMessages();
            SetupNewMessage();
            break;
        case 'message-convo':
            SetupConvo(data);
            break;
        case 'phone':
            SetupCallHistory();
            break;
        case 'phone-call':
            SetupCallActive(data);
            break;
        case 'twitter':
            SetupTwitter();
            break;
        case 'insta':
            SetupInsta();
            break;
        case 'insta-addNew':
            ShareNewPhoto(data)
            break;
        case 'ads':
            SetupYellowPages();
            break;
        case 'fatura':
            $.post(ROOT_ADDRESS + '/RefreshBills', JSON.stringify({}));
            SetupFaturasPage();
            break;
        case 'camera':
           // $.post(ROOT_ADDRESS + '/OpenCamera', JSON.stringify({}));
            CameraToInsta();
            break;
        case 'notas':
            SetupNotasPage()
            break;
        case 'cars':
            SetupCarsPage()
            break;
        case 'info':
            $.post(ROOT_ADDRESS + '/UpdateInfo', JSON.stringify({}));
            SetupInfoPage()
            break;
        case 'news':
            $.post(ROOT_ADDRESS + '/OpenNEWS', JSON.stringify({}));
            break;
    }
}


function CameraToInsta() {
    $.post(ROOT_ADDRESS + '/takeInstaPhoto', JSON.stringify({
    }), function(photo) {
        if(photo != null){
            OpenApp('insta-addNew', photo)
            $.post(ROOT_ADDRESS + '/phoneAnimInsta', JSON.stringify({}));
        }
    })
}

function CloseAppAction(app) {
    switch(app) {
        case 'message-convo':
            CloseConvo();
            break;
        case 'phone-call':
            CloseCallActive();
            break;
    }
}

function GoHome() {
    if (appTrail.length > 1) {
        if (appTrail[appTrail.length - 1].app !== 'home') {
            OpenApp('home');
        }
    }
}

function GoBack() {
    if (appTrail[appTrail.length - 1].app !== 'home') {
        if (appTrail.length > 1) {
            OpenApp(appTrail[appTrail.length - 2].app, appTrail[appTrail.length - 2].data, true);
        } else {
            GoHome();
        }
    }
}

function SetupData(data) {
    $.each(data, function(index, item) {
        window.localStorage.setItem(item.name, JSON.stringify(item.data));
    });
}

function StoreData(name, data) { 
    window.localStorage.setItem(name, JSON.stringify(data));
}

function GetData(name) {
    return JSON.parse(window.localStorage.getItem(name));
}

function ClearData() {
    window.localStorage.clear(); 
}



function DateSortNewest(a,b){
    return a.time < b.time ? 1 : -1;  
};

function DateSortOldest(a,b){
    return a.time > b.time ? 1 : -1;  
};


function UpdateClock(time) {
    $('.phone-header-time span').html(time)
}

function SetMute(status) {
    if (status) {
        $.post(ROOT_ADDRESS + '/SetMuted', JSON.stringify({}));
        $('.mute').html('<i class="fas fa-volume-mute"></i>');
        $('.mute').removeClass('not-muted').addClass('muted');
        StoreData('muted', true);
    } else {
        $.post(ROOT_ADDRESS + '/SetNotMuted', JSON.stringify({}));
        $('.mute').html('<i class="fas fa-volume-up"></i>');
        $('.mute').removeClass('muted').addClass('not-muted');
        StoreData('muted', false);
    }
}

function SetNot(status) {
    if (status) {
        $('.not').html('<i class="fas fa-bell-slash"></i>');
        StoreData('not', true);
        M.toast({html: 'Notificações desligadas'});
    } else {
        $('.not').html('<i class="fas fa-bell"></i>');
        StoreData('not', false);
        M.toast({html: 'Notificações ligadas'});
    }
}