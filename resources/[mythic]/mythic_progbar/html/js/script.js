var cancelledTimer = null;

$('document').ready(function() {
    MythicProgBar = {};
    MythicProgBar.Progress = function(data) {
        clearTimeout(cancelledTimer);
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text(data.label);
        $("#progress-bar").stop().css({"width": 0, "background": "linear-gradient(-90deg, rgba(89, 148, 215, 0.5), rgba(33, 56, 82, 0.25))"}).animate({
          width: '100%'
        }, {
          duration: parseInt(data.duration),
          complete: function() {
            $(".progress-container").fadeOut( "slow", function() {
                $(".progress-container").css({"display":"none"});
                $("#progress-bar").css("width", 0);
                $.post('http://mythic_progbar/actionFinish', JSON.stringify({
                    })
                );
            });
          }
        });
    };

    MythicProgBar.ProgressCancel = function() {
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text("CANCELADO");
        $("#progress-bar").stop().css( {"width": "100%", "background": "linear-gradient(-90deg, rgba(89, 148, 215, 0.5), rgba(33, 56, 82, 0.25))"});

        cancelledTimer = setTimeout(function () {
            $(".progress-container").css({"display":"none"});
            $("#progress-bar").css("width", 0);
        }, 1000);
    };

    MythicProgBar.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({"display":"none"});
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'mythic_progress':
                MythicProgBar.Progress(event.data);
                break;
            case 'mythic_progress_cancel':
                MythicProgBar.ProgressCancel();
                break;
        }
    })
});