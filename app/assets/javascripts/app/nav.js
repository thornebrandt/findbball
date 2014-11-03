fbb.nav = function(){
    var helpBtns = $("#help, #howItWorks");
    var howItWorksModal = $("#howItWorksModal");
    var loginBtn = $(".loginBtn");
    var loginModal = $("#loginModal");
    fbb.modal(helpBtns, howItWorksModal);
    fbb.modal(loginBtn, loginModal);
    var queryString = window.location.search;
    var queryResult = getQueryVariable(queryString, "login");
    if(queryResult){
        var modalOptions = {
            "backdrop" : true,
            "keyboard" : true
        }
        loginModal.modal(modalOptions);
        loginModal.modal('show');
    }

    function initialize(){
        setupNavSearch();
        memberSearchAutoComplete();
        findHoopsGeoComplete( $("#location_search") );
        DOM();
    };

    var DOM = function(){
        $(".noLink").click(function(e){
            e.preventDefault();
        });
    };

    var findHoopsGeoComplete = function(_input){
        var map = new google.maps.Map(document.getElementById("noMap"));
        if (_input.length){
            _input.geocomplete()
            .bind("geocode:result", findHoopsSuccessHandler)
            .bind("geocodeLerror", function(event, result){
                console.log(event);
                console.log(result);
            });
        }
    };

    var findHoopsSuccessHandler = function(event, result){
        var lat = result.geometry.location.k;
        var lng = result.geometry.location.B;
        var searchURL = $("#i_want_to").val();
        var _url = "/"+searchURL+"?lat=" + lat + "&lng=" + lng
        //var _url = "/find-hoops?by=" + result.formatted_address
        var _within = $("#within").val();
        if (_within){
            _url += "&within=" + _within;
        }
        window.location = _url;
    };


    function memberSearchAutoComplete(){
        var results = new Bloodhound({
            datumTokenizer: function(data){
                console.log("datum");
                return Bloodhound.tokenizers.whitespace(data.name)
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            limit: 12,
            remote: "/search_members?q=%QUERY"
        });

        results.initialize();


        $("#member_search").typeahead({
            hint: true,
            highlight: true,
        },
        {
            source: results.ttAdapter(),
            displayKey: "name"
        });


        $("#member_search").on("typeahead:selected", memberSelectionHandler);
    };

    function memberSelectionHandler(obj, datum){
        console.log("member selected");
        window.location = "/members/" + datum.id;
    };


    function setupNavSearch(){
        $("#member_search").hide();

        $("#i_want_to").change(
            function() {
                var thisVal = $(this).val();
                switch (thisVal) {
                    case "find-members":
                        $("#distance").hide();
                        $("#member_search").show();
                        $("#member_search").focus();
                        break;
                    default:
                        $("#member_search").hide();
                        $("#distance").show();
                }
            }
        );
    }


    initialize();
}
