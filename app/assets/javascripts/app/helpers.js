fbb.helpers = function(){

    //MOVE TO HELPERS DOCUMENT

    Number.prototype.plural = function(){
      if(this > 1 || this == 0){
        return true;
      } else {
        return false;
      }
    }

    String.prototype.pluralize_rules = function(){
      return [[new RegExp('$', 'gi'), 's']];
    }

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
    }
}