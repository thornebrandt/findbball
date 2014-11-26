fbb.uploadHelper = function(){

    this.uploadImagePreview = function(_input, _btn, handler) {
        //input : file input that holds image
        //btn :  ok.
        //handler : what happens after upload.  source is the image src

        function showUploadedItem(source) {
            handler(source);
        }

        if (window.FormData) {
            formdata = new FormData();
            document.getElementById(_btn).style.display = "none";
        }

        _input.addEventListener("change", function(evt) {

            var i = 0,
                len = this.files.length,
                img, reader, file;

            for (i; i < len; i++) {
                file = this.files[i];

                if (!!file.type.match(/image.*/)) {
                    if (window.FileReader) {
                        reader = new FileReader();
                        reader.onloadend = function(e) {
                            showUploadedItem(e.target.result, file.fileName);
                            fbb.checkFileSize(file.size);
                        };
                        reader.readAsDataURL(file);
                    }
                    if (formdata) {
                        formdata.append("images[]", file);
                    }
                } else {
                    alert("That is not an image");
                    $("#response").html("That was not an image");
                }
            }
        }, false);
    }

    this.checkFileSize = function(_filesize){
        var _units = fbb.formatSizeUnits(_filesize);
        if (_filesize > 5000000){
            // $("#confirm_image").hide();
            $("#response").html("<span class='error'>Your file is big. ("
                +_units+"). This might take a while.</span>");
        } else {
            $("#response").html("Your file is " + _units);
        }
    };
};