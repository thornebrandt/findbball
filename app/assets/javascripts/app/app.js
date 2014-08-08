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
    fbb.lat = fbb.defaultLat;
    fbb.lng = fbb.defaultLng;
    fbb.nav();
    fbb.hero();
    fbb.youtubeModals();
    fbb.map();
    fbb.showCourt();
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



//MOVE TO HELPERS DOCUMENT

Number.prototype.plural = function(){
  if(this > 1 || this == 0){
    return true;
  } else {
    return false;
  }
}

String.prototype.pluralize_rules = function(){
  return [[new RegExp('$', 'gi'), 's']];
}

String.prototype.pluralize = function(number){
  var str = this;
  if(number.plural()){
    var str = this;
    var rules = this.pluralize_rules();
    for(var r=0; r < rules.length; r++){
      if(str.match(rules[r][0])){
        str = str.replace(rules[r][0], rules[r][1]);
      }
    }
  }
  return str.toString();
}