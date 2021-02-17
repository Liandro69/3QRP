$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    function display2(bool) {
        if (bool) {
            $("#container2").show();
        } else {
            $("#container2").hide();
        }
    }

    display2(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        } else  if (item.type === "ui2") {
            if (item.status == true) {
                display2(true)
            } else {
                display2(false)
            }
        }
    })
    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://tqrp_headlights/exit', JSON.stringify({}));
            return
        }
    };
    
    $("#b-1").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '-1'
        }));
        return
    })
    $("#b1").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '1'
        }));
        return
    })
    $("#b2").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '2'
        }));
        return
    })
    $("#b3").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '3'
        }));
        return
    })
    $("#b4").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '4'
        }));
        return
    })
    $("#b5").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '5'
        }));
        return
    })
    $("#b6").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '6'
        }));
        return
    })
    $("#b7").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '7'
        }));
        return
    })
    $("#b8").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '8'
        }));
        return
    })
    $("#b9").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '9'
        }));
        return
    })
    $("#b10").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '10'
        }));
        return
    })
    $("#b11").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '11'
        }));
        return
    })
    $("#b12").click(function () {
        $.post('http://tqrp_headlights/setcolor', JSON.stringify({
            color: '12'
        }));
        return
    })

    $("#n-1").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '222', g: '222', b: '222'
        }));
        return
    })
    $("#n1").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '2', g: '21', b: '255'
        }));
        return
    })
    $("#n2").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '3', g: '83', b: '255'
        }));
        return
    })
    $("#n3").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '0', g: '255', b: '140'
        }));
        return
    })
    $("#n4").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '94', g: '255', b: '1'
        }));
        return
    })
    $("#n5").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '255', g: '255', b: '0'
        }));
        return
    })
    $("#n6").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '255', g: '150', b: '0'
        }));
        return
    })
    $("#n7").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '255', g: '62', b: '0'
        }));
        return
    })
    $("#n8").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '255', g: '1', b: '1'
        }));
        return
    })
    $("#n9").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '255', g: '50', b: '100'
        }));
        return
    })
    $("#n10").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '255', g: '161', b: '211'
        }));
        return
    })
    $("#n11").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '35', g: '1', b: '255'
        }));
        return
    })
    $("#n12").click(function () {
        $.post('http://tqrp_headlights/setcolor2', JSON.stringify({
            r: '15', g: '3', b: '255'
        }));
        return
    })
})
