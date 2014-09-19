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
    }

}