fbb.court = function(){
    $(".content").on("click", "#courtPhotos .courtPhoto", function(){
        var $_galleryModal = $("#galleryModal");
        var _src = $(this).attr("src");
    });
};