fbb.youtubeModals = function(){
    $(".video_title").click(
        function(e) {
            e.preventDefault();
            var _youtubeModal = $(this).parent().children('.youtube_video').children(".youtubeModal");
            _youtubeModal.modal();
        }
    );


    $(".article_title").click(
        function(e) {
            e.preventDefault();
            var articleModal = $(this).parent().children('.articleModal');
            articleModal.modal();
        }
    );


    $(document).on("click", ".play_btn",
        function(e) {
            e.preventDefault();
            var _youtubeModal = $(this).parent().children(".youtubeModal");
            _youtubeModal.modal();
        }
    );

}