fbb.helpers = function(){

    //MOVE TO HELPERS DOCUMENT

    Number.prototype.plural = function(){
      if(this > 1 || this == 0){
        return true;
      } else {
        return false;
      }
    };


    String.prototype.pluralize_rules = function(){
      return [[new RegExp('$', 'gi'), 's']];
    };

    String.prototype.pluralize = function(number){
      var str = this;
      if(number.plural()){
        var str = this;
        var rules = this.pluralize_rules();
        for(var r=0; r < rules.length; r++){
          if(str.match(rules[r][0])){
            str = str.replace(rules[r][0], rules[r][1]);
          }
        }
      }
      return str.toString();
    };

    this.formatSizeUnits = function(bytes){
          if      (bytes>=1073741824) {bytes=(bytes/1073741824).toFixed(2)+' GB';}
          else if (bytes>=1048576)    {bytes=(bytes/1048576).toFixed(2)+' MB';}
          else if (bytes>=1024)       {bytes=(bytes/1024).toFixed(2)+' KB';}
          else if (bytes>1)           {bytes=bytes+' bytes';}
          else if (bytes==1)          {bytes=bytes+' byte';}
          else                        {bytes='0 byte';}
          return bytes;
    };


    this.loading = function(){
        $(".modal-loading").show();
    };

    this.doneLoading = function(){
        $(".modal-loading").hide();
    };


    this.loadImageURL = function(img_url, callback){
        var img = $("<img />").attr("src", img_url).load(function(){
            if(!this.complete || typeof this.naturalWidth === "undefined" || this.naturalWidth === 0){
                console.log("broken image");
            } else {
                callback(img);
            }
        });
    }


    this.cycleNext = function(i, total){
        i++;
        if(i >= total){
            i = 0;
        }
        return i;
    };

    this.cyclePrev = function(i, total){
        i--;
        if(i < 0){
            i = total - 1;
        }
        return i;
    }

}


function getQueryVariable(query, variable) {
    var noQuestion = query.replace("?", "");
    var vars = noQuestion.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] == variable) {
            return pair[1];
        }
    }
    return false
};

function add_fields(link, association, content){
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().append( content.replace(regexp, new_id) );
    $(link).parent().append( $(link) );
};


function parseVideoLink(youtube_link){
    var video_id;
    var vid = new Array();
    var vidHtml;
    var _regex = /(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})/i;
    var _match = youtube_link.match(_regex);
    if(_match){
        video_id = _match[1];
    }
    if(video_id){
        return video_id;
    } else {
        return false;
    }
}




