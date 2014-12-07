fbb.validate = {

    rules: {
        "court[name]": "required",
        "court_address": "required",
        "event[name]": "required",
        "court[website]": "url",
        "video_article[title]": "required",
        event_start_datepicker: {
            required: true,
            date: true
        },
        event_selectCourt: "required",
    },

    messages: {
        "court[name]" : "Your court must have a name",
        court_address : "Your court must have an address",
        "event[name]": "Your event must have a name",
        "video_article[title]" : "Your video article requires a title",
        event_start_datepicker: "Your event must have a start date",
        event_selectCourt: "Your event must take place at an existing court"
    },

    validateForm: function($_form){
        if($_form.length > 0){
            $_form.validate({
                rules: this.rules,
                messages: this.messages,
                debug: false,
                invalidHandler: this.invalidHalder,
                errorPlacement: function(error, element){
                    error.insertAfter(element);
                }
            });
        } else{
            console.log("The form does not exist");
        }
        this.customValidations();
    },


    customValidations: function(){
        $.validator.addMethod('phone_format', function (value) {
            return /^[01]?[- .]?\(?[2-9]\d{2}\)?[- .]?\d{3}[- .]?\d{4}$/.test(value);
        }, "Please enter a valid phonenumber");

    }
};


// forms.validateForm = function($_form){
//     if($_form.length > 0){
//         $_form.validate({
//             rules: forms.validationRules,
//             debug: true,
//             messages: forms.validationMessages,
//             highlight: function(element, errorClass){
//                 $(element).closest('.form-group').addClass('has-error');
//                 $(element).removeClass("valid");
//             },
//             unhighlight: function(element){
//                 $(element).closest('.form_group').removeClass('has-error');
//                 $(element).addClass("valid");
//             },
//             errorElement: 'span',
//             errorClass: 'error',
//             errorPlacement: function(error, element){
//                 error.insertAfter(element);
//             },
//             invalidHandler: function(event, validator){
//                 if(!validator.numberOfInvalids()){ return }
//                 var _scrollTop = $(validator.errorList[0].element).offset().top - 100;
//                 $('html, body').animate({
//                    scrollTop: _scrollTop
//                 }, 500);
//             }
//         });
//     }
// }

// forms.console = function(_msg){
//     console.log('%c ' + _msg, 'color: #ae2626; background: #bbe5e7;');
// }


// forms.validationRules = {
//     name_first: "required",
//     name_last: "required",
//     company_name: "required",
//     venue_name: "required",
//     mail: {
//         required: true,
//         email: true
//     },
//     email: {
//         required: true,
//         email: true
//     },
//     pass: {
//         required: true,
//         minlength: 4
//     },
//     pass_confirm: {
//         required: true,
//         equalTo: ".password_1"
//     },
//     reset_pass: {
//         minlength: 4
//     },
//     phone: {
//         required: true,
//         minlength: 10,
//         maxlength: 10,
//         digits: true
//     },
//     zip1: {
//         minlength: 5,
//         digits: true
//     },
//     zip2: {
//         minlength: 5,
//         digits: true
//     },
//     title: "required",
//     address1_req: "required",
//     city_req: "required",
//     zip_req: "required",
//     State: "required"
// }



// forms.validationMessages = {
//     name_first: "Please include a first name",
//     name_last: "Please include a last name",
//     company_name: "Please include a company name",
//     venue_name: "Please include a venue name",
//     mail: {
//         required: "Please include an email",
//         email: "Please use a valid email address"
//     },
//     email: {
//         required: "Please include an email",
//         email: "Please use a valid email address"
//     },
//     pass: {
//         required: "Please create a password",
//         minlength: "Password must be at least 6 characters"
//     },
//     pass_confirm: {
//         required: "Please confirm password",
//         equalTo: "Passwords do not match"
//     },
//     reset_pass: {
//         minlength: "New password must be at least 6 characters"
//     },
//     phone: {
//         required: "Please include a phone number",
//         minlength: "Phone number must be exactly 10 digits <br>(ex: 8001235555)",
//         maxlength: "Phone number must be exactly 10 digits <br>(ex: 8001235555)",
//         digits: "Phone number must include only numbers"
//     },
//     zip1: {
//         minlength: "Must be at least 5 numbers",
//         digits: "Must be a valid zipcode"
//     },
//     zip2: {
//         minlength: "Must be at least 5 numbers",
//         digits: "Must be a valid zipcode"
//     },
//     title: "Please include a title",
//     address1_req: "Please enter a location",
//     zip_req: "Please enter a zipcode",
//     city_req: "Please enter a city",
//     State: "required"
// }