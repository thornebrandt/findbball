fbb.nav = function(){
    var setupDomEvents = function(){
        $("#help, #howItWorks").click(
          function(e){
            e.preventDefault();
            $("#howItWorksModal").modal();
          }
        );
    }
    setupDomEvents();
}