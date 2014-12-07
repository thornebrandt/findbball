fbb.video_article = function(){
    var $el = $("#newVideoContainer");
    var isArticlePage = $el.length;
    var initialize= function(){
        if(isArticlePage){
            newVideoArticleForm();
        }
    };

    newVideoArticleForm = function(){
        $("#confirm_video_article").click(
            function(e){
                e.preventDefault();
                validateNewVideoArticleForm();
            }
        );
    };

    validateNewVideoArticleForm = function(){
        var $_form = $("#new_video_article");
        fbb.validate.validateForm($_form);
        var url_el = $("#youtube_article_url");
        var pastedLink = url_el.val();
        var parsedLink = parseVideoLink(pastedLink);
        if(parsedLink){
            $("#vi").val(parsedLink);
        } else {
            alert("not a valid youtube link");
            url_el.css("border", "red solid 1px");
        }
        if($_form.valid()){
            $_form.submit();
        } else {
            console.log("not valid");
        }
    };

    initialize();

}