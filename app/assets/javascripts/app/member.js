fbb.member = function(){



    function domEvents(){
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

    }

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

    domEvents();
}