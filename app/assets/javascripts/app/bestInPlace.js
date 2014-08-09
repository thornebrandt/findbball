fbb.bestInPlace = function(){
    var bestInPlaceOptions = {
        changeMonth: true,
        yearRange: "-40:-10",
        dateFormat: 'MM dd, yy'
    }
    $.datepicker.setDefaults(bestInPlaceOptions);
    $(".best_in_place").best_in_place();
    //$('.best_in_place').bind("ajax:success", function (data) { console.log("success"); console.log(data); });
    $('.best_in_place').bind("ajax:error", function (data) { console.log("fail"); console.log(data); });


}