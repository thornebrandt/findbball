fbb.newCourt = function(){
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


    var setupPickupGameCreation = function(e){
        var container = $(e.target).parent();
        var hours_el = container.find( $(".selectCourtPickupTime"));
        var minutes_el = container.find( $(".selectCourtPickupAMPM"));
        var time_el = container.find( $(".selectCourtTime"));
        var error_el = $("#pickupGameError");
        var hours = parseFloat(hours_el.val());
        var minutes = parseFloat(minutes_el.val());
        var _time = hours + minutes;
        time_el.val(_time);
        error_el.hide();
    };



    var DOMEvents = function(){
        $("body").on("change", ".selectCourtPickupTime, .selectCourtPickupAMPM, .selectCourtPickupDay", function(e){
            e.preventDefault();
            setupPickupGameCreation(e);
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
