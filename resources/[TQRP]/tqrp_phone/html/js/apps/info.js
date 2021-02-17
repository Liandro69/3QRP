function SetupInfoPage() {
    $.post(ROOT_ADDRESS + '/UpdateInfo', JSON.stringify({}));

    setTimeout(function() {
        
        let firstname = GetData('firstname');
        let lastname = GetData('lastname');
        let myNumber = GetData('myNumber');

        let money = GetData('money');
        let bank = GetData('bank');

        let job = GetData('job');

        $('.info-list').html('');

        $('.info-list').prepend(`
            <div class="entry">
                <div class="entry-title"><b>Trabalho</b></div>
                <div class="entry-title-text">${job}</div>
            </div>`
        );
        
        $('.info-list').prepend(`
            <div class="entry">
                <div class="entry-title"><b>Dinheiro na carteira</b></div>
                <div class="entry-title-text">${money}€</div>
            </div>`
        );

        $('.info-list').prepend(`
            <div class="entry">
                <div class="entry-title"><b>Dinheiro no banco</b></div>
                <div class="entry-title-text">${bank}€</div>
            </div>`
        );

        $('.info-list').prepend(`
            <div class="entry">
                <div class="entry-title"><b>Número de telemóvel</b></div>
                <div class="entry-title-text">${myNumber}</div>
            </div>`
        );

        $('.info-list').prepend(`
            <div class="entry">
                <div class="entry-title"><b>Nome</b></div>
                <div class="entry-title-text">${firstname} ${lastname}</div>
            </div>`
        );


    }, 300);
}