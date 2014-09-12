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
        memberSearchAutoCorrect();
        findHoopsGeoComplete( $("#location_search") );
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
        console.log(result.k);
        var lat = result.geometry.location.k;
        var lng = result.geometry.location.B;
        //var _url = "/find-hoops?by=["+lat+","+lng+"]"
        var _url = "/find-hoops?by=" + result.formatted_address
        var _within = $("#within").val();
        if (_within){
            _url += "&within=" + _within;
        }
        window.location = _url;
    };


    // var navFindHoopsGeoComplete = function(_input){
    //     $_addressInput = _input;
    //     if( $("#address_search").length ){
    //         $("#address_search").geocomplete({
    //             map: ".mapEl",
    //             location: new google.maps.LatLng(self.mapObj.lat, self.mapObj.lng),
    //             mapOptions: {
    //                 zoom: 15,
    //                 scrollwheel: false,
    //                 mapTypeId: "roadmap"
    //             },
    //             markerOptions: {
    //                 draggable: true,
    //                 icon: icon_path
    //             }
    //         })
    //         .bind("geocode:result", courtSearchSuccessHandler)
    //         .bind("geocode:dragged", courtSearchDraggedHandler)
    //         .bind("geocode:error", function(event, result){
    //             console.log(event);
    //             console.log(result);
    //         });
    //     }
    // };


    function memberSearchAutoCorrect(){
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
        console.log("member search autocorrect");
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
                    case "Find Members":
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
