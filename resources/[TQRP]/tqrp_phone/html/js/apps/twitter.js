var tweets = null;

$('#new-tweet').on('submit', function(e) {
    e.preventDefault();
    
    let data = $(this).serializeArray();
    let firstname = GetData('firstname');
    let lastname = GetData('lastname');

    let tweet = {
        author: firstname+"_"+lastname,
        message: data[0].value,
        time: Date.now()
    }

    var pattern = /\B@[a-z0-9_-]+/gi;
    let highlight = tweet.message.match(pattern);

    mentions = new Array()
    $.each(highlight, function(index2, mention) {
        mentions.push(mention);
    });

    pattern = /\B#[a-z0-9_-]+/gi;
    highlight = tweet.message.match(pattern);
    hashtags = new Array()
    
    $.each(highlight, function(index2, hashtag) {
        hashtags.push(hashtag);
    });

    $.post(ROOT_ADDRESS + '/NewTweet', JSON.stringify({
        author: firstname+"_"+lastname,
        message: data[0].value,
        mentions: mentions,
        hashtags: hashtags,
        time: Date.now()
    }), function(status) {
        if (status) {
            var modal = M.Modal.getInstance($('#send-tweet-modal'));
            modal.close();
            $('#new-tweet-msg').val('');
            M.toast({html: 'Queen Postado'});
        } else {
            var modal = M.Modal.getInstance($('#send-tweet-modal'));
            modal.close();
            M.toast({html: 'Ocorreu um erro'});
        }
    })
})

$('.twitter-body').on('click', '.tweet .mention', function() {
    let user = $(this).data('mention');
    
    $('#new-tweet-msg').val('@' + user + ' ');
    
    var modal = M.Modal.getInstance($('#send-tweet-modal'));
    modal.open();
});

$('.twitter-body').on('click', '.tweet .fa-trash-alt', function() {
    let $elem = $(this)
    let data = $elem.parent().parent().data('data');

    $.post(ROOT_ADDRESS + '/DeleteTweet', JSON.stringify({
        author: data.author,
        message: data.rawMessage
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

function SetupTwitter() {
    tweets = GetData('tweets');

    let identifier = GetData('myData').id;
    
    if (tweets == null) {
        tweets = new Array();
    }
    
    tweets.sort(DateSortOldest);
    
    $('.twitter-body').html('');
    $.each(tweets, function(index, tweet) {
        var pattern = /\B@[a-z0-9_-]+/gi;
        let data = tweet.message.match(pattern);
        $.each(data, function(index2, mention) {
            tweet.message = tweet.message.replace(mention, `<span class="mention" data-mention="${mention.replace('@', '')}">${mention}</span>`);
        });
        
        pattern = /\B#[a-z0-9_-]+/gi;
        data = tweet.message.match(pattern);
        $.each(data, function(index2, hashtag) {
            tweet.message = tweet.message.replace(hashtag, `<span class="hashtag" data-hashtag="${hashtag.replace('#', '')}">` + hashtag + `</span>`);
        });

        if(identifier == tweet.identifier){
            $('.twitter-body').prepend(`
                <div class="tweet">
                    <div class="avatar other-${tweet.author[0].toString().toLowerCase()}">${tweet.author[0]}</div>
                    <div class="author">${tweet.author}</div>
                    <div class="body">${tweet.message}</div>
                    <div class="time" data-tooltip="${moment(tweet.time).format('MM/DD/YYYY')} ${moment(tweet.time).format('hh:mmA')}">${moment(tweet.time).fromNow()}</div>
                    <div><i class="fas fa-trash-alt"></i></div>
                </div>`
            );
        }
        else{
            $('.twitter-body').prepend(`
                <div class="tweet">
                    <div class="avatar other-${tweet.author[0].toString().toLowerCase()}">${tweet.author[0]}</div>
                    <div class="author">${tweet.author}</div>
                    <div class="body">${tweet.message}</div>
                    <div class="time" data-tooltip="${moment(tweet.time).format('MM/DD/YYYY')} ${moment(tweet.time).format('hh:mmA')}">${moment(tweet.time).fromNow()}</div>
                </div>`
            );
        }

        $('.twitter-body .tweet:first-child .time').tooltip( {
            position: top
        });

        $('.twitter-body .tweet:first-child').data('data', tweet);
    });
}

function ReceivedTweet(data) {
    tweets = GetData('tweets');

    let identifier = GetData('myData').id;

    if (tweets == null) {
        tweets = new Array();
    }

    let tweet = {
        identifier: data.identifier,
        author: data.author,
        message: data.message,
        rawMessage: data.message,
        time: Date.now()
    }

    tweets.push(tweet);

    StoreData('tweets', tweets);

    var pattern = /\B@[a-z0-9_-]+/gi;
    let highlight = tweet.message.match(pattern);

    $.each(highlight, function(index2, mention) {
        tweet.message = tweet.message.replace(mention, `<span class="mention" data-mention="${mention.replace('@', '')}">${mention}</span>`);
    });

    pattern = /\B#[a-z0-9_-]+/gi;
    highlight = tweet.message.match(pattern);
    $.each(highlight, function(index2, hashtag) {
        tweet.message = tweet.message.replace(hashtag, `<span class="hashtag" data-hashtag="${hashtag.replace('#', '')}">${hashtag}</span>`);
    });
    if(identifier == tweet.identifier){
        $('.twitter-body').prepend(`
            <div class="tweet">
                <div class="avatar other-${tweet.author[0].toString().toLowerCase()}">${tweet.author[0]}</div>
                <div class="author">${tweet.author}</div>
                <div class="body">${tweet.message}</div>
                <div class="time" data-tooltip="${moment().format('MM/DD/YYYY')} ${moment().format('hh:mmA')}">${moment().fromNow()}</div>
                <div><i class="fas fa-trash-alt"></i></div>
            </div>`
        );
    }
   else{
        $('.twitter-body').prepend(`
            <div class="tweet">
                <div class="avatar other-${tweet.author[0].toString().toLowerCase()}">${tweet.author[0]}</div>
                <div class="author">${tweet.author}</div>
                <div class="body">${tweet.message}</div>
                <div class="time" data-tooltip="${moment().format('MM/DD/YYYY')} ${moment().format('hh:mmA')}">${moment().fromNow()}</div>
            </div>`
        );
    }

    $('.twitter-body .tweet:first-child .time').tooltip( {
        enterDelay: 0,
        exitDelay: 0,
        inDuration: 0,
    });

    $('.twitter-body .tweet:first-child').data('data', tweet);

    let muted = GetData('not');

    if(!muted){
        $('.twotterNotification').fadeIn();
        var text = tweet.message.substring(0,80)+'...';
        document.getElementById('piuNotID').innerHTML = "<a><i class='fab fa-twitter'></i> <b>@"+tweet.author+"</b><br>"+text+"</a>";
        setTimeout(function(){
            $(".twotterNotification").fadeOut();
        }, 8000);
    }
}

function RemoveTweets(data) {
    tweets = GetData('tweets');
    let identifier = GetData('myData').id;
    $.each(tweets, function(index, tweet) {
        if(identifier == tweet.identifier && data.author == tweet.author && data.message == tweet.rawMessage){
            tweets.splice(index);
        }
    });
    StoreData('tweets', tweets);
}