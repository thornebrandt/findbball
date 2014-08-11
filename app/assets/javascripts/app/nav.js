fbb.nav = function(){
    var helpBtns = $("#help, #howItWorks");
    var howItWorksModal = $("#howItWorksModal");
    var loginBtn = $("#loginBtn");
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

    $("#member_search").typeahead({
        // source: function(query, process) {
        //     console.log("hi");
        //     return $.get("data/names_filler.json", {
        //         query: query
        //     }, function(data) {
        //         return process(data);
        //     });
        // },
        source: fakeMembers,
        updater: function(_member) {
            window.location = "player_profile.html?user=" + _member;
        }
    });
}


function getQueryVariable(query, variable) {
    var noQuestion = query.replace("?", "");
    var vars = noQuestion.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] == variable) {
            return pair[1];
        }
    }
    return false
}