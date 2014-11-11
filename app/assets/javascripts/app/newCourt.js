fbb.newCourt = function(){
    var isEditCourt = $("#editCourt").length;
    var initialize = function(){
        DOMEvents();
        checkPickupGames();
    };

    var checkPickupGames = function(){
        $(".pickupGameCreateContainer").each(function(i, el){
            var time_el = $(el).find('.selectCourtPickupTime');
            var ampm_el = $(el).find('.selectCourtPickupAMPM');
            var _time = $(el).find(".selectCourtTime").val();
            var amPM = 0;
            var parsedTime = parseInt(_time);
            window.parsedTime = parsedTime;
            window.time_el = time_el;
            if(_time > 12 ){
                amPM = 12;
                parsedTime = parseInt(_time -12);
                _time = _time - 12;
            }
            console.log(parsedTime);
            time_el.val(parsedTime);
            ampm_el.val(amPM);
        });
    };

    var validatePickupGames = function(){
        console.log("ok");
        var selectedTimes = false;
        $(".selectCourtPickupDay").each(function(i, _target){
            if( $(_target).val() ){
                selectedTimes = true;
            }
        });
        if(selectedTimes){
            $("#pickupGameError").hide();
        } else {
            $("#pickupGameError").show();
        }
        return selectedTimes;
    };

    var savePickupGame = function(_obj){
        $.ajax({
            type: "POST",
            url: "/pickup_games",
            dataType: "json",
            data: JSON.stringify(_obj),
            success: function(response){
                console.log("success");
                console.log(response);
            },
            error: function(error){
                console.log("error, yo");
                console.log(error);
            }
        });
    };

    var patchPickupGame = function(_id, _obj){
        var _pickup_game = {
            time: _obj.pickup_game.time,
            day: _obj.pickup_game.day
        }
        console.log("but this");
        console.log(_pickup_game);
        var _data = { pickup_game: _pickup_game };
        $.ajax({
            type: "PATCH",
            url: "/pickup_games/" + _id,
            dataType: "json",
            data: _data,
            success: function(response){
                console.log("we patched");
                console.log(response);
            },
            error: function(error){
                console.log("we errored");
                console.log(error);
            }
        });
    }




    var DOMEvents = function(){
        $("body").on("change", ".selectCourtPickupTime, .selectCourtPickupAMPM, .selectCourtPickupDay", function(e){
            e.preventDefault();
            var container = $(this).parent();
            var hours_el = container.find( $(".selectCourtPickupTime"));
            var minutes_el = container.find( $(".selectCourtPickupAMPM"));
            var day_el = container.find( $(".selectCourtPickupDay"));
            var time_el = container.find( $(".selectCourtTime"));
            var id_el = container.find( $(".selectCourtPickupID"));
            var hours = parseFloat(hours_el.val());
            var minutes = parseFloat(minutes_el.val());
            var day = parseInt(day_el.val());
            var _id = parseInt(id_el.val());
            var _time = hours + minutes;
            time_el.val(_time);
            $("#pickupGameError").hide();
            if(isEditCourt){
                var pickupObj = {
                    pickup_game: {
                        day: day,
                        time: _time,
                        court_id: gon.court.id,
                        member_id: gon.court.member_id
                    }
                }
                if(_id){
                    patchPickupGame( _id, pickupObj );
                }else{
                    console.log( "nope, it's a new guy");
                }

                //savePickupGame( pickupObj );
            } else {
                console.log("not editing, but still placing the value");
            }
        });


        $("#submit_court").click(function(e){
            e.preventDefault();
            var newCourtForm = $("#new_court");
            fbb.validate.validateForm(newCourtForm);
            console.log("about to validate pickup games");
            var pickupGamesSelected = validatePickupGames();
            if( newCourtForm.valid() && pickupGamesSelected){
                newCourtForm.submit();
            }
        });

    };


    initialize();
}
