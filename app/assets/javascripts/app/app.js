var fbb = {
    defaultLat : 41.907940468646984,
    defaultLng : -87.67672317193603,
    defaultCourt : "Wicker Park Fieldhouse",
    modal: function(btn, modal_el){
        //common simple modal function
        btn.click(function(e){
            console.log("modal");
            e.preventDefault();
            modal_el.modal();
        });
    }
}

$(function(){
    var bestInPlaceOptions = {
        changeYear: true,
        changeMonth: true,
        yearRange: "-40:-10",
        dateFormat: 'MM dd, yy'
    }
    $.datepicker.setDefaults(bestInPlaceOptions);
    $(".best_in_place").best_in_place('option', 'dateFormat', 'MM dd, yy');
    $('.best_in_place').bind("ajax:success", function (data) { console.log("success"); console.log(data); });
    $('.best_in_place').bind("ajax:error", function (data) { console.log("fail"); console.log(data); });
    //$(".datepicker_container input").datepicker();
    $.extend($.fn.datepicker.defaults, { format: 'yy-mm-dd', changeYear: true });
    fbb.nav();
    fbb.hero();
    // fbb.member_profile(); //looks like this is replaced by best_in_place
});
