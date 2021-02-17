$(document).ready(function() {
    var show =  false
    window.addEventListener('message', function (event) {
        switch(event.data.type) {
            case 'openNotifications':
                SetupNotifications(event)
                break;
            case 'newNotifications':
                NewNotifications(event)
                break;
            case 'deleteNotifications':
                DeleteAlerts(event)
                break;
            case 'hideNotifications':
                $('.notification').css('display', 'none');
                show =  false
                break;
        }
    });

    document.onkeydown = function (e) {
        if (e.which == 27 || e.which == 9) { // Escape key 
            $(".notification").slideDown("fast", function() {
                $.post('http://tqrp_outlawalert/close', JSON.stringify({}));
                $('.notification').css('display', 'none');
                show =  false
            });
        }
    };

    function DeleteAlerts(event){
        $.each(event.data.notifications, function (index, notification) {
            $.post('http://tqrp_outlawalert/deleteAlert', JSON.stringify({id:indexId}));

            if(!$(".notification").is(":visible")){
                $.post('http://tqrp_outlawalert/close', JSON.stringify({}));
            }
        })
    }
    
    function SetupNotifications(event){
        document.getElementById('notification_wrapper').innerHTML = "";

        $.each(event.data.notifications, function (index, notification) {
            if (notification.level == 1) {
                var notType = 'background: rgba(138, 23, 12, 0.95); box-shadow: -5px 0px 0px 0px rgb(255, 255, 255) inset;'
                var notType2 = 'background: rgba(255, 255, 255, 1); color: rgba(220, 64, 50, 1);'
            } else if (notification.level == 2) {
                var notType = 'background: rgba(255, 140, 0, 0.95); box-shadow: -5px 0px 0px 0px rgb(255, 255, 255) inset;'
                var notType2 = 'background: rgba(255, 255, 255, 1); color: rgba(255, 140, 0, 1);'
            } else if (notification.level == 3) {
                var notType = 'background: rgba(17, 84, 160, 0.95); box-shadow: -5px 0px 0px 0px rgb(255, 255, 255) inset;'
                var notType2 = 'background: rgba(255, 255, 255, 1); color: rgba(17, 84, 160, 1);'
            }
            $('#notification_wrapper').prepend(`
                <div id="notification-${notification.number}" class="notification" style="${notType}">
                    <div class="title">
                        <div class="code" style="${notType2}">${notification.code}</div>
                        <div class="cont"><b>${notification.title}</b></div>
                    </div>
                    <div class="desc">
                        <span class="material-icons md-6">${notification.emote}</span>
                        <div class="cont2">${notification.desc}</div>
                    </div>
                    <div class="delete" data-id=${index+1}>
                        <div style="font-size: 13px; position: absolute; right: 25px; top: 4px;">${notification.time}</div>
                        <a>
                            <span class="material-icons md-9">close</span>
                        </a> 
                    </div>
                    <div class="loc" data-id=${index+1}>
                        <a>
                            <span class="material-icons md-6">add_location</span>
                        </a>
                    </div>
                </div>
            `);
        });

        $('.notification').css('display', 'block');
        show =  true
    }

    function NewNotifications(event){
        var notification = event.data.notifications

        if (notification.level == 1) {
            var notType = 'background: rgba(138, 23, 12, 0.95); box-shadow: -5px 0px 0px 0px rgb(255, 255, 255) inset;'
            var notType2 = 'background: rgba(255, 255, 255, 1); color: rgba(220, 64, 50, 1);'
        } else if (notification.level == 2) {
            var notType = 'background: rgba(255, 140, 0, 0.95); box-shadow: -5px 0px 0px 0px rgb(255, 255, 255) inset;'
            var notType2 = 'background: rgba(255, 255, 255, 1); color: rgba(255, 140, 0, 1);'
        } else if (notification.level == 3) {
            var notType = 'background: rgba(17, 84, 160, 0.95); box-shadow: -5px 0px 0px 0px rgb(255, 255, 255) inset;'
            var notType2 = 'background: rgba(255, 255, 255, 1); color: rgba(17, 84, 160, 1);'
        }
        $('#notification_wrapper').prepend(`
            <div id="notification-${notification.number}" class="notification" style="display: block;${notType}">
                <div class="title">
                    <div class="code" style="${notType2}">${notification.code}</div>
                    <div class="cont"><b>${notification.title}</b></div>
                </div>
                <div class="desc">
                    <span class="material-icons md-48">${notification.emote}</span>
                    <div class="cont2">${notification.desc}</div>
                </div>
                <div class="street">
                    <span class="material-icons md-48">${notification.emote2}</span>
                    <div class="cont2">${notification.street}</div>
                </div>
            </div>
        `);
        var timer = 7000

        setTimeout(function(){
            if(show == false){
                $("#notification-"+notification.number).fadeOut();
            }
        }, timer);
    }

    $(document).on('click', '.loc', function () {
        $.post('http://tqrp_outlawalert/createBlip', JSON.stringify({id:$(this).data('id')}));
    });

    $(document).on('click', '.delete a', function () {
        $(this).parent().parent().remove();
        
        $.post('http://tqrp_outlawalert/deleteAlert', JSON.stringify({id:$(this).parent().data('id')}));
        
        if(!$(".notification").is(":visible")){
            $.post('http://tqrp_outlawalert/close', JSON.stringify({}));
        }
    });
});