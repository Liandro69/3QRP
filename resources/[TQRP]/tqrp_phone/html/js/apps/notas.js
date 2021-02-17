$('.notas-list').on('click', '.note', function(event) {
    if ($(this).find('.note-actions').is(":visible")) {

        $(this).find('.note-actions').slideUp();
        $(this).find('.note-title-text').slideDown();
    } else {
        $(this).parent().find('.note-actions').slideUp();
        
        $(this).find('.note-actions').slideDown();
        $(this).find('.note-title-text').slideUp();
    }
});

function SetupNotasPage() {
	let notas = GetData('notas');

    if (notas == null) {
        notas = new Array();
    }

    notas.sort();

    $('.notas-list').html('');

    $.each(notas, function(index, nota) {
        $('.notas-list').prepend(`
            <div class="note">
                <div class="note-title"><b>${nota.title}</b></div>
                <div class="note-title-text">${nota.note}</div>
                <div class="note-actions" >${nota.note}
                <i class="fas fa-trash-alt" bId="${nota.id}" index="${index}"></i>
                </div>
            </div>`
        );
    });
}

$('.notas-list').on('click', '.fa-trash-alt', function(event) {
    $elem = $(this)
    let id = $elem.attr('bId');
    let index = $elem.attr('index');

    notas = GetData('notas');

    $.post(ROOT_ADDRESS + '/DeleteNote', JSON.stringify({
        id: id,
    }), function(status) {
        if (status == true) {
            $elem.parent().parent().fadeOut('normal', function() {
                $elem.parent().parent().remove();
            });

            notas.splice(index, 1);
            StoreData('notas', notas);

            M.toast({html: 'Apagado com sucesso'});
        }
        else{
            M.toast({html: 'Ocorreu um erro'});
        }
    })
});

$('#new-note').on('submit', function(e) {
    e.preventDefault();

    let data = $(this).serializeArray();
    let myIdentifier = GetData('myData').id;
    let title = data[0].value
    let text = data[1].value

    notas = GetData('notas');

    $.post(ROOT_ADDRESS + '/AddNote', JSON.stringify({
        title: title,
        text: text,
    }), function(status) {
        if (status == true) {
            let newNote = {
                identifier: myIdentifier,
                title: title,
                note: text,
            }

            var modal = M.Modal.getInstance($('#add-note-modal'));
            modal.close();
            $('#new-note-title').val('');
            $('#new-note-text').val('');

            $('.notas-list').prepend(`
                <div class="note">
                    <div class="note-title"><b>${title}</b></div>
                    <div class="note-title-text">${title}</div>
                    <div class="note-actions" >${text}
                        <i class="fas fa-trash-alt"></i>
                    </div>
                </div>`
            );


            notas.push(newNote);
            StoreData('notas', notas);
            M.toast({html: 'Adicionado com sucesso'});
        }
        else{
            M.toast({html: 'Ocorreu um erro'});
        }
    })

})