fbb.hero = function(){
    var hero = $("#hero");
    var heroOptions = {
        cssTransitions:false,
        fillElement: "#heroContainer",
        cycleOptions: {
            fx:'scrollHorz',
            speed: 800,
            timeout: 7000
        }
    };
    var setupDomEvents = function(){
        hero.maximage(heroOptions);
    };
    setupDomEvents();
}