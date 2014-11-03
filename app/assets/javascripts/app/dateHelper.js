fbb.time = {
    ISO_format: "YYYY-MM-DD HH:mm",

    datePickerToISO : function(d){
        var _year = parseInt(d.selectedYear);
        var _month = parseInt(d.selectedMonth) + 1;
        var _day = parseInt(d.selectedDay);
        var ISO = _year + "-" + _month + "-" + _day;
        var start_date = moment(ISO, "YYYY-M-D").format("YYYY-MM-DD");
        return start_date;
    },

    stringToISO : function(_d){
        var m = moment(_d, fbb.time.ISO_format);
        return m.format(fbb.time.ISO_format);
    },

    addHours: function(_d, _h){
        var moment1 = moment(_d, fbb.time.ISO_format);
        var moment2 = moment1.add(_h, 'h');;
        return moment2.format(fbb.time.ISO_format);
    },

    differenceHours: function(_start, _end){
        var difference = _start.diff(_end) / 1000 / 60 / 60;
        return difference;
    },

    generateTimesArray: function(){
        //TODO - make times array easier to deal with
        var times = [];
        for (var i=0;i<24;i++) {
            for (var j=0; j === 3; j++) {
                var hour = (i>12?(i-12)+"":(i===0?"12":i)+"");
                var mins = "00"; var AMPM = (i>=12?" PM":" AM");
                if(j===0) { mins="00"; }
                if(j===1) { mins="15"; }
                if(j===2) { mins="30"; }
                if(j===3) { mins="45"; }
                times.push(hour+":"+mins+AMPM);
            }
        }
        return times;
    },

}