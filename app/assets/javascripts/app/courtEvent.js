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

        $("#court_search").on("typeahead:selected", courtSelectionHandler);

        $("#court_search").focus(function(e){
            $("#courtNotFound").hide();
        });

    };

    var courtSelectionHandler = function(obj, datum){
        console.log("court selected");
        var court_id = datum.id;
        $("#realCourtID").val(court_id);
        $("#court_search").blur();
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
            console.log("start_date_iso");
            console.log(start_date_iso);
            console.log("end_date_iso");
            console.log(end_date_iso);
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
        if( $_form.length === 0 ){
            $_form = $(".edit_event");
        }
        fbb.validate.validateForm($_form);
        $("#submit_event").click(function(e){
            e.preventDefault();
            var courtFound = false;
            if ( $("#realCourtID").val() ){
                console.log("court found");
                courtFound = true;
            } else {
                $("#courtNotFound").fadeIn();
            }
            if($_form.valid() && courtFound){
                console.log("Valid");
                $_form.submit();
            }
        });
    };


    var prepareDatePicker = function(){
        $("#event_datepicker").datepicker( datePickerOptions );
    };

    var prepareTimePicker = function(){
        $("select").change(function(e){
            console.log("change??");
            calculateDates();
        });
    };


    initialize();

};