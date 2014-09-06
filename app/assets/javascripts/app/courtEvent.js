fbb.courtEvent = function(){
    var datePickerOptions = {
        changeMonth: false,
        changeYear: false,
        dateFormat: 'MM dd',
        showButtonPanel: true,
        onSelect: function(e, d){
            console.log("seleected?");
            console.log(e);
            console.log( $(d).datepicker('getDate'));
            //console.log(d.getDate() );
        }
    }


    var initialize = function(){
        if ( $("#addEvent_container").length ){
            prepareDatePicker();
        }
    };

    var prepareDatePicker = function(){
        $("#event_datepicker").datepicker( datePickerOptions );
    }

    initialize();

};