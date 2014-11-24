fbb.editCourt = function(){
    var $el = $("#courtEditForm");
    var isEditCourt = $el.length;
    var initialize = function(){
        if(isEditCourt){
            DOMEvents();
            checkPickupGamesOnLoad();
        }
    }

    var DOMEvents = function(){
        $el.on("change", ".selectCourtPickupTime, .selectCourtPickupAMPM, .selectCourtPickupDay", function(e){
            e.preventDefault();
            var container = $(e.target).parent();
            var save_btn = container.find( $(".saveCourtPickup") );
            console.log("yo fade this shit in holmes");
            save_btn.fadeIn();
        });

        $el.on("click", ".saveCourtPickup", function(e){
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
                    time: _time
                }
            }
            if(_id){
                patchPickupGame( pickupObj, _id);
            }else{
                pickupObj.pickup_game.court_id = gon.court.id;
                pickupObj.pickup_game.member_id = gon.court.member_id;
                createPickupGame( pickupObj, container);
            }
        });


        $el.on("click", ".deleteCourtPickup", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent();
            var id_el = container.find( $(".selectCourtPickupID") );
            var _id = parseInt(id_el.val());
            deletePickupGame(_id, container);
        });

    };


    var checkPickupGamesOnLoad = function(){
        $(".pickupGameCreateContainer").each(function(i, el){
            var time_el = $(el).find('.selectCourtPickupTime');
            var ampm_el = $(el).find('.selectCourtPickupAMPM');
            var _time = $(el).find(".selectCourtTime").val();
            var amPM = 0;
            var parsedTime = parseInt(_time);
            if(_time > 11 ){
                amPM = 12;
                parsedTime = parseInt(parseInt(_time) - 12);
                _time = _time - 12;
            }
            time_el.val(parsedTime);
            ampm_el.val(amPM);
        });
    };


    var createPickupGame = function(_obj, container){
        // var saveID = function(response){
        //     var _id = response.id;
        //     var id_el = container.find( $(".selectCourtPickupID"));
        //     id_el.val(_id);
        // }

        $.ajax({
            type: "POST",
            url: "/pickup_games",
            dataType: "json",
            data: _obj,
            success: function(response){
                reloadForm();
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
                reloadForm();

            },
            error: function(error){
                console.log("we errored");
                console.log(error);
            }
        });
    };

    var reloadForm = function(){
        var court_id = gon.court.id;
        var formReloaded = function(response){
            checkPickupGamesOnLoad();
            $(".best_in_place").best_in_place();
        };
        $('#courtEditForm').load('/courts/'+court_id+'/reload_edit_form', formReloaded);
        $(".saveCourtPickup").show();
    };

    var deletePickupGame = function(_id, container){
        var hidePickupGame = function(){
            container.fadeOut("300", function(){
                reloadForm();
            });
        };

        $.ajax({
            url: "/pickup_games/" + _id,
            type: "post",
            dataType: "json",
            data: {"_method":"delete"},
            success: function(response){
                hidePickupGame();
            },
            error: function(error){
                console.log("error on deletion");
                console.log(error);
            }
        });
    }

    initialize();
};