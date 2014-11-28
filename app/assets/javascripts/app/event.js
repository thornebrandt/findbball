fbb._event = function(){
    fbb.courtEvent = {};
    //var courtQuery = getQueryVariable

    var initialize = function(){
        if ( $("#addEvent_container").length ){
            prepareDatePicker();
            prepareTimePicker();
            prepareCourtAutoComplete();
            validateEventForm();
        }

        if( typeof gon === "object" && typeof gon.editEvent === "object" ){
            prepareEditValues();
        }
    };


    var prepareEditValues = function(){
        // mind the utc...
        var _start = moment.utc(gon.editEvent.start);
        var _end = moment.utc(gon.editEvent.end);
        var _diff = fbb.time.differenceHours( _end, _start );
        $("#event_duration").val(_diff);
        $("#start_time").val( _start.format("h") );
        if ( _start.format("A") === "PM") {
            $("#start_ampm").val(12);
        } else {
            $("#start_ampm").val(0);
        }
        fbb.courtEvent.start_date = _start.format("YYYY-M-D");
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
            hint: false
        },
        {
            source: results.ttAdapter(),
            displayKey: "name"
        });

        $("#court_search").on("typeahead:selected", courtSelectionHandler);

        $("#court_search").focus(function(e){
            $("#courtNotFound").hide();
        });

        $("#re_search_court").click( courtReSearchHandler );

        if(gon.court){
            courtSelectionHandler(null, gon.court);
        }
    };

    var courtReSearchHandler = function(e){
        e.preventDefault();
        $(".court_display").hide();
        $(".court_search").show();
        $("#court_search").focus();
        $("#court_search").val("");
        $("#realCourtID").val("");
        $('#court_search').typeahead("val", "");
        hideCourtMap();
    };

    var courtSelectionHandler = function(obj, datum){
        var court_id = datum.id;
        var court_name = datum.name;
        loadCourt(datum);
        $("#realCourtID").val(court_id);
        $(".court_display").show();
        $("#court_display").text(court_name);
        $("#court_display").attr("href", "/courts/" + court_id);
        $(".court_search").hide();
        // $("#court_search").blur();
    }

    var loadCourt = function(_court){
        gon.lat = _court.lat;
        gon.lng = _court.lng;
        showCourtMap();
        fbb.checkForMap();
    };

    var showCourtMap = function(){
        $("#add_event_map").css("height", "200px");
    };

    var hideCourtMap = function(){
        $("#add_event_map").css("height", "0px");
    };


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
        } else {
            console.log( "nothing to work with here" );
        }
    };

    var calculateStartTime = function(){
        var timeInt = parseInt($("#start_time").val()) + parseInt( $("#start_ampm").val() );
        var timeString = timeInt + ":00";
        return timeString;
    };

    var datePickerOptions = {
        changeMonth: true,
        changeYear: false,
        dateFormat: 'MM dd',
        duration: 'fast',
        showButtonPanel: true,
        onSelect: selectStartDate,
        beforeShow: function(){
            $(".ui-datepicker").removeClass("hide");
        }
    };

    var blurEvents = function(){
        $("input").blur(function(){
            if ( !$("#realStart").val() ){
                $("#event_datepicker").val("");
            }
        });

    };

    var validateEventForm = function(){
        var $_form = $("#new_event");
        if( $_form.length === 0 ){
            $_form = $(".edit_event");
        }

        blurEvents();

        fbb.validate.validateForm($_form);
        $("#submit_event").click(function(e){
            e.preventDefault();
            //validate court
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
            calculateDates();
        });
    };


    initialize();

};