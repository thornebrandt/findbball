fbb.newCourt = function(){
    var isEditCourt = $("#editCourt").length;
    var initialize = function(){

        DOMEvents();
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
            data: _obj,
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

    var DOMEvents = function(){
        $("body").on("change", ".selectCourtPickupTime, .selectCourtPickupAMPM, .selectCourtPickupDay", function(e){
            e.preventDefault();
            var container = $(this).parent();
            var hours_el = container.find( $(".selectCourtPickupTime"));
            var minutes_el = container.find( $(".selectCourtPickupAMPM"));
            var day_el = container.find( $(".selectCourtPickupDay"));
            var time_el = container.find( $(".selectCourtTime"));
            var hours = parseFloat(hours_el.val());
            var minutes = parseFloat(minutes_el.val());
            var day = parseInt(day_el.val());
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
                console.log("about to pass:");
                console.log(pickupObj);
                savePickupGame( pickupObj );
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
