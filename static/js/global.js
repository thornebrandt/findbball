var map, map_canvas;
var service;
var infowindow;
var urlParams;
var court = {}; //starting to creat an object
var fbb = {}; //global object;
var google = google || {};
fbb.courts = {};
fbb.court = {};
fbb.lat;
fbb.lng;
fbb.mapLoaded;
fbb.userLat;
fbb.userLng;
fbb.defaultLat = 41.907940468646984; //Atlanta
fbb.defaultLng = -87.67672317193603; //Atlanta
fbb.defaultCourt = "Wicker Park Fieldhouse";
$(function() {
    function onLoad() { //put automatic functions here
        fbb.getUserLocation();
        checkDOM();
        checkForMapCanvas();
        fbb.checkCoordinates();

    }

    fbb.getUserLocation = function() { //working on this
        navigator.geolocation.getCurrentPosition(showPosition);

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition);
        } else {
            console.log("no geolocation available");
            Arbiter.publish("userCoordinatesFound", true)
        }

        function showPosition(position) {
            fbb.userLat = position.coords.latitude;
            fbb.userLng = position.coords.longitude;
        }
    }


    fbb.checkCoordinates = function() {
        if (!fbb.mapLoaded) {
            //if a map hasn't been loaded already
            if (fbb.lat) {
                fbb.loadMap(fbb.lat, fbb.lng);
            } else {
                if (fbb.userLat) {
                    fbb.loadMap(fbb.userLat, fbb.userLng);
                } else {
                    //no latLng information
                    fbb.loadMap(fbb.defaultLat, fbb.defaultLng); //might replace with default
                }
            }
        }
    }

    fbb.loadMap = function(_lat, _lng) {
        loadGoogleMap(_lat, _lng);
    }



    $("#oneTimeLocation").click(
        function(e) {
            e.preventDefault();
            $(".row_selectCourt").hide();
            $(".row_addLocation").show();
            $("#court_search").attr("name", "");
        }
    );



    $("#btn_addCourt").click(
        function(e) {
            e.preventDefault();
            window.location = "add_court.html";
        }
    );



    //just for presentation
    if (!window.$.cookie) {} else {
        if ($.cookie("courtData")) {
            console.log("it still exists");
            var courtData = JSON.parse($.cookie("courtData"));
            $.removeCookie('courtData');
            var openHours = "Open " + courtData.openTime1 + courtData.openAM1 + " - " +
                courtData.openTime2 + courtData.openAM2;
            var pickupHours = courtData.pickupDay + "s " + courtData.pickupTime + courtData.pickupAM;
            $("#competitionLevel").val(courtData.competitionLevel);
            $("#courtName").text(courtData.name);
            $("#courtAddress").text(courtData.address);
            $("#difficulty").text(courtData.difficulty);
            $("#difficultyImage").attr("src", "img/icon/skill_" + courtData.difficulty + ".png");
            mapFromAddress(courtData.address);
            $("#courtHours").text(openHours);
            $("#pickupTime").text(pickupHours);
            $("#courtWebsite").attr("href", courtData.website);
            $("#firstReview .reviewBody").text(courtData.review);
            court.lat = courtData.lat;
            court.lng = courtData.lng;
        }
    }


    $("#submit_edited_court").click(
        function(e) {
            e.preventDefault();
            submitCourt();
        }
    );


    function submitCourt() {
        var courtData = {};
        courtData.address = $("#courtAddress").val();
        courtData.name = $("#input_court_name").val();
        courtData.difficulty = $("#competitionLevel").val();
        courtData.pickupDay = $("#pickupDay").val();
        courtData.pickupTime = $("#pickupTime").val();
        courtData.pickupAM = $("#pickupAM").val();
        courtData.openTime1 = $("#openTime1").val();
        courtData.openAM1 = $("#openAM1").val();
        courtData.openTime2 = $("#openTime2").val();
        courtData.openAM2 = $("#openAM2").val();
        courtData.website = $("#website_link").val();
        courtData.review = $("#reviewDetails").val();
        courtData.lat = court.lat;
        courtData.lng = court.lng;
        $.cookie("courtData", JSON.stringify(courtData));
        window.location = "court.html";
    }



    $("#confirm_deactivate").click(
        function(e) {
            window.location = "index.html#deactivated";
        }
    );


    $("#cancel_deactivate").click(
        function(e) {
            $("#are_you_sure_delete_modal").modal('hide');
        }
    );

    $("#deactivate_account").click(
        function(e) {
            e.preventDefault();
            $("#are_you_sure_delete_modal").modal();
        }
    );


    $("#save_account_settings").click(
        function(e) {
            window.location = "player_profile.html";
        }
    );

    $("#cancelChangePassword").click(
        function(e) {
            e.preventDefault();
            hidePasswordBox();
            $("#passwordNotice").hide();
        }
    );

    $("#changePassword").click(
        function(e) {
            e.preventDefault();
            if ($("#newPassword").val() !== $("#confirmPassword").val()) {
                alert("passwords do not match");
                $("#passwordNotice").hide();

            } else {
                hidePasswordBox();
                $("#passwordNotice").fadeIn();
            }
            $(".password").val("");
        }
    );


    function hidePasswordBox() {
        $("#changePasswordTableContainer").hide();
        $("#editPassword").show();
    }

    $("#footer a").click(
        function(e) {
            e.preventDefault();
        });

    $("#aboutUs").click(
        function(e) {
            e.preventDefault();
            $("#aboutUsModal").modal();
        }
    );

    $("#privacyPolicy").click(
        function(e) {
            e.preventDefault();
            $("#privacyPolicyModal").modal();
        }
    );

    $("#terms").click(
        function(e) {
            e.preventDefault();
            $("#termsModal").modal();
        }
    );

    $("#help, #howItWorks").click(
        function(e) {
            e.preventDefault();
            $("#howItWorksModal").modal();
        }
    );

    $("#contact").click(
        function(e) {
            e.preventDefault();
            $("#contactModal").modal();
        }
    );




    $("#member_search").typeahead({
        source: function(query, process) {
            return $.get("data/names_filler.json", {
                query: query
            }, function(data) {
                return process(data);
            });
        },
        updater: function(_member) {
            window.location = "player_profile.html?user=" + _member;
        }
    });


    //starting to modulate code;
    fbb.loadCourt = function(_court) {
        $.get("data/courts_filler.json", function(data) {
            fbb.courts = data;
            if (fbb.courts[_court]) {
                fbb.court = fbb.courts[_court];
                fbb.lat = fbb.court.lat;
                fbb.lng = fbb.court.lng;
                fbb.loadMap(fbb.lat, fbb.lng);
            } else {
                console.log("Error: invalid court");
                console.log(fbb.courts[_court]);
            }
        });
    }




    fbb.courtSearch = function() {
        var courtSearch = this;
        courtSearch.courts = {};
        $("#court_search").typeahead({
            source: function(query, process) {
                var courtNames = [];
                $.get("data/courts_filler.json", function(data) {
                    courtSearch.courts = data;
                    for (court in courtSearch.courts) {
                        courtNames.push(court);
                    }
                    return process(courtNames);
                });
                //return $.get("data/courts_filler_json.json", {query: query}, function(data){
                //return process(data);
            },
            updater: function(_court) {
                var selectedCourt = courtSearch.courts[_court];
                $("#selectedCourt").html(_court);
                $(".court_search").hide();
                $(".court_search_selected").show();
                $("#court_search").attr("name", "fixed");
                map_canvas = "add_court_map";
                loadGoogleMap(selectedCourt.lat, selectedCourt.lng)
            }
        });

        $("#selectCourt").click(
            function(e) {
                //typeahead submit!!
                e.preventDefault();
                $("#courtSearchContainer .typeahead .active").click()
            }
        );


        $("#editCourt").click(
            function(e) {
                e.preventDefault();
                $(".court_search").show();
                $(".court_search_selected").hide();
            }
        );
    }



    $("#i_want_to").change(
        function() {
            var thisVal = $(this).val();
            switch (thisVal) {
                case "Find Members":
                    $("#distance").hide();
                    $("#member_search").show();
                    $("#member_search").focus();
                    break;
                default:
                    $("#member_search").hide();
                    $("#distance").show();
            }
        }
    );


    if ($("#showReviews").length != 0) {
        if (window.location.hash) {
            if (window.location.hash.substring(1) == "reviews") {
                $("#showReviews").hide();
                $("#hiddenReviews").show();
            }
        }
    }


    $("#showReviews").click(
        function(e) {
            e.preventDefault();
            $("#showReviews").hide();
            $("#hiddenReviews").slideDown();
        }
    );

    $("#hideReviews").click(
        function(e) {
            e.preventDefault();
            $("#showReviews").show();
            $("#hiddenReviews").slideUp();
        }
    );


    $(".result_reviews").click(
        function(e) {
            e.preventDefault();
            $(this).parent().find(".reviewsModal").modal();
        }
    );


    $("#confirm_youtube_link").click(
        function(e) {
            e.preventDefault();
            var pastedLink = $("#youtube_url").val();
            var vid = new Array();
            var vidHtml;
            var video_id = pastedLink.split('v=')[1];
            if (video_id) {
                var ampersandPosition = video_id.indexOf('&');
                if (ampersandPosition != -1) {
                    video_id = video_id.substring(0, ampersandPosition);
                }
                console.log(video_id);
                vid.push('<div class="courtVideo">');
                vid.push('<img src="http://img.youtube.com/vi/' + video_id + '/1.jpg">');
                vid.push('<a href="http://www.youtube.com/watch?v=' + video_id + '" class="play_btn"></a>');
                vid.push('<div class="modal hide fade youtubeModal">');
                vid.push('<div class="modal-body">');
                vid.push('<div class="youtube_container">');
                vid.push('<iframe width="560" height="315" src="//www.youtube.com/embed/' + video_id + '" frameborder="0" allowfullscreen>');
                vid.push('</iframe>');
                vid.push('</div></div></div></div>');
                var vidHtml = vid.join("");
                $("#courtVideos").append(vidHtml);
                $("#add_video_modal").modal("hide");
                $("#youtube_url").val("");
            } else {
                alert("not a valid youtube link");
            }
        }
    );

    $("#add_court_video").click(
        function(e) {
            e.preventDefault();
            $("#add_video_modal").modal();
        }
    );


    $("#cancel_main_image").click(
        function() {
            $("#selectCourtPhotoModal").modal("hide");
        }
    );

    $("#confirm_main_image").click(
        function() {
            $(".change_image_confirm").hide();
            $("#selectCourtPhotoModal").modal("hide");
            var _imgSrc = $("#main_image_src").val()
            $("#profile_pic").attr("src", _imgSrc);
        }
    );

    $("#edit_photo.edit_court_photo").click(
        function(e) {
            e.preventDefault();
            $("#selectPhotoContainer").html($("#courtPhotos").html());
            $("#selectCourtPhotoModal").modal();
        }
    );

    $("#edit_photo.edit_event_photo").click(
        function(e) {
            e.preventDefault();
            $("#selectPhotoContainer").html($("#courtPhotos").html());
            $("#upload_photo_modal").modal();
        }
    );

    $(document).on("click", "#selectPhotoContainer .courtPhoto",
        function() {
            $(".selectedPhoto").removeClass("selectedPhoto");
            $(this).addClass("selectedPhoto");
            var imgSrc = $(this).attr("src");
            $(".change_image_confirm").show();
            $("#main_image_src").val(imgSrc);
        }
    );


    $(document).on("click", "#courtPhotos .courtPhoto",
        function() {
            var galleryModal = $("#galleryModal");
            var _src = $(this).attr("src");
            var _index = $(this).index();
            galleryModal.children("#gallery").html("<img id='galleryPhoto' src='" + _src + "' rel='" + _index + "'>");
            galleryModal.modal();
        }
    );

    $("#gallery_next, #gallery_previous").click(
        function(e) {
            e.preventDefault();
            var direction = parseInt($(this).attr("rel"));
            var thisIndex = parseInt($("#galleryPhoto").attr("rel"));
            var nextIndex = thisIndex + direction;
            var length = $(".courtPhoto").length;
            if (nextIndex < 0) {
                nextIndex = length - 1;
            }
            if (nextIndex >= length) {
                nextIndex = 0;
            }
            var _src = $(".courtPhoto").eq(nextIndex).attr("src");
            $("#galleryPhoto").attr("src", _src);
            $("#galleryPhoto").attr("rel", nextIndex);
        }
    );


    if ($("#addEvent_form").length != 0) {
        var validator = $("#addEvent_form").validate({
            rules: {
                eventName: "required",
                selectCourt: "required",
                addLocation: "required"
            },
            messages: {
                eventName: "You must include a name for this event.",
                selectCourt: "You must choose a court for this event, or a add a one-time-location.",
                addLocation: "You must add a location or this event"
            },
            errorPlacement: function(error, element) {
                error.appendTo(element.parent());
            },
            hightlight: function(element, errorClass) {
                element.addClass("errored");
            }
        });
    }



    if ($("#addCourt_form").length != 0) {
        var validator = $("#addCourt_form").validate({
            rules: {
                courtName: "required"
            },
            messages: {
                courtName: "You must include a name for the court."
            },
            errorPlacement: function(error, element) {
                error.appendTo(element.parent());
            },
            hightlight: function(element, errorClass) {
                element.addClass("errored");
            }
        });

        $("#addCourt_form").on('submit', function(e) {
            var isvalidate = $("#addCourt_form").valid();
            if (isvalidate) {
                e.preventDefault();
                submitCourt();
            }
        });
    }



    $("#confirm_image").click(
        function() {
            $('#upload_photo_modal').modal('hide');
            $("#profile_pic").attr("src", $("#profile_preview").attr("src"));
        }
    );


    if ($("#datepicker").length != 0) {
        var dp = $("#datepicker");
        dp.datepicker().on('changeDate', function(e) {
            dp.datepicker('hide');
            var _date = dp.date('date');
        });
    }


    $("#edit_photo.edit_player_photo, #edit_photo.edit_event_photo").click(
        function(e) {
            e.preventDefault();
            $("#upload_photo_modal").modal().on('hidden', function() {
                $("#confirm_image").hide();
            });
            editProfilePhoto();
        }
    );


    $("#upload_court_photo").click(
        function(e) {
            e.preventDefault();
            $("#upload_form").show();
            addCourtPhoto();
        }
    );



    var dndSupported = function() {
        var div = document.createElement('div');
        return ('draggable' in div) || ('ondragstart' in div && 'ondrop' in div);
    };




    //edit photo
    $("#profile_pic_container").hover(
        function() {
            $("#edit_photo").show();
        },
        function() {
            $("#edit_photo").hide();
        }
    );




    //edit profile

    $(".editThis").click(
        function(e) {
            e.preventDefault();
            $(this).parent().children(".editable").hide();
            $(this).parent().children(".editing").show();
        }
    );


    $(".editCancel").click(
        function(e) {
            $(this).parent().children(".editable").show();
            $(this).parent().children(".editing").hide();
        }
    );


    // $(".editComplete").click(
    //   function(e){
    //     e.preventDefault();
    //     _target = "#" + $(this).attr("rel");
    //     _value = $(this).parent().children(".editInput").val();
    //     $(this).parent().children(".editable").show();
    //     $(this).parent().children(".editing").hide();
    //     $(_target).text(_value);
    //   }
    // );


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


    // service = new google.maps.places.PlacesService(map);
    // service.nearbySearch(request, callback);
    //loadGoogleMap();

    $(".featured_cell:first, .article_cell:first, #nav3 a:first, .result:first").css("margin-left", "0px");
    $('#hero').maximage({
        cssTransitions: false,
        fillElement: "#heroContainer",
        cycleOptions: {
            fx: 'scrollHorz',
            speed: 800,
            timeout: 7000
        }
    });

    $(".dropdown li ul").each(
        function() {
            var _this = $(this);
            _this.children("li").children("a:odd").addClass("odd");
        }
    );

    $(".friend_feed:odd").addClass("odd");


    if ($("#progbar_fill").length !== 0) {
        //animate progbar if it exists
        var progbarFill = $("#progbar_fill");
        var indicator = $("#progbar_indicator");
        var percentComplete = indicator.text();

        progbarFill.animate({
            width: percentComplete
        }, 1200, fadeIndicator);

        function fadeIndicator() {
            indicator.fadeIn();
        }
    }



    $("#upload_court_photo").click(
        function(e) {
            e.preventDefault();
            $("#upload_court_photo_modal").modal();
        }
    );


    onLoad();
});


