var persistentNotifs = {};
var running = false;
window.addEventListener('message', function (event) {
    ShowNotif(event.data);
});

function CreateNotification(data) {
    var $notification = $(document.createElement('div'));
    $notification.addClass('notification').addClass(data.type);
    $notification.html(data.text);
    $notification.fadeIn();
    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }

    return $notification;
}

function ShowNotif(data) {
    if (running === true) {
        ShowNotif(data)
    } else {
        if (data.type === 'adm') {
            running = true;
           launch_admin(data);
        } 
        else if (data.type === 'msg') {
            running = true;
           launch_msg(data);
        }
        else if (data.type === 'true') {
            running = true;
           launch_success(data);
        } 
        else if (data.type === 'false') {
            running = true;
           launch_error(data);
        } 
        else if (data.type === 'bill') {
            running = true;
           launch_bill(data);
        } 
        else if (data.type === 'dispatch') {
            running = true;
           launch_sos(data);
        } 
        else if (data.type === 'money') {
            running = true;
           launch_money(data);
        } 
        else if (data.type === 'light')
        {
            running = true;
           launch_light(data);
        }
        else if (data.persist === undefined) {
            var $notification = CreateNotification(data);
            $('.notif-container').append($notification);
            t = setTimeout(function() {
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove()
                });
            }, data.length != null ? data.length : 2500);
        } else {
            if (data.persist.toUpperCase() == 'START') {
                if (persistentNotifs[data.id] === undefined) {
                    running = true;
                    var $notification = CreateNotification(data);
                    $('.notif-container').append($notification);
                    persistentNotifs[data.id] = $notification;
                } else {
                    running = true;
                    let $notification = $(persistentNotifs[data.id])
                    $notification.addClass('notification').addClass(data.type);
                    $notification.html(data.text);
    
                    if (data.style !== undefined) {
                        Object.keys(data.style).forEach(function(css) {
                            $notification.css(css, data.style[css])
                        });
                    }
                }
            } else if (data.persist.toUpperCase() == 'END') {
                let $notification = $(persistentNotifs[data.id]);
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove();
                    delete persistentNotifs[data.id];
                });
            }
        }
    }
}

function launch_admin(data) {
    var x = document.getElementById("toast")
    x.className = "show";
	document.getElementById("image").src = "https://image.flaticon.com/icons/svg/196/196759.svg";
    document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgba(227, 185, 70, 0.8), rgba(227, 185, 70, 0.9))";
	document.getElementById("desc").style.color = "#fff";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}

function launch_msg(data) {
    var x = document.getElementById("toast")
    x.className = "show";
	document.getElementById("image").src = "https://image.flaticon.com/icons/svg/599/599274.svg";
    document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgba(20, 187, 196, 0.5), rgba(20, 187, 196, 0.4))";
    document.getElementById("desc").style.color = "#fff";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}

function launch_bill(data) {
    var x = document.getElementById("toast")
    x.className = "show";
	document.getElementById("image").src = "https://image.flaticon.com/icons/svg/2325/2325679.svg";
    document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgba(20, 187, 196, 0.5), rgba(20, 187, 196, 0.4))";
	document.getElementById("desc").style.color = "#fff";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}

function launch_sos(data) {
    var x = document.getElementById("toast")
    x.className = "show";
    document.getElementById("image").src = "https://image.flaticon.com/icons/svg/595/595031.svg";
    document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 1))";
	document.getElementById("desc").style.color = "#d43f3f";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}

function launch_money(data) {
    var x = document.getElementById("toast")
    x.className = "show";
    document.getElementById("image").src = "https://image.flaticon.com/icons/svg/755/755195.svg";
	document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgba(120, 204, 100, 0.5), rgba(120, 204, 120, 0.4))";
	document.getElementById("desc").style.color = "rgba(255, 255, 255, 0.8)";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}

function launch_success(data) {
    var x = document.getElementById("toast")
    x.className = "show";
	document.getElementById("image").src = "https://image.flaticon.com/icons/svg/594/594852.svg";
	document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgba(120, 204, 45, 0.5), rgba(120, 204, 45, 0.4))";
    document.getElementById("desc").style.color = "#fff";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}

function launch_error(data) {
    var x = document.getElementById("toast")
    x.className = "show";
	document.getElementById("image").src = "https://image.flaticon.com/icons/svg/1828/1828666.svg";
	document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgb(224, 50, 50, 0.5), rgb(224, 50, 50, 0.4))";
	document.getElementById("desc").style.color = "#fff";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}

function launch_light(data) {
    var x = document.getElementById("toast")
    x.className = "show";
	document.getElementById("image").src = "https://image.flaticon.com/icons/svg/196/196759.svg";
    document.getElementById("toast").style.backgroundImage = "linear-gradient(-90deg, rgba(227, 185, 70, 0.8), rgba(227, 185, 70, 0.9))";
	document.getElementById("desc").style.color = "#fff";
	t = setTimeout(function(){ document.getElementById("desc").textContent  = data.text; }, 600);
	t = setTimeout(function(){ document.getElementById("desc").textContent  = ""; }, 4000);
    t = setTimeout(function(){ x.className = x.className.replace("show", ""); running = false;}, 5000);
}
