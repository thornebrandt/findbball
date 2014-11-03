fbb.newCourt = function(){
    var initialize = function(){
        DOMEvents();
    };

    var DOMEvents = function(){
        $(".selectCourtAMPM").change(function(e){
            var target = $(e.target);
            var timeEl = target.parent().children(".courtTime"); ;
            var courtTime = parseFloat(target.val()) + parseInt(timeEl.val());
            console.log("added time = " + courtTime );
        });

        $("#submit_court").click(function(e){
            e.preventDefault();
            var newCourtForm = $("#new_court");
            fbb.validate.validateForm(newCourtForm);
            if( newCourtForm.valid() ){
                console.log("Valid new court form");
            } else {
                console.log("invalid new court form");
            }

        });

    };
    initialize();
}
