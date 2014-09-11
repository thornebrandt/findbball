var fbb = {
    defaultLat : 33.7489954,
    defaultLng : -84.3879824 ,
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
    fbb.uploadHelper();
    fbb.map();
    fbb.nav();
    fbb.hero();
    fbb.footer();
    fbb.youtubeModals();
    fbb.member();
    fbb.bestInPlace();
    fbb.court();
    fbb.courtEvent();

    $(".modal.fade, .modal-message").click(function(){
      $(this).modal('hide'); //manually doing the modal hide bullshit...
    }).children().click(function(e){
        if(!$(e.target).hasClass('modal-message')){
            e.stopPropagation();
        }
    });

});