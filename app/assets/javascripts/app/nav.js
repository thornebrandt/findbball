fbb.nav = function(){
    var helpBtns = $("#help, #howItWorks");
    var howItWorksModal = $("#howItWorksModal");
    var loginBtn = $("#loginBtn");
    var loginModal = $("#loginModal");

    var setupDomEvents = function(){
        fbb.modal(helpBtns, howItWorksModal);
        fbb.modal(loginBtn, loginModal);
    }
    setupDomEvents();
}