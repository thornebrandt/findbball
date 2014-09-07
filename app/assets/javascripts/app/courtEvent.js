fbb.courtEvent = function(){
    fbb.courtEvent = {};

    var initialize = function(){
        if ( $("#addEvent_container").length ){
            prepareDatePicker();
            prepareTimePicker();
            prepareCourtAutoComplete();
            validateEventForm();
        }
    };

    var prepareCourtAutoComplete = function(){
        var results = new Bloodhound({
            datumTokenizer: function(data){
                return Bloodhound.tokenizers.whitespace(data.name)
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            local: fbb.fakeCourts,
            limit: 12,
            remote: "/search_courts?q=%QUERY"
        });
        results.initialize();

        $("#court_search").typeahead({
            hint: true,
            highlight: true,
        },
        {
            source: results.ttAdapter(),
            displayKey: "name"
        });

        $("#court_search.typeahead").unbind("typeahead:selected");
        $("#court_search.typeahead").on("typeahead:selected", courtSelectionHandler);

    };

    var courtSelectionHandler = function(obj, datum){
        console.log("court selected");
        console.log(obj);
        console.log(datum);
    }


    var selectStartDate = function(e, d){
        fbb.courtEvent.start_date = fbb.time.datePickerToISO(d);
        calculateDates();
    };


    var calculateDates = function(){
        var start_time = calculateStartTime();
        if(typeof fbb.courtEvent.start_date !== "undefined"){
            var start_date_time = fbb.courtEvent.start_date + " " + start_time;
            var start_date_iso = fbb.time.stringToISO(start_date_time);
            var duration = $("#event_duration").val();
            var end_date_iso = fbb.time.addHours(start_date_iso, duration);
            var $_start = $("#realStart");
            var $_end = $("#realEnd");
            $_start.val(start_date_iso);
            $_end.val(end_date_iso);
        }
    };


    var calculateStartTime = function(){
        var timeInt = parseInt($("#start_time").val()) + parseInt( $("#start_ampm").val() );
        var timeString = timeInt + ":00";
        return timeString;
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
            // e.preventDefault();
            // //console.log("submit");
            // if($("#new_event").valid()){
            //     console.log("Valid");
            // }
        });
    };


    var prepareDatePicker = function(){
        $("#event_datepicker").datepicker( datePickerOptions );
    };

    var prepareTimePicker = function(){
        $("#changeTime").change(function(e){
            calculateDates();
        });
    };


    initialize();

};