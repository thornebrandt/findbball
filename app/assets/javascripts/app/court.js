fbb.court = function(){
    function initialize(){
        if ( $("#container-court").length || $("#container-event").length ){
            console.log("container-court");
            prepareGallery();
            prepareVideos();
        }
    };

    function prepareVideos(){
        console.log("preparing videos");
        $("#add_court_video").click(function(e){
            e.preventDefault();
            console.log("huh");
            var $_modal = $("#add_video_modal");
            setTimeout( focusInput, 500 );
            $_modal.modal();
        });

        var focusInput = function(){
            console.log("what the lump");
            $("#youtube_url").focus();
        };

        $("#confirm_youtube_link").click(
            function(e) {
                e.preventDefault();
                var pastedLink = $("#youtube_url").val();
                var vid = new Array();
                var vidHtml;
                var video_id = pastedLink.split('v=')[1];
                if (video_id) {
                    $("#vi").val(video_id);
                    $("#new_court_video").submit();
                } else {
                    alert("not a valid youtube link");
                    $("#youtube_url").css("border", "red solid 1px");
                }
            }
        );

        $("#cancel_youtube_link").click(function(e){
            e.preventDefault();
            $("#add_video_modal").modal('hide');
        });

    };


    function prepareGallery(){
        fbb.galleryTotal = gon.court_photos.length;
        fbb.galleryIndex = "";

        _.each(gon.court_photos, function(e, i){
            e.index = i;
            e.total = gon.court_photos.length;
        });


        $("#selectPhotoContainer .courtPhoto").click(function(e){
            $(".selectedPhoto").removeClass("selectedPhoto");
            $(this).addClass("selectedPhoto");
            var imgSrc = $(this).attr("src");
            var photo_id = parseInt( $(this).attr("rel") );
            $("#main_image_src").val( photo_id );
            loadMainPreview( { id: photo_id });
            $(".change_image_confirm").show();
        });

        $("#cancel_main_image").click(function(e){
            e.preventDefault();
            console.log("hide this bitch");
            $("#selectCourtPhotoModal").modal('hide');
        });


        function loadMainPreview( criteria ){
            var photo_obj = _.where( gon.court_photos, criteria)[0];
            var img_url = photo_obj.photo.url;
            fbb.loading();
            fbb.loadImageURL(img_url, function(img){
                fbb.doneLoading();
                $("#selectPhotoPreview").attr("src", img.attr("src"));
            });
        };


        $("#court_left #edit_photo").click(function(e){
            e.preventDefault();
            if(fbb.galleryTotal){
                selectCourtPhotoBtnHandler();
            } else {
                uploadCourtPhotoBtnHandler();
            }
        });


        $("#confirm_image").click(
            function(e){
                fbb.loading();
            }
        );

        $("#courtPhotos .courtPhoto").click(function(e){
            e.preventDefault();
            var photo_id = parseInt( $(this).attr("rel") );
            loadGallery( { id: photo_id });
        });

        function loadGallery( criteria  ){
            var photo_obj = _.where( gon.court_photos, criteria)[0];
            var img_url = photo_obj.photo.url;
            fbb.loading();
            fbb.loadImageURL(img_url, function(img){
                fbb.doneLoading();
                $("#gallery").html(img);
            });
            $("#galleryModal").modal();
            $("#gallery_next").attr("rel", fbb.cycleNext(photo_obj.index, photo_obj.total));
            $("#gallery_previous").attr("rel", fbb.cyclePrev(photo_obj.index, photo_obj.total));
        };


        $("#gallery_next, #gallery_previous").click(function(e){
            e.preventDefault();
            var _index = parseInt($(this).attr("rel"));
            loadGallery( { index: _index });
        });


        $("#upload_court_photo").click(function(e){
            e.preventDefault();
            uploadCourtPhotoBtnHandler();
        });

        var uploadCourtPhotoBtnHandler = function(){
            $("#upload_court_photo_modal").modal().on('hidden', function(){
                $("#confirm_image").hide();
            });
            prepareUploadCourtPhoto();
        };

        var selectCourtPhotoBtnHandler = function(){
            $("#selectCourtPhotoModal").modal();
        };

        function prepareUploadCourtPhoto(){

            var input = document.getElementById("images"), formdata = false;
            console.log("hi");
            console.log(input);
            fbb.uploadImagePreview(input, "btn1", addCourtPhoto);
        };

        function addCourtPhoto(_source){
            var $_courtPhoto = $("#court_photo_preview");
            $_courtPhoto.attr("src", _source);
            $_courtPhoto.hide();
            $_courtPhoto.fadeIn();
            $("#confirm_image").show();
            $("#court_photo_photo").val(_source); //hidden field that updates the member
        };
    }
    initialize();
};