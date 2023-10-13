
window.addEventListener("message", function (event) {
    let data = event.data;
 

   
    
    if (data.type == 'TOGGLE_HUD') {
        

            if (data.value == true) { //off
                $('.hudContainer').animate({"bottom": '-6vh'}, 500)
                $('.carhud').animate({"right": '-40vh'}, 500)

                
            } else if (data.value == false) {
                $('.hudContainer').animate({"bottom": '1vh'}, 500)
                $('.carhud').animate({"right": '1vh'}, 500)
                

               
            }
 
        
    }

    if (data.type == 'TOGGLE_CARHUD') {
        if (data.invehicle) {
            
            $('.carhud').fadeIn();
        } else  {
            $('.carhud').fadeOut();
        }
    }
    if (data.type == 'UPDATE_CARHUD') {
        if(data.speed) {
            if(data.speed == 1){
                $('#direction').html(event.data.direction)
                $('#street').html(event.data.street)
                $('#predkosc-text').html(0 + " KMH");
                return
            }
            let predkosc = data.speed - 1 
            $('#predkosc-text').html(` ${predkosc} KMH`);
        }
    }
    if(data.type = 'talking') {
        if (data.talking == 1) {
            $('#talking').css('filter', 'brightness(0.75)');
        } else if (data.talking == false) {
            $('#talking').css('filter', 'brightness(1)');
        }
        if (data.proximity) {
            $('#talking').css('background', 'linear-gradient(to top, rgb(196, 190, 190) '+data.proximity/3 * 100+'%, rgb(255, 255, 255) 0%)');
            $('#talking').css('-webkit-text-fill-color', 'transparent');
            $('#talking').css('-webkit-background-clip', 'text');
        } 


    }
    if (data.type = 'UPDATE_HUD') {

        if (data.hour || data.minute) {
            $('#time-text').html(data.hour + ':' + data.minute);
            if (data.hour < 5 || data.hour > 21) {
                $('#time-parent').html('<i class="fa-regular fa-clock icon-text" id="time"></i><span class="hud-text" id="time-text">'+ data.hour + ':' + data.minute + '</span>');
            } else if (data.hour >= 5 || data.hour <= 21) {
                $('#time-parent').html('<i class="fa-regular fa-clock icon-text" id="time"></i><span class="hud-text" id="time-text">'+ data.hour + ':' + data.minute + '</span>');
            }
        }

        if (data.hp || data.hp == 0) {
            $('#hp').css('background', 'linear-gradient(to top, rgb(209, 0, 31) '+data.hp+'%, rgb(255, 255, 255) 0%)');
            $('#hp').css('-webkit-text-fill-color', 'transparent');
            $('#hp').css('-webkit-background-clip', 'text');
        }

        if (data.armour || data.armour == false) {
            if (data.armour) {
                $('#armour-parent').fadeIn();
                $('#kreska1').fadeIn();
                $('#armour').css('background', 'linear-gradient(to top, rgb(10, 89, 199) '+data.armour+'%, rgb(255, 255, 255) 0%)');
                $('#armour').css('-webkit-text-fill-color', 'transparent');
                $('#armour').css('-webkit-background-clip', 'text');
            } else if (data.armour == false) {
                $('#armour-parent').fadeOut();
                $('#kreska1').fadeOut();
            }
        } 

        if (data.hunger) {
            $('#hunger').css('background', 'linear-gradient(to top, rgb(130, 83, 39) '+data.hunger+'%, rgb(255, 255, 255) 0%)');
            $('#hunger').css('-webkit-text-fill-color', 'transparent');
            $('#hunger').css('-webkit-background-clip', 'text');
        } 
        
        if (data.thirst) {
            $('#thirst').css('background', 'linear-gradient(to top, rgb(8, 135, 204) '+data.thirst+'%, rgb(255, 255, 255) 0%)');
            $('#thirst').css('-webkit-text-fill-color', 'transparent');
            $('#thirst').css('-webkit-background-clip', 'text');
        } 

        if (data.oxygen) {
            if (data.oxygen < 100) {
                $('#oxygen-parent').fadeIn();
                $('#kreska2').fadeIn();
                $('#oxygen').css('background', 'linear-gradient(to top, rgb(115, 143, 235) '+data.oxygen+'%, rgb(255, 255, 255) 0%)');
                $('#oxygen').css('-webkit-text-fill-color', 'transparent');
                $('#oxygen').css('-webkit-background-clip', 'text');
            } else {
                $('#oxygen-parent').fadeOut();
                $('#kreska2').fadeOut();
            }
        } 

        // if (data.run) {
        //     if (data.run < 100) {
        //         $('#run-parent').fadeIn();
        //         $('#run').css('background', 'linear-gradient(to top, rgb(0, 0, 0) '+data.run+'%, rgb(255, 255, 255) 0%)');
        //         $('#run').css('-webkit-text-fill-color', 'transparent');
        //         $('#run').css('-webkit-background-clip', 'text');
        //     } else {
        //         $('#run-parent').fadeIn();
        //     }
        // } 

        // if (data.radio == false || data.radio == true) {
        //     if (data.radio == true) {
        //         $('#talking').removeClass('fa-volume-high');
        //         $('#talking').addClass('fa-walkie-talkie');
        //         // $('#talking-parent').html('<i class="fa-solid fa-walkie-talkie icon" id="talking"></i>');
        //     } else {
        //         $('#talking').addClass('fa-volume-high')
        //         $('#talking').removeClass('fa-walkie-talkie')
        //         // $('#talking-parent').html('<i class="fa-solid fa-volume-high icon" id="talking"></i>');
        //     }
        // }
    }
})

const updateDigits = (_value, type) => {
    const length =  type === "speed" ? 3
                    : type === "id" ? 4
                    : 5; // index
    const value = _value.toString().padStart(length, "0");

    for (let i = 0; i < length; i++) {
        $(`#${type}-digit-${i + 1}`).html(value[i]);
    }

    $(`.zero-${type}`).removeClass(`zero-${type}`);

    for (let i = 0; i < length; i++) {
        if (value[i] != 0) {
            break;
        }

        $(`#${type}-digit-${i + 1}`).addClass(`zero-${type}`);
    }
}

function updatePlayerId(playerId, userId) {
    // $('#player-id').html(playerId);
    updateDigits(playerId, "id");
}


window.addEventListener('message', (event) => {
    const data = event.data
    switch (data.action) {


        case "updatePlayerId":
            updatePlayerId(data.id, data.index)
            break;

    }
});