//END PAGE LOAD

function checkForMapCanvas() {
    if ($("#map_canvas").length != 0) {
        map_canvas = "map_canvas";
    } else if ($("#add_court_map").length != 0) {
        map_canvas = "add_court_map";
    } else if ($("#court_map").length != 0) {
        map_canvas = "court_map";
    } else {
        map_canvas = "noMap"
    }
}


function loadGoogleMap(_lat, _long) {
    fbb.mapCenter = new google.maps.LatLng(_lat, _long);
    var service = new google.maps.places.AutocompleteService();
    var geocoder = new google.maps.Geocoder();
    var locationQuery = getLocationQuery();

    var mapOptions = {
        center: fbb.mapCenter,
        zoom: 13,
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    if (locationQuery) {
        geocoder.geocode({
            address: locationQuery
        }, function(results, status) {
            if (status != google.maps.GeocoderStatus.OK) {
                alert('Cannot find address');
                return;
            }
            fbb.mapCenter = results[0].geometry.location;
            map.setCenter(fbb.mapCenter);
            map.setZoom(15);
        });
    }


    map = new google.maps.Map(document.getElementById(map_canvas), mapOptions);
    var marker = new google.maps.Marker({
        icon: "img/icon/ball_pointer.png",
        position: fbb.mapCenter,
        map: map
    });


    function lookUpAddress(_address) {
        geocoder.geocode({
            address: _address
        }, function(results, status) {
            if (status != google.maps.GeocoderStatus.OK) {
                alert('Cannot find address');
                return;
            }
            $("#courtAddress").val(_address);
            _point = results[0].geometry.location;
            map.setCenter(_point);
            map.setZoom(15);
            var marker = new google.maps.Marker({
                icon: "img/icon/ball_pointer.png",
                position: _point,
                draggable: true,
                map: map
            });
            var lat = marker.position.lat();
            var lng = marker.position.lng();
            court.lat = lat;
            court.lng = lng;
            $("#latLng").html("Court found at " + _address + " (Lat: " + lat + ", Long: " + lng + ") <i>Drag for better placement</i>");
            google.maps.event.addListener(marker, 'dragend', function() {
                lat = marker.position.lat();
                lng = marker.position.lng();
                $("#latLng").html("Court found at " + _address + " (Lat: " + lat + ", Long: " + lng + ") <i>Drag for better placement</i>");
            });

            $(".row_addLocation").hide();
            $(".row_addedLocation").show();
            $("#address_search").attr("name", "");
            return _address;
        });
    }


    $("#address_search").typeahead({
        source: function(query, process) {
            service.getPlacePredictions({
                input: query
            }, function(predictions, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    process($.map(predictions, function(prediction) {
                        return prediction.description;
                    }));
                }
            });
        },
        updater: function(_address) {
            return lookUpAddress(_address);
        }
    });


    $("#location_search").typeahead({
        source: function(query, process) {
            service.getPlacePredictions({
                input: query
            }, function(predictions, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    process($.map(predictions, function(prediction) {
                        return prediction.description;
                    }));
                }
            });
        },
        updater: function(item) {
            if ($(".findHoops").length != 0) {
                geocoder.geocode({
                    address: item
                }, function(results, status) {
                    if (status != google.maps.GeocoderStatus.OK) {
                        alert('Cannot find address');
                        return;
                    }
                    map.setCenter(results[0].geometry.location);
                    map.setZoom(12);
                });
            } else {
                window.location = "find_hoops.html?location=" + item;
            }
            return item;
        }
    });
}



function callback(results, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
        for (var i = 0; i < results.length; i++) {
            var place = results[i];
            console.log("place: " + place);
        }
    }
}


function editProfilePhoto() {
    var input = document.getElementById("images"),
        formdata = false;
    uploadImagePreview(input, "btn1", updatePlayerProfileImages);
}

function addCourtPhoto() {
    if ($("#response").length != 0) {} else {
        $("#courtPreviewContainer").append("<div id='response'></div>");
        var input = document.getElementById("court_image"),
            formdata = false;
        uploadImagePreview(input, "submit_court_photo", updateCourtPhotos);
    }
}

function updatePlayerProfileImages(source) {
    $("#profile_preview").attr("src", source);
    $("#confirm_image").show();
    console.log("updating player profile images");
}




function updateCourtPhotos(source) {
    $(".response_confirm").show();
    console.log($("#courtPreviewContainer"));
    $("#courtPreviewContainer").append("<img id='courtPreview' src='" + source + "'>");

    $("#cancel_image").unbind().bind(
        "click",
        function() {
            $(".response_confirm").hide();
            $("#upload_form").show();
            $("#response").html("");
            $("#courtPreview").remove();
        }
    );

    $("#confirm_image").unbind().bind(
        "click",
        function() {
            var imgSrc = $("#courtPreview").attr("src");
            $('#upload_court_photo_modal').modal('hide');
            $("#response").html("");
            $("#upload_form").show();
            $("#courtPreview").remove();
            $("#courtPhotos").append("<img class='courtPhoto' src='" + imgSrc + "'>");
            $("#profile_pic").attr("src", imgSrc);
        }
    );


}

function mapFromAddress(_address) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({
        address: _address
    }, function(results, status) {
        if (status != google.maps.GeocoderStatus.OK) {
            alert('Cannot find address');
            return;
        }
    });
}

function uploadImagePreview(_input, _btn, handler) {
    //input : file input that holds image
    //btn :  ok.
    //handler : what happens after upload.  source is the image src

    function showUploadedItem(source) {
        handler(source);
    }

    if (window.FormData) {
        //internet explorer
        formdata = new FormData();
        document.getElementById(_btn).style.display = "none";
    }


    _input.addEventListener("change", function(evt) {
        document.getElementById("response").innerHTML = "Uploading . . ."
        var i = 0,
            len = this.files.length,
            img, reader, file;

        for (; i < len; i++) {
            file = this.files[i];

            if (!!file.type.match(/image.*/)) {
                if (window.FileReader) {
                    reader = new FileReader();
                    reader.onloadend = function(e) {
                        showUploadedItem(e.target.result, file.fileName);
                    };
                    reader.readAsDataURL(file);
                }
                if (formdata) {
                    formdata.append("images[]", file);
                }
            }
        }

        if (formdata) {
            $.ajax({
                url: "php/upload.php",
                type: "POST",
                data: formdata,
                processData: false,
                contentType: false,
                success: function(res) {
                    $("#response").html(res);
                    $("#upload_form").hide();
                }
            });
        }
    }, false);


}




function getLocationQuery() {
    if ($(".findHoops").length != 0) {
        var queryString = window.location.search;
        var queryResult = getQueryVariable(queryString, "location");
        if (queryResult) {
            return decodeURIComponent(queryResult);
        } else {
            return false;
        }
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
}

function showAddress(address, geocoder) {
    geocoder.getLatLng(
        address,
        function(point) {
            if (!point) {
                alert(address + " not found");
            } else {
                map.setCenter(point, 15);
                var marker = new GMarker(point, {
                    draggable: true
                });
                map.addOverlay(marker);
                GEvent.addListener(marker, "dragend", function() {
                    marker.openInfoWindowHtml(marker.getLatLng().toUrlValue(6));
                });
                GEvent.addListener(marker, "click", function() {
                    marker.openInfoWindowHtml(marker.getLatLng().toUrlValue(6));
                });
                GEvent.trigger(marker, "click");
            }
        }
    );
}


(window.onpopstate = function() {
    var match,
        pl = /\+/g, // Regex for replacing addition symbol with a space
        search = /([^&=]+)=?([^&]*)/g,
        decode = function(s) {
            return decodeURIComponent(s.replace(pl, " "));
        },
        query = window.location.search.substring(1);
    urlParams = {};
    while (match = search.exec(query))
        urlParams[decode(match[1])] = decode(match[2]);
})();


function checkDOM() {
    if ($("#court_search").length !== 0) {
        fbb.courtSearch();
    }


    if ($("#court_map").length !== 0) {
        //is there a backend court
        // if not, default court
        //default Court is for presentation
        fbb.loadCourt(fbb.defaultCourt);
    }
}