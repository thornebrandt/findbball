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
    fbb.lat = fbb.defaultLat;
    fbb.lng = fbb.defaultLng;
    fbb.bestInPlace();
    fbb.nav();
    fbb.hero();
    fbb.map();
    fbb.edit_photo();
    // fbb.member_profile(); //looks like this is replaced by best_in_place
});
