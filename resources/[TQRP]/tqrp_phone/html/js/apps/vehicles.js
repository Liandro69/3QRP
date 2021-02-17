function UpdateVehicle(data) {
    let cars = GetData('cars');
    $.each(cars, function(index, car) {
        if(car.plate.replace(/\s+/g, '') == data.plate.replace(/\s+/g, '')){
            car.x = data.x
            car.y = data.y
            car.z = data.z
            car.h = data.h
            car.health = data.health
            car.garage = data.garage
            car.vehicle = data.vehicle
        }
    });

    StoreData('cars', cars);
}

function SetupCarsPage() {
    let cars = GetData('cars');


    if (cars == null) {
        cars = new Array();
    }

    $('.cars-list').html('');
    

    $.each(cars, function(index, car) {
        $('.cars-list').prepend(`
            <div class="car">
                <div class="car-title"><b>${car.vehicle_name}</b></div>
                <div class="car-title-text">${car.plate}</div>
                <div class="car-actions" >
       <!--             <i class="fas fa-key" data-tooltip="Dar chave"></i>
                    <i class="fas fa-unlink" data-tooltip="Remover todas as chaves"></i> -->
                    <i class="fas fa-search-location" data-tooltip="Localizar veículo"></i> 
                    <i class="fas fa-car" data-tooltip="Pedir veículo"></i>
                </div>
            </div>`
        );

        $('.cars-list .car:first-child .fa-key').tooltip( {
            position: top
        });
        $('.cars-list .car:first-child .fa-unlink').tooltip( {
            position: top
        });
        $('.cars-list .car:first-child .fa-search-location').tooltip( {
            position: top
        });
        $('.cars-list .car:first-child .fa-car').tooltip( {
            position: top
        });


        $('.cars-list .car:first-child').data('data', car);
    });
}

$('.cars-list').on('click', '.car', function(event) {
    if ($(this).find('.car-actions').is(":visible")) {
        $(this).find('.car-actions').slideUp();
    } else {
        $(this).parent().find('.car-actions').slideUp();
        $(this).find('.car-actions').slideDown();
    }
});

$('.cars-list').on('click', '.fa-key', function(event) {
    let $elem = $(this)
    let data = $elem.parent().parent().data('data');
    
    $.post(ROOT_ADDRESS + '/GiveCarKey', JSON.stringify({
        plate: data.plate,
    }), function(status) {
        if (status == true) {
            M.toast({html: 'Dado com sucesso'});
        }
        else{
            M.toast({html: 'Ninguém nas proximidades'});
        }
    })
});

$('.cars-list').on('click', '.fa-unlink', function(event) {
    let $elem = $(this)
    let data = $elem.parent().parent().data('data');
    
    $.post(ROOT_ADDRESS + '/RemoveAllCarKey', JSON.stringify({
        plate: data.plate,
    }), function(status) {
        if (status == true) {
            M.toast({html: 'Removido com sucesso'});
        }
        else{
            M.toast({html: 'Ninguém nas proximidades'});
        }
    })
});

$('.cars-list').on('click', '.fa-search-location', function(event) {
    let $elem = $(this)
    let data = $elem.parent().parent().data('data');
    let state = data.state
    if (data.x != 0 && data.y != 0 && data.z != 0){
        if(state == 2){
            M.toast({html: 'O veículo está dentro da garagem'});
        }
        else if(state == 3){
            M.toast({html: 'O veículo está nos apreendidos (Paga o que deves)'});
        }
        else if(state == 0 || state == 1  || data.garage == 'OUT'){
            $.post(ROOT_ADDRESS + '/VehiclePos', JSON.stringify({data: data}));
            M.toast({html: 'Localização adicionada no mapa'});
        }
    }
    else{
        M.toast({html: 'Impossível localizar'});
    }
});

$('.cars-list').on('click', '.fa-car', function(event) {
    let $elem = $(this)
    let data = $elem.parent().parent().data('data');
    let state = data.state
    
    if(state == 2){
        M.toast({html: 'O veículo está dentro da garagem'});
    }
    else if(state == 3){
        M.toast({html: 'O veículo está nos apreendidos (Paga o que deves)'});
    }
    else if(state == 0 || state == 1  || data.garage == 'OUT'){
        $.post(ROOT_ADDRESS + '/SpawnCar', JSON.stringify({data: data}));
    }
});

function UpdateVehicleState(data) {
    let cars = GetData('cars');
    $.each(cars, function(index, car) {
        if(car.plate.replace(/\s+/g, '') == data.plate.replace(/\s+/g, '')){
            car.state = data.state
        }
    });
    
    StoreData('cars', cars);
}