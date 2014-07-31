fbb.edit_photo = function(){
    function domEvents(){
        //edit photo
        console.log("here we go");


        $("#profile_pic_container").hover(
            function() {
                $("#edit_photo").show();
            },
            function() {
                $("#edit_photo").hide();
            }
        );


        $("#edit_photo.edit_court_photo").click(
            function(e) {
                e.preventDefault();
                $("#selectPhotoContainer").html($("#courtPhotos").html());
                $("#selectCourtPhotoModal").modal();
            }
        );

        $("#edit_photo.edit_event_photo").click(
            function(e) {
                e.preventDefault();
                $("#selectPhotoContainer").html($("#courtPhotos").html());
                $("#upload_photo_modal").modal();
            }
        );
    }
    domEvents();
}