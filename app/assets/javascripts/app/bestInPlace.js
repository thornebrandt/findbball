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
    $('.best_in_place').bind("ajax:error", function (data) { console.log("fail"); console.log(data); });
}