fbb.hero = function(){
    fbb.currentSlide = false;
    var hero = $("#hero");
    var heroOptions = {
        cssTransitions:false,
        fillElement: "#heroContainer",
        cycleOptions: {
            fx:'scrollHorz',
            speed: 800,
            timeout: 100,
            after: function(last,current){
                var heroContainer = $("#heroContainer");
                heroContainer.removeClass("clickable");
                fbb.currentSlide = current;
                var heroLink = $(fbb.currentSlide).attr("data-href");
                if(heroLink){
                    heroContainer.addClass("clickable");
                }
            }

        }
    };
    var setupDomEvents = function(){
        hero.maximage(heroOptions);
        $("#heroContainer").click(function(){
            if(fbb.currentSlide){
                var heroLink = $(fbb.currentSlide).attr("data-href");
                if(heroLink){
                    window.location = heroLink;
                }
            }
        });
    };


    setupDomEvents();
}