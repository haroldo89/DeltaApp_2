// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2015/05/04.
// Producto o sistema	    :   Wizenz.Navi
// Empresa			        :   Wizenz Technologies
// Proyecto			        :   NAVI30
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Ventana modal personalizada de JQuery.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
function MessageBox() { }

//Ventana modal Alert Generico.
//Param<"Message">Mensaje a mostrar en ventana modal.</Param>
//Param<"title">Titulo de la ventana modal.</Param>
MessageBox.show = function (message, title) {
    if (message) {
        $("#divMessageBox").dialog({
            //Propiedades del dialog de jQuery
            autoOpen: false, modal: true, bgiframe: true, width: 400, height: 165,
            //Titulo del dialog de jQuery
            title: title ? title : "Atención",
            //Botones
            buttons: [
                {
                    text: "Aceptar",
                    click: function () {
                        $(this).dialog("close");
                    }
                }
            ]
        });
        //Abrir pop up
        $('#divMessageBox').dialog('open');
        //Establecer mensaje a ventana modal
        $("#lblMessageBox").text(message);
    }
    else {
        console.error("el valor de mensaje no puede ser nulo o vacio")
    }
}

//Ventana modal de tipo Confirm
//Param<"Message">Mensaje a mostrar en ventana modal.</Param>
//Param<"title">Titulo de la ventana modal.</Param>
MessageBox.showConfirm = function (message, title) {
    if (message) {
        $("#divMessageBox").dialog({
            //Propiedades del dialog de jQuery
            autoOpen: false, modal: true, bgiframe: true, width: 425, height: 165,
            //Titulo del dialog de jQuery
            title: title ? title : "Confirmación",
            buttons: [
                {
                    text: "Aceptar",
                    click: function () {
                        $(this).dialog("close");
                    },
                    text: "Cancelar",
                    click: function () {
                        $(this).dialog("close");
                    }
                }
            ]
        });
        $('#divMessageBox').dialog('open');
        $("#lblMessageBox").text(message);
    }
    else {
        console.error("el valor de mensaje no puede ser nulo o vacio")
    }
}

MessageBox.showDialog = function () {

}