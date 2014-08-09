fbb.footer = function(){
    $("#footer a").click(
        function(e) {
            e.preventDefault();
        });

    $("#aboutUs").click(
        function(e) {
            e.preventDefault();
            $("#aboutUsModal").modal();
        }
    );

    $("#privacyPolicy").click(
        function(e) {
            e.preventDefault();
            $("#privacyPolicyModal").modal();
        }
    );

    $("#terms").click(
        function(e) {
            e.preventDefault();
            $("#termsModal").modal();
        }
    );

    $("#help, #howItWorks").click(
        function(e) {
            e.preventDefault();
            $("#howItWorksModal").modal();
        }
    );

    $("#contact").click(
        function(e) {
            e.preventDefault();
            $("#contactModal").modal();
        }
    );
}