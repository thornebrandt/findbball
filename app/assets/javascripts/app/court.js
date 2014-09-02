fbb.court = function(){

    $("#confirm_image").click(
        function(e){
            fbb.modalLoadingAnimation();
        }
    );

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

    $(".content").on("click", "#courtPhotos .courtPhoto", function(){
        var $_galleryModal = $("#galleryModal");
        $("#galleryModal .modal-loading").show();
        $_galleryModal.show();
        //var _src = $(this).attr("src");
    });
};