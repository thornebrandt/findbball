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
        DOM();
    };

    var DOM = function(){
        $(".noLink").click(function(e){
            e.preventDefault();
        });
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
