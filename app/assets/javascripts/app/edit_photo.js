fbb.upload_photo = function(){
    function domEvents(){
        //edit photo

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
        uploadImagePreview(input, "btn1", updatePlayerProfileImages);
    }



    function uploadImagePreview(_input, _btn, handler) {
        //input : file input that holds image
        //btn :  ok.
        //handler : what happens after upload.  source is the image src

        function showUploadedItem(source) {
            handler(source);
        }

        if (window.FormData) {
            //internet explorer
            formdata = new FormData();
            document.getElementById(_btn).style.display = "none";
        }

        _input.addEventListener("change", function(evt) {

            var i = 0,
                len = this.files.length,
                img, reader, file;

            for (; i < len; i++) {
                file = this.files[i];

                if (!!file.type.match(/image.*/)) {
                    if (window.FileReader) {
                        reader = new FileReader();
                        reader.onloadend = function(e) {
                            showUploadedItem(e.target.result, file.fileName);
                            checkFileSize(file.size);
                        };
                        reader.readAsDataURL(file);
                    }
                    if (formdata) {
                        formdata.append("images[]", file);
                    }
                } else {
                    alert("That is not an image");
                    $("#response").html("That was not an image");
                }
            }
        }, false);
    }

    function checkFileSize(_filesize){
        var _units = fbb.formatSizeUnits(_filesize);
        if (_filesize > 1000000){
            $("#confirm_image").hide();
            $("#response").html("<span class='error'>Your file was too big. ("+_units+"). We only allow files up to 1MB.");
        } else {
            $("#response").html("Your file is " + _units);
        }
    };

    function updatePlayerProfileImages(source) {
        $("#response").html("Uploading...");
        $("#profile_preview").attr("src", source);
        $("#confirm_image").show();
        $("#member_photo").val(source); //hidden field that updates the member
    }

    domEvents();
}