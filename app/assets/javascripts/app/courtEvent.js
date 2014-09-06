fbb.courtEvent = function(){
    fbb.courtEvent = {};

    var initialize = function(){
        if ( $("#addEvent_container").length ){
            prepareDatePicker();
            validateEventForm();
        }
    };

    var selectStartDate = function(e, d){
        fbb.courtEvent.start_date = fbb.time.datePickerToISO(d);
    };


    var datePickerOptions = {
        changeMonth: false,
        changeYear: false,
        dateFormat: 'MM dd',
        showButtonPanel: true,
        onSelect: selectStartDate
    };



    var validateEventForm = function(){
        var $_form = $("#new_event");
        fbb.validate.validateForm($_form);
        $("#submit_court").click(function(e){
            e.preventDefault();
            //console.log("submit");
            if($("#new_event").valid()){
                console.log("Valid");
            }
        });
    };


    var prepareDatePicker = function(){
        $("#event_datepicker").datepicker( datePickerOptions );
    };

    initialize();

};