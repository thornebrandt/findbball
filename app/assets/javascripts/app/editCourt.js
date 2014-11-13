fbb.editCourt = function(){
    var isEditCourt = $("#editCourt").length;
    var initialize = function(){
        if(isEditCourt){
            DOMEvents();
            checkPickupGamesOnLoad();
        }
    }

    var DOMEvents = function(){
        $("body").on("change", ".selectCourtPickupTime, .selectCourtPickupAMPM, .selectCourtPickupDay", function(e){
            e.preventDefault();
            var container = $(e.target).parent();
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
            var pickupObj = {
                pickup_game: {
                    day: day,
                    time: _time,
                    court_id: gon.court.id,
                    member_id: gon.court.member_id
                }
            }
            if(_id){
                patchPickupGame( pickupObj, _id);
            }else{
                savePickupGame( pickupObj );
            }
        });

        $("body").on("click", ".deleteCourtPickup", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent();
            var id_el = container.find( $(".selectCourtPickupID") );
            var _id = parseInt(id_el.val());
            var hidePickupGame = function(response){
                container.fadeOut();
            }
            deletePickupGame(_id, hidePickupGame);
        });

    };

    var hidePickupGame = function(_el){
        _el.fadeOut();
    };

    var checkPickupGamesOnLoad = function(){
        $(".pickupGameCreateContainer").each(function(i, el){
            var time_el = $(el).find('.selectCourtPickupTime');
            var ampm_el = $(el).find('.selectCourtPickupAMPM');
            var _time = $(el).find(".selectCourtTime").val();
            var amPM = 0;
            var parsedTime = parseInt(_time);
            if(_time > 12 ){
                amPM = 12;
                parsedTime = parseInt(_time -12);
                _time = _time - 12;
            }
            time_el.val(parsedTime);
            ampm_el.val(amPM);
        });
    };


    var savePickupGame = function(_obj, callback){
        $.ajax({
            type: "POST",
            url: "/pickup_games",
            dataType: "json",
            data: _obj,
            success: function(response){
                callback(response);
            },
            error: function(error){
                console.log("error, yo");
                console.log(error);
            }
        });
    };

    var patchPickupGame = function(pickup_game_obj, _id){
        $.ajax({
            type: "PATCH",
            url: "/pickup_games/" + _id,
            dataType: "json",
            data: pickup_game_obj,
            success: function(response){
                console.log("we patched");
                console.log(response);
            },
            error: function(error){
                console.log("we errored");
                console.log(error);
            }
        });
    };

    var deletePickupGame = function(_id, _callback){
        $.ajax({
            url: "/pickup_games/" + _id,
            type: "post",
            dataType: "json",
            data: {"_method":"delete"},
            success: function(response){
                console.log("we deleted");
                _callback(response);
            },
            error: function(error){
                console.log("error on deletion");
                console.log(error);
            }
        });
    }

    initialize();
};