// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2014/01/21.
// Producto o sistema	    :   Wizenz.Navi
// Empresa			        :   Wizenz Technologies
// Proyecto			        :   NAVI30
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones javascript de utilidad general para las graficas.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================

function ChartUtils() { }

//Convertir fecha en formato de libreria d3.
ChartUtils.parseDate = function (date, dateFormat) {
    var parseDate = d3.time.format(dateFormat).parse;
    var formatedDate = parseDate(date);
    return formatedDate;
}

//Obtener mes apartir de una fecha en formato de libreria de d3
ChartUtils.getMonth = function (date) {
    var monthDatePart = d3.time.month(date);
    return monthDatePart;
}

//Obtener semana basada en lunes apartir de una fecha en formato de libreria de d3
ChartUtils.getWeek = function (date) {
    var weekDatePart = d3.time.sunday(date);
    return weekDatePart;
}

//Obtener dia apartir de una fecha en formato de libreria de d3
ChartUtils.getDay = function (date) {
    var dayDatePart = d3.time.day(date);
    return dayDatePart;
}

//Obtener hora apartir de una fecha en formato de libreria de d3
ChartUtils.getHour = function (date) {
    var hourDatePart = d3.time.hour(date);
    return hourDatePart;
}

