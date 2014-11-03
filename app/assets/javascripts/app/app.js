window.fbb = {
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
};



var pageLoad = function(){
    initialize();
};

var initialize = function(){
    var fbb = window.fbb;
    fbb.helpers();
    fbb.uploadHelper();
    fbb._map();
    fbb.nav();
    fbb.hero();
    fbb.footer();
    fbb.youtubeModals();
    fbb.member();
    fbb.bestInPlace();
    fbb.newCourt();
    fbb.court();
    fbb._event();

    $(".modal.fade, .modal-message").click(function(){
      $(this).modal('hide'); //manually doing the modal hide bullshit...
    }).children().click(function(e){
        if(!$(e.target).hasClass('modal-message')){
            e.stopPropagation();
        }
    });
};


$(document).on('page:load', pageLoad);
$(document).ready(pageLoad);