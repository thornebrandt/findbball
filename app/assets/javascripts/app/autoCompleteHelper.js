var guess = {
    autoCompleteLocal: function(_el, _data, _options){
        this.presetRel(_el, _data);
        var options = _options || {};
        var display = "autoCompleteDisplay"; // created in model and displayed in template
        var limit = options.limit || 12;
        var results;
        var template = autoCompleteTemplate;
        if ( options.simple === true ){
            template = this.simpleTemplate;
        }
        var setValues = function(obj, datum){
            if ( options.simple === true ){
                //entire datum for simple array
                _el.typeahead('val', datum);
            } else {
                _el.attr("rel", datum.id);
                _el.typeahead('val', datum[display]);
            }
            _el.typeahead('close');
        };

        var selectedHandler = function(obj, datum){
            setValues(obj, datum);
            if(options.onSelect){
                options.onSelect(obj, datum);
            }
        };

        var cursorChangedHandler = function(obj, datum){
            if(options.onChange){
                options.onChange(obj, datum);
            }
        };

        results = new Bloodhound({
            datumTokenizer: function(data){
                var dataDisplay = data[display]; // ex : data["name"]
                if(options.simple === true){
                    //or simple array
                    dataDisplay = data;
                }
                return Bloodhound.tokenizers.whitespace( dataDisplay );
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            local: _data,
            limit: limit
        });

        results.initialize();
        _el.typeahead({
            hint: true,
            highlight: true,
            autoselect: 'first',
            render: function(){
                console.log("rendering");
            }
        },
        {
            source: results.ttAdapter(),
            templates: {
                suggestion: template
            },
            updater: function(selection){
                console.log("you selected: " + selection);
            }
        });
        _el.unbind("typeahead:selected");
        _el.on("typeahead:selected", selectedHandler);
        _el.on("typeahead:cursorchanged", cursorChangedHandler);
    }
}