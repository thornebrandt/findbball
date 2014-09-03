fbb.court = function(){
    prepareGallery();


    function prepareGallery(){
        fbb.galleryTotal = gon.court_photos.length;
        fbb.galleryIndex = "";

        _.each(gon.court_photos, function(e, i){
            e.index = i;
            e.total = gon.court_photos.length;
        });



        $("#confirm_image").click(
            function(e){
                fbb.modalLoadingAnimation();
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
            var $_galleryModal = $("#galleryModal");
            var img = $("<img />").attr("src", img_url)
                .load(function(){
                    if(!this.complete || typeof this.naturalWidth === "undefined" || this.naturalWidth === 0){
                        console.log("broken image");
                    } else {
                        $("#galleryModal .modal-loading").hide();
                        $("#gallery").html(img);
                    }
                });
            $("#galleryModal .modal-loading").show();
            $("#galleryModal").modal();
            $("#gallery_next").attr("rel", fbb.cycleNext(photo_obj.index, photo_obj.total));
            $("#gallery_previous").attr("rel", fbb.cyclePrev(photo_obj.index, photo_obj.total));
        };


        $("#gallery_next, #gallery_previous").click(function(e){
            e.preventDefault();
            var _index = parseInt($(this).attr("rel"));
            console.log("clicked");
            console.log(_index);
            loadGallery( { index: _index });
        });


        $("#upload_court_photo").click(function(e){
            e.preventDefault();
            $("#upload_court_photo_modal").modal().on('hidden', function(){
                $("#confirm_image").hide();
            });
            prepareUploadCourtPhoto();
        });

        function prepareUploadCourtPhoto(){
            var input = document.getElementById("images"), formdata = false;
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
};