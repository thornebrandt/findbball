fbb.court = function(){
    var $el = $("#container-court");
    var isCourt = $el.length;
    var initialize = function(){
        if(isCourt){
            prepareGallery();
            prepareVideos();
            checkPickupGamesOnLoad();
            DOMEvents();
        }
    };

    var checkPickupGamesOnLoad = function(){
        $(".court_pickup_game").each(function(i, el){
            var el = $(el);
            var pickup_id = el.attr("data-id");
            if(pickup_id){
                var time_el = el.find(".pickupTimeMini");
                var day_el = el.find(".pickupDayMini");
                var time = parseInt(time_el.attr("data-time"));
                var day = parseInt(day_el.attr("data-day"));
                time_el.val(time);
                day_el.val(day);
            }
        });
    };

    var DOMEvents = function(){
        $el.on("click", ".editPickupGameMini", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent().parent();
            hideEditPickup();
            var show_el = container.find('.pickup_game_show');
            var edit_el = container.find('.pickup_game_edit');
            edit_el.show();
            show_el.hide();
        });

        $el.on("click", ".cancel_pickup", function(e){
            e.preventDefault();
            hideEditPickup();
        });

        $el.on("click", "#newPickupGameMini_btn", function(e){
            e.preventDefault();
            hideEditPickup();
            $("#newPickupGameMini_btn").hide();
            $("#newPickupGameMini").show();
        });

        $el.on("click", ".pickupEditSaveMini", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent().parent();
            var time_el = container.find(".pickupTimeMini");
            var day_el = container.find(".pickupDayMini");
            var _id = container.attr("data-id");
            var _time = parseInt(time_el.val());
            var _day = parseInt(day_el.val());
            var pickupObj = {
                pickup_game: {
                    day: _day,
                    time: _time
                }
            }
            patchPickupGame(pickupObj, _id);
        });

        $el.on("click", "#savePickupGameMini", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent().parent();
            var day_el = $("#newPickupGameDay");
            var time_el = $("#newPickupGameTime");
            var _day = parseInt(day_el.val());
            var _time = parseInt(time_el.val());
            var pickupObj = {
                pickup_game: {
                    day: _day,
                    time: _time,
                    court_id: gon.court.id,
                    member_id: gon.member_id
                }
            }
            createPickupGame(pickupObj);
        });

        $el.on("click", ".deletePickupGameMini", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent().parent();
            var _id = container.attr("data-id");
            var attendees_el = container.find(".pickup_attendees");
            var attendees = parseInt(attendees_el.val());
            if(attendees >= fbb.lotsOfPeople){
                console.log("about to delete??");
                var warning = "Are you sure you want to delete this pickup game with " + attendees + " players?"
                var confirmDelete = window.confirm(warning);
                if(confirmDelete){
                    deletePickupGame(_id, container);
                }
            } else {
                deletePickupGame(_id, container);
            }
        });

        $el.on("click", ".joinPickupGame", function(e){
            e.preventDefault();
            var container = $(e.currentTarget).parent().parent();
            var _id = container.attr("data-id");
            var attendeeObj = {
                pickup_attendee: {
                    pickup_game_id: _id,
                    court_id: gon.court.id,
                    member_id: gon.member_id
                }
            };
            joinPickupGame(attendeeObj);
        });


        $el.on("click", ".leavePickupGameMini", function(e){
            e.preventDefault();
            var _id = $(e.currentTarget).attr("data-id");
            leavePickupGame(_id);
        });

    };


    var deletePickupGame = function(_id, container){
        var hidePickupGame = function(){
            container.fadeOut('300', function(){
                reloadPickupGameContainer();
            });
        };

        $.ajax({
            url: "/pickup_games/" + _id,
            type: "post",
            dataType: "json",
            data: {"_method":"delete"},
            success: function(response){
                hidePickupGame();
            },
            error: function(error){
                console.log("error on deletion");
                console.log(error);
            }
        });
    };

    var leavePickupGame = function(_id){
        $.ajax({
            url: "/pickup_attendees/" + _id,
            type: "post",
            dataType: "json",
            data: {"_method":"delete"},
            success: function(response){
                reloadPickupGameContainer();
            },
            error: function(error){
                console.log("error on deletion");
                console.log(error);
            }
        });
    };


    var joinPickupGame = function(_obj){
        $.ajax({
            type: "POST",
            url: "/pickup_attendees",
            dataType: "json",
            data: _obj,
            success: function(response){
                reloadPickupGameContainer();
            },
            error: function(error){
                console.log("error joining pickup game");
                console.log(error);
            }
        });
    };


    var createPickupGame = function(_obj){
        $.ajax({
            type: "POST",
            url: "/pickup_games",
            dataType: "json",
            data: _obj,
            success: function(response){
                reloadPickupGameContainer();
            },
            error: function(error){
                console.log("error, yo");
                console.log(error);
            }
        });
    }

    var reloadPickupGameContainer = function(){
        var court_id = gon.court.id;
        var sideBarReloaded = function(response){
            checkPickupGamesOnLoad();
        };
        $("#court_pickup_games_container").load('/courts/'+court_id+'/reload_pickup_games',
            function(e){
                checkPickupGamesOnLoad();
            }
        );
    };


    var patchPickupGame = function(pickup_game_obj, _id){
        $.ajax({
            type: "PATCH",
            url: "/pickup_games/" + _id,
            dataType: "json",
            data: pickup_game_obj,
            success: function(response){
                reloadPickupGameContainer();
            },
            error: function(error){
                console.log("we errored");
                console.log(error);
            }
        });
    }

    var hideEditPickup = function(){
        $(".pickup_game_edit").hide();
        $(".pickup_game_show").show();
        $("#newPickupGameMini_btn").show();
    };


    var prepareVideos = function(){
        $("#add_court_video").click(function(e){
            e.preventDefault();
            var $_modal = $("#add_video_modal");
            setTimeout( focusInput, 500 );
            $_modal.modal();
        });

        var focusInput = function(){
            console.log("what the lump");
            $("#youtube_url").focus();
        };

        $("#confirm_youtube_link").click(
            function(e) {
                e.preventDefault();
                var pastedLink = $("#youtube_url").val();
                var vid = new Array();
                var vidHtml;
                var _regex = /(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})/i;
                var _match = pastedLink.match(_regex);
                var video_id = _match[1];
                if (video_id) {
                    $("#vi").val(video_id);
                    $("#new_court_video").submit();
                } else {
                    alert("not a valid youtube link");
                    $("#youtube_url").css("border", "red solid 1px");
                }
            }
        );

        $("#cancel_youtube_link").click(function(e){
            e.preventDefault();
            $("#add_video_modal").modal('hide');
        });

    };


    var prepareGallery = function(){
        fbb.galleryTotal = gon.court_photos.length;
        fbb.galleryIndex = "";

        _.each(gon.court_photos, function(e, i){
            e.index = i;
            e.total = gon.court_photos.length;
        });


        $("#selectPhotoContainer .courtPhoto").click(function(e){
            $(".selectedPhoto").removeClass("selectedPhoto");
            $(this).addClass("selectedPhoto");
            var imgSrc = $(this).attr("src");
            var photo_id = parseInt( $(this).attr("rel") );
            $("#main_image_src").val( photo_id );
            loadMainPreview( { id: photo_id });
            $(".change_image_confirm").show();
        });

        $("#cancel_main_image").click(function(e){
            e.preventDefault();
            $("#selectCourtPhotoModal").modal('hide');
        });


        var loadMainPreview = function( criteria ){
            var photo_obj = _.where( gon.court_photos, criteria)[0];
            var img_url = photo_obj.photo.url;
            fbb.loading();
            fbb.loadImageURL(img_url, function(img){
                fbb.doneLoading();
                $("#selectPhotoPreview").attr("src", img.attr("src"));
            });
        };


        $("#court_left #edit_photo").click(function(e){
            e.preventDefault();
            if(fbb.galleryTotal){
                selectCourtPhotoBtnHandler();
            } else {
                uploadCourtPhotoBtnHandler();
            }
        });


        $("#confirm_image").click(
            function(e){
                fbb.loading();
            }
        );

        $("#courtPhotos .courtPhoto").click(function(e){
            e.preventDefault();
            var photo_id = parseInt( $(this).attr("rel") );
            loadGallery( { id: photo_id });
        });

        var loadGallery = function( criteria  ){
            var photo_obj = _.where( gon.court_photos, criteria)[0];
            var img_url = photo_obj.photo.url;
            fbb.loading();
            fbb.loadImageURL(img_url, function(img){
                fbb.doneLoading();
                $("#gallery").html(img);
            });
            $("#galleryModal").modal();
            $("#gallery_next").attr("rel", fbb.cycleNext(photo_obj.index, photo_obj.total));
            $("#gallery_previous").attr("rel", fbb.cyclePrev(photo_obj.index, photo_obj.total));
        };


        $("#gallery_next, #gallery_previous").click(function(e){
            e.preventDefault();
            var _index = parseInt($(this).attr("rel"));
            loadGallery( { index: _index });
        });


        $("#upload_court_photo").click(function(e){
            e.preventDefault();
            uploadCourtPhotoBtnHandler();
        });

        var uploadCourtPhotoBtnHandler = function(){
            $("#upload_court_photo_modal").modal().on('hidden', function(){
                $("#confirm_image").hide();
            });
            prepareUploadCourtPhoto();
        };

        var selectCourtPhotoBtnHandler = function(){
            $("#selectCourtPhotoModal").modal();
        };

        var prepareUploadCourtPhoto = function(){
            var input = document.getElementById("images"), formdata = false;
            fbb.uploadImagePreview(input, "btn1", addCourtPhoto);
        };

        var addCourtPhoto = function(_source){
            var $_courtPhoto = $("#court_photo_preview");
            $_courtPhoto.attr("src", _source);
            $_courtPhoto.hide();
            $_courtPhoto.fadeIn();
            $("#confirm_image").show();
            $("#court_photo_photo").val(_source); //hidden field that updates the member
        };
    }
    initialize();
};