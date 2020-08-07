//Ordenamiento para fecha con formato 'dd/MM/yyyy HH:mm:ss'
jQuery.extend(jQuery.fn.dataTableExt.oSort, {
    "date-string-pre": function (date) {
        var dateString = '';
        var FULL_DATE_PART_SEPARATOR = ' ';
        var DATE_PART_SEPARATOR = '/';
        var TIME_PART_SEPARATOR = ':';
        if (date != null && date != undefined && date.length > 0) {
            date = $.trim(date);
            var dateParts = date.split(FULL_DATE_PART_SEPARATOR);
            //Obtener componentes de fecha y hora
            var datePart = dateParts[0];
            var timePart = dateParts[1];
            //Descomponer fecha
            var datePartElements = datePart.split(DATE_PART_SEPARATOR);
            var yearElement = datePartElements[2];
            var monthElement = datePartElements[1];
            var dayElement = datePartElements[0];
            //Descomponer hora
            var timePartElements = timePart.split(TIME_PART_SEPARATOR);
            var hourElement = timePartElements[0];
            var minutesElement = timePartElements[1];
            var secondsElement = timePartElements[2];
            //Construir fecha
            dateString = yearElement + monthElement + dayElement;
            dateString += hourElement + minutesElement + secondsElement;
        }
        return dateString;
    },

    "date-string-asc": function (a, b) {
        return ((a < b) ? -1 : ((a > b) ? 1 : 0));
    },

    "date-string-desc": function (a, b) {
        return ((a < b) ? 1 : ((a > b) ? -1 : 0));
    }

});



//Ordenamiento para fecha con formato 'dd/MM/yyyy HH:mm:ss'
jQuery.extend(jQuery.fn.dataTableExt.oSort, {
    "statusIcon-string-pre": function (text) {
        var html = $.parseHTML(text);
        var tittle = html[0].title;
        return tittle;
    },

    "statusIcon-string-asc": function (a, b) {
        return ((a < b) ? -1 : ((a > b) ? 1 : 0));
    },

    "statusIcon-string-desc": function (a, b) {
        return ((a < b) ? 1 : ((a > b) ? -1 : 0));
    }

});