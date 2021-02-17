var apps = null;
var wallpaper = null;

$('#home-container').on('click', '.app-button', function(event) {
    OpenApp($(this).data('container'));
});

function SetupHome() {
    apps = GetData('apps');
    wallpaper = GetData('wallpaper');

    if (wallpaper == null) {
        wallpaper = '1';
    }

    $('#home-container .inner-app').html('');
    $.each(apps, function(index, app) {
        if (app.enabled) {
            if (app.unread > 0) {
                $('#home-container .inner-app').append('<div class="app-button" data-tooltip="' + app.name + '"><div class="app-icon" id="' + app.container + '-app" style="color: ' + app.color + '"> ' + app.icon + '<div class="badge pulse">' + app.unread + '</div></div></div>')
            } else {
                $('#home-container .inner-app').append('<div class="app-button" data-tooltip="' + app.name + '"><div class="app-icon" id="' + app.container + '-app" style="color: ' + app.color + '"> ' + app.icon + '</div></div>')
            }
            let $app = $('#home-container .app-button:last-child');
            
            $app.tooltip( {
                enterDelay: 0,
                exitDelay: 0,
                inDuration: 0,
            });
    
            $app.data('container', app.container);
        } 
    });
    
    //Colocar papel de parede
    if(wallpaper == '1' || wallpaper == '2' || wallpaper == '3' || wallpaper == '4' || wallpaper == '5' || wallpaper == '6'){
        $('.phone-screen').css('background-image','url(img/background'+wallpaper+'.png)');
    }
    else{
        $('.phone-screen').css('background-image','url('+wallpaper+')');
    }
}

function UpdateUnread(name, unread) {
    if (apps == null) {
        apps = GetData('apps');
    }
    
    $.each(apps, function(index, app) {
        if (app.container === name) {
            app.unread = app.unread + unread
            StoreData('apps', apps);
            SetupHome();
            return false;
        }
    });
}

function ResetUnread(name) {
    if (apps == null) {
        apps = GetData('apps');
    }

    $.each(apps, function(index, app) {
        if (app.container === name) {
            app.unread = 0
            StoreData('apps', apps);
            SetupHome();
            return false;
        }
    });
}

function ToggleApp(name, status) {
    let pApp = filter(app => app.container === name)[0];
    
    if (!status) {
        $('#' + pApp.container + '-app').parent().fadeOut();
        pApp.enabled = false;
    } else {
        pApp.enabled = true;
        SetupHome()
    }
}