fbb.member_profile = function(){
    var setupDomEvents = function(){
        $(".editThis").click(
          function(e){
            e.preventDefault();
            $(this).parent().children(".editable").hide();
            $(this).parent().children(".editing").show();
          }
        );


      $(".editCancel").click(
        function(e){
          $(this).parent().children(".editable").show();
          $(this).parent().children(".editing").hide();
        }
      );


        $(".editComplete").click(
          function(e){
            e.preventDefault();
            _target = "#" + $(this).attr("rel");
            _value = $(this).parent().children(".editInput").val();
            $(this).parent().children(".editable").show();
            $(this).parent().children(".editing").hide();
            $(_target).text(_value);
          }
        );
    }
    setupDomEvents();
}