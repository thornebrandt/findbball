$(function(){ 


var service;
var map;

if($("#location_search").length != 0){
  google.maps.event.addDomListener(window, 'load', loadGoogleMap);
  var service = new google.maps.places.AutocompleteService();
  var geocoder = new google.maps.Geocoder();
  var mapOptions = {
           zoom: 13,
           scrollwheel: false,
           mapTypeId: google.maps.MapTypeId.ROADMAP
         };
    
  function loadGoogleMap(){
    $("#location_search").typeahead({
      source: function(query, process) {
        service.getPlacePredictions({ input: query }, function(predictions, status) {
          if (status == google.maps.places.PlacesServiceStatus.OK) {
            process($.map(predictions, function(prediction) {
              return prediction.description;
            }));
          }
        });
      },
      updater: function (item) {
        $("#mapItems").show();
        $("#searchItems").hide();
        map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
        
        geocoder.geocode({ address: item }, function(results, status) {
          if (status != google.maps.GeocoderStatus.OK) {
            alert('Cannot find address');
            return;
          }
          map.setCenter(results[0].geometry.location);
          map.setZoom(12); 
        });
        return item;
      }
    });
  } 
}

$("#newSearch").click(
  function(){ 
    $("#mapItems").hide();
    $("#searchItems").show();
    $("#location_search").val("");
  }
);



$('#go').buttonMarkup({ inline: true });




});