var myNumber = null;
var contacts = null;
var messages = null;

$('.convo-top-bar').on('click', '.convo-action-addcontact', function(e) {
    let data = $('#message-convo-container').data('data');
    $('#convo-add-contact-number').val(data.number);
});

$('.convo-action-call').on('click', function(e) {
    let data = $('#message-convo-container').data('data');

    CreateCall(data.number, false, false);
})

$('#convo-add-contact').on('submit', function(e) {
    e.preventDefault();

    let data = $(this).serializeArray();

    let name = data[0].value;
    let number = data[1].value;

    $.post(ROOT_ADDRESS + '/CreateContact', JSON.stringify({
        name: name,
        number: number,
    }), function(status) {
        if (status) {
            let contacts = GetData('contacts');

            if (contacts == null) {
                contacts = new Array();
            }

            contacts.push({ name: name, number: number, index: contacts.length });
            StoreData('contacts', contacts);

            var modal = M.Modal.getInstance($('#convo-add-contact-modal'));
            modal.close();

            $('#convo-add-contact-name').val('');
            $('#convo-add-contact-number').val('000000000');

            M.toast({html: 'Contacto adicionado'});
            RefreshApp();
        } else {
            M.toast({html: 'Ocorreu um erro'});
        }
    });
})

$('#convo-new-text').on('submit', function(e) {
    e.preventDefault();
    let convoData = $('#message-convo-container').data('data');
    let data = $(this).serializeArray();
    
    let text = [
        {
            value: convoData.number,
        },
        {
            value: data[0].value
        }
    ]

    SendNewText(text, function(sent) {
        if (sent) {
            $('.convo-texts-list').append('<div class="text me-sender"><span>' + data[0].value + '</span><p>' + moment(Date.now()).fromNow() + '</p></div>');

        
            M.toast({html: 'Mensagem enviada'});
            
            $('#convo-input').val('');


            if ($(".convo-texts-list .text:last-child").offset() != null) {
                $(".convo-texts-list").animate({
                    scrollTop: $('.convo-texts-list')[0].scrollHeight - $('.convo-texts-list')[0].clientHeight
                }, 200);
            }
        }
    });
});

$('#convo-delete-all').on('click', function(e) {
    e.preventDefault();
    let convoData = $('#message-convo-container').data('data');
    
    $.post(ROOT_ADDRESS + '/DeleteConversation', JSON.stringify({
        number: convoData.number
    }), function(status) {
        if (status) {
            let cleanedMsgs = messages.filter(m => (m.sender != convoData.number) && (m.receiver != convoData.number));
            StoreData('messages', cleanedMsgs);
            M.toast({html: 'Conversa apagada'});
            GoBack();
        } else {
            M.toast({html: 'Ocorreu um erro'});
        }
    });
});

function ReceiveText(data) {
    let viewingConvo = $('#message-convo-container').data('data');
    
    if (viewingConvo != null) {
        let contact = contacts.filter(c => c.number == viewingConvo.number)[0];
        if (viewingConvo.number == data.sender) {
            if (contact != null) {
                $('.convo-texts-list').append('<div class="text other-sender"><span class=" other-' + contact.name[0] + '">' + data.message + '</span><p>' + moment(Date.now()).fromNow() + '</p></div>')
            } else {
                $('.convo-texts-list').append('<div class="text other-sender"><span>' + data.message + '</span><p>' + moment(Date.now()).fromNow() + '</p></div>')
            }

            if ($(".convo-texts-list .text:last-child").offset() != null) {
                $(".convo-texts-list").animate({
                    scrollTop: $('.convo-texts-list')[0].scrollHeight - $('.convo-texts-list')[0].clientHeight
                }, 200);
            }          
        }
    }
    //else{
    //    var apps = GetData('apps');
    //    $.each(apps, function(index, app) {
    //        if(app.name == 'Mensagens'){
    //            app.unread = app.unread + 1
    //        }
    //    });
    //    StoreData('apps', apps);
    //}
    
    if (messages == null) {
        messages = GetData('messages');
    }

    if (myNumber == null) {
        myNumber = GetData('myData').phone;
    }

    messages.push({
        sender: data.sender,
        receiver: myNumber,
        message: data.message,
        sent_time: new Date(),
        sender_read: 0,
        receiver_read: 0
    });

    StoreData('messages', messages);
}

function SetupConvo(data) {
    myNumber = GetData('myData').phone;
    contacts = GetData('contacts');
    messages = GetData('messages');

    $('#message-convo-container').data('data', data);

    let texts = messages.filter(c => c.sender == data.number && c.receiver == myNumber || c.sender == myNumber && c.receiver == data.number);
    let contact = contacts.filter(c => c.number == data.number)[0];
        
    if (contact != null) {
        $('.convo-action-addcontact').hide();
        $('.convo-top-number').html(contact.name);
        $('.convo-top-bar').attr('class', 'convo-top-bar other-' + contact.name[0]);
    } else {
        $('.convo-action-addcontact').show();
        $('.convo-top-number').html(data.number);
    }
    
    $('.convo-texts-list').html('');
    $.each(texts, function(index, text) {
        var d = new Date(text.sent_time);
        
        if (text.sender == myNumber) {
            if (text.message.indexOf("https://i.imgur") >= 0){
                $('.convo-texts-list').append('<div class="text me-sender" style="background-image: url(' + text.message + ');background-repeat: no-repeat;background-position: center center; width: 80%;min-height: 50%;background-size: contain;"><p>' + moment(d).fromNow() + '</p></div>');
            }
            else{
                $('.convo-texts-list').append('<div class="text me-sender" style="background-image: url(' + text.message + ');background-repeat: no-repeat;background-position: center center;background-size: contain;"><span>' + text.message + '</span><p>' + moment(d).fromNow() + '</p></div>');
            }

            // Just incase losers wanna send themselves a text
            if (text.receiver == myNumber) {
                if (contact != null) {
                    $('.convo-texts-list').append('<div class="text other-sender"><span class=" other-' + contact.name[0] + '">' + text.message + '</span><p>' + moment(d).fromNow() + '</p></div>')
                } else {
                    $('.convo-texts-list').append('<div class="text other-sender"><span>' + text.message + '</span><p>' + moment(d).fromNow() + '</p></div>')
                }
            }
        } else {
 
            if (contact != null) {
                if (text.message.indexOf("https://i.imgur") >= 0){
                    $('.convo-texts-list').append('<div class="text other-sender" style="background-image: url(' + text.message + ');background-repeat: no-repeat;background-position: center center; width: 80%;min-height: 50%;background-size: contain;"><p>' + moment(d).fromNow() + '</p></div>')
                }
                else{
                    $('.convo-texts-list').append('<div class="text other-sender"><span class=" other-' + contact.name[0] + '">' + text.message + '</span><p>' + moment(d).fromNow() + '</p></div>')
                }
                //$('.convo-texts-list').append('<div class="text other-sender"><span class=" other-' + contact.name[0] + '">' + text.message + '</span><p>' + moment(d).fromNow() + '</p></div>')
            } else {
                if (text.message.indexOf("https://i.imgur") >= 0){
                    $('.convo-texts-list').append('<div class="text other-sender" style="background-image: url(' + text.message + ');background-repeat: no-repeat;background-position: center center; width: 80%;min-height: 50%;background-size: contain;"><p>' + moment(d).fromNow() + '</p></div>')
                            }
                else{
                    $('.convo-texts-list').append('<div class="text other-sender"><span>' + text.message + '</span><p>' + moment(d).fromNow() + '</p></div>')
                }
                //$('.convo-texts-list').append('<div class="text other-sender"><span>' + text.message + '</span><p>' + moment(d).fromNow() + '</p></div>')
            }
        }
    });

    if ($(".convo-texts-list .text:last-child").offset() != null) {
        $('.convo-texts-list').animate({
            scrollTop: $(".convo-texts-list .text:last-child").offset().top
        }, 25);
    }
}

function CloseConvo() {
    myNumber = null;
    contacts = null;
    messages = null;
    $('#message-convo-container').removeData('data');
    $('.convo-texts-list').html('');
    $('.convo-top-bar').attr('class', 'convo-top-bar');
}