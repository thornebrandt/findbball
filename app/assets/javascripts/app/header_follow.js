// http://stackoverflow.com/questions/1216114/how-can-i-make-a-div-stick-to-the-top-of-the-screen-once-its-been-scrolled-to#answer-2153775
function moveScroller() {
    var move = function() {
        var st = $(window).scrollTop();
        var ot = $("top").offset().top; // #scroller-anchor
        var s = $("#nav2"); // #scroller
        if(st > ot) {
            s.css({
                position: "fixed",
                top: "0px"
            });
        } else {
            if(st <= ot) {
                s.css({
                    position: "relative",
                    top: ""
                });
            }
        }
    };
    $(window).scroll(move);
    move();
