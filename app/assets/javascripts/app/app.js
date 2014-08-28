var fbb = {
    defaultLat : 41.907940468646984,
    defaultLng : -87.67672317193603,
    defaultCourt : "Wicker Park Fieldhouse",
    modal: function(btn, modal_el){
        //common simple modal function
        btn.click(function(e){
            console.log("modal");
            e.preventDefault();
            var modalOptions = {
                "backdrop" : true,
                "keyboard" : true
            }
            modal_el.modal(modalOptions);
        });
    }
}

$(function(){
    fbb.helpers();
    fbb.lat = fbb.defaultLat;
    fbb.lng = fbb.defaultLng;
    fbb.map();
    fbb.nav();
    fbb.hero();
    fbb.footer();
    fbb.youtubeModals();
    fbb.upload_photo();
    fbb.bestInPlace();

    $(".modal.fade, .modal-message").click(function(){
      $(this).modal('hide'); //manually doing the modal hide bullshit...
    }).children().click(function(e){
        if(!$(e.target).hasClass('modal-message')){
            e.stopPropagation();
        }
    });



});