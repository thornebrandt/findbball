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