fbb.member = function(){
    var $el = $("#container-member");
    var isMemberPage = $el.length;
    var initialize = function(){
        if(isMemberPage){
            DOMEvents();
        }
    };


    function DOMEvents(){
        //edit photo


        $("#confirm_image").click(
            function(e){
                fbb.modalLoadingAnimation();
            }
        );


        $("#profile_pic_container").hover(
            function() {
                $("#edit_photo").show();
            },
            function() {
                $("#edit_photo").hide();
            }
        );


        $("#edit_photo.edit_player_photo, #edit_photo.edit_event_photo").click(
            function(e) {
                e.preventDefault();
                $("#upload_photo_modal").modal().on('hidden', function() {
                    $("#confirm_image").hide();
                });
                editProfilePhoto();
            }
        );

        $el.on("click", ".joinPickupGame", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent();
            var _id = container.attr("data-id");
            var _court_id = container.attr("data-court");
            var attendeeObj = {
                pickup_attendee: {
                    pickup_game_id: _id,
                    court_id: _court_id,
                    member_id: gon.current_member_id
                }
            };
            joinPickupGame(attendeeObj);
        });


        $el.on("click", ".leavePickupGameMini", function(e){
            e.preventDefault();
            var _id = $(e.currentTarget).attr("data-id");
            leavePickupGame(_id);
        });

    }

    var joinPickupGame = function(_obj){
        $.ajax({
            type: "POST",
            url: "/pickup_attendees",
            dataType: "json",
            data: _obj,
            success: function(response){
                reloadPickupGameContainer();
            },
            error: function(error){
                console.log("error joining pickup game");
                console.log(error);
            }
        });
    };

    var leavePickupGame = function(_id){
        $.ajax({
            url: "/pickup_attendees/" + _id,
            type: "post",
            dataType: "json",
            data: {"_method":"delete"},
            success: function(response){
                reloadPickupGameContainer();
            },
            error: function(error){
                console.log("error on deletion");
                console.log(error);
            }
        });
    };

    var reloadPickupGameContainer = function(){
        var member_id = gon.member_id;
        $("#member_pickup_games_container").load('/members/'+member_id+'/reload_pickup_games');
    };


    function editProfilePhoto() {
        var input = document.getElementById("images"),
            formdata = false;
        fbb.uploadImagePreview(input, "btn1", updatePlayerProfileImages);
    }


    function updatePlayerProfileImages(source) {
        $("#profile_preview").attr("src", source);
        $("#confirm_image").show();
        $("#member_photo").val(source); //hidden field that updates the member
    }

    initialize();
}