/*===========================Reperesenta la informacion de la vista de alertas=======================-*/
//Representa la informacion de resumen de alertas .
function SummaryAlertLog() {

    /*--Propiedades--*/
    var _status;
    var _item;
    

    /*Setters*/
    this.setStatus = function (status) {
        _status = status;
    }

    this.setItem = function (item) {
        _item = item;
    }

    /*Getters*/
    this.getStatus = function () {
        return _status;
    }

    this.getItem = function () {
        return _item;
    }

    /*--Contructor--*/
    this.setSummaryAlertLog = function (summaryAlertLog) {
        if (summaryAlertLog) {
            this.setStatus(summaryAlertLog.status);
            this.setItem(summaryAlertLog.items);
        }
    }
}


