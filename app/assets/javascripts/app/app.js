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
    $(".best_in_place").best_in_place();
    fbb.nav();
    fbb.hero();
    fbb.member_profile();
});
