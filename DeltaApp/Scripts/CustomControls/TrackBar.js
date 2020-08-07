// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2015/07/29.
// Producto o sistema	    :   Wizenz.Navi
// Empresa			        :   Wizenz Technologies
// Proyecto			        :   NAVI30
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Objetos para la visualizacion de control de TrackBar.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
/*TrackBar*/
function TrackBar() {

    //Texto
    var _text;
    this.setText = function (text) {
        _text = text;
    }
    this.getText = function () {
        return _text;
    }

    //Valor
    var _value;
    this.setValue = function (value) {
        _value = value;
    }
    this.getValue = function () {
        return _value;
    }

    //Items
    var _items;
    this.setItems = function (items) {
        _items = items;
    }

    this.getItems = function () {
        return _items;
    }

    //Constructor
    this.setTrackBar = function (text, value) {
        this.setText(text);
        this.setValue(value);
    }

    //Obtener html del control.
    this.getHtmlText = function () {
        var htmlText = '';
        htmlText += "<table style='width:100%;'>" + "<tr>" +
			"<td style='width:10%;vertical-align:bottom;' > " +
                "<div data-name='masterName' class='masterName'>" + "<span>" + this.getText() + "</span>" +
                "<input type='hidden' value='" + this.getValue() + "'" + "/>" +
                 "</div>" +
            "</td>" +
			"<td style='width:85%;'>" +
            "<ol class='trackBar' data-trackbar-steps='0'>";
        var trackBarItems = this.getItems();
        //Recorrer items de TrackBar.
        $.each(trackBarItems, function (i, trackBarItem) {
            htmlText += "<li class='" + trackBarItem.getStatusClass() + "'> " +
                        "<label style='cursor:pointer; color:transparent;' class='tooltip fade' data-title='" + trackBarItem.getTitle() + "' >" + trackBarItem.getIndex() + "</label>" +
                        "<input type='hidden' value='" + trackBarItem.getValue() + "'" + "/>" +
                    "</li>";
        });
        htmlText += "</ol></td></tr></table>";
        return htmlText;
    }
}
//Posibles estados del control 
//Estado Programado.
TrackBar.SCALE_SCHEDULED_STATUS_CLASS = "pending";
//Estado OK.
TrackBar.TRIP_SCALE_OK_STATUS_CLASS = "ok";
//Estado anticipado.
TrackBar.SCALE_EARLY_STATUS_CLASS = "warning";
//Estado atrasado.
TrackBar.SCALE_DELAYED_STATUS_CLASS = "critical";

/*Iten del TrackBarItem*/
function TrackBarItem() {

    //Indice
    var _index;
    this.setIndex = function (index) {
        _index = index;
    }
    this.getIndex = function () {
        return _index;
    }

    //Tooltip
    var _title;
    this.setTitle = function (title) {
        _title = title;
    }
    this.getTitle = function () {
        return _title;
    }

    //Valor
    var _value;
    this.setValue = function (value) {
        _value = value;
    }
    this.getValue = function () {
        return _value;
    }

    //Clase
    var _statusClass;
    this.setStatusClass = function (statusClass) {
        _statusClass = statusClass;
    }
    this.getStatusClass = function () {
        return _statusClass;
    }

    //Constructor
    this.setTrackBarItem = function (index, title, value, statusClass) {
        this.setIndex(index);
        this.setTitle(title);
        this.setValue(value);
        this.setStatusClass(statusClass);
    }
}