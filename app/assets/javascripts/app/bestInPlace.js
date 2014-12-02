fbb.bestInPlace = function(){
    var bestInPlaceOptions = {
        changeMonth: true,
        changeYear: true,
        yearRange: "-60:-18",
        dateFormat: 'MM dd, yy',
        beforeShow: function(){
            $(".ui-datepicker").addClass("hide");
        }
    }
    $.datepicker.setDefaults(bestInPlaceOptions);
    $(".best_in_place").best_in_place();
    //$('.best_in_place').bind("ajax:success", function (data) { console.log("success"); console.log(data); });
    $('.best_in_place').bind("ajax:success", function(e){
        var target = $(e.target);
        target.css("border", "none");
        target.parent().find('.error').remove();
    });
    $('.best_in_place').bind("ajax:error", function (e, error) {
        var target = $(e.target);
        var errorText = JSON.parse(error.responseText)[0];
        target.css('border', 'red solid 1px');
        target.parent().append("<span class='error'>" + errorText + "</span>");
    });
}