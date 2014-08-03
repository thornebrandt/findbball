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