﻿// ===================================================================================================
// Desarrollado Por		    :   Haold Caicedo.
// Fecha de Creación		:   2016/02/27.
// Producto o sistema	    :   DeltaApp
// Empresa			        :   albatrosSoft
// Proyecto			        :   DeltaApp
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones javascript de vista parcial de Area.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
function DivisionN1Index() { }


/**
 * Inicializa componentes de formulario.
 *
 * @param {object} listCmd Comando de lista.
 * @param {object} deleteCmd Comnado de eliminacion.
 * @param {object} updateCmd Comando de actualizacioon.
 * @param {object} createCmd Comando de creacion.
 * @return {void}
 *
 */
DivisionN1Index.initializeComponents = function (listCmd, deleteCmd, updateCmd, createCmd) {
    var containerHTML = String.format('#{0}', 'divDivisionN1TableContainerValue');
    //Establecer funcion de busqueda sobre la tabla
    var sender = String.format('#{0}', 'btnSearch');
    var senderNewSearch = String.format('#{0}', 'btnNewSearch');
    DivisionN1Index.initializeNewSearch(senderNewSearch, containerHTML);
    DivisionN1Index.initializeSearch(sender, containerHTML);
    //Inicializar tabla
    DivisionN1Index.initializeTable(containerHTML, listCmd, deleteCmd, updateCmd, createCmd);
    $("#btnIndex").button().click(function () {
        parent.history.back();
        return false;
    })
};

/**
 * Inicializar boton de nueva busqueda
 *
 * @param {object} sender
 * @param {object} containerHTML contenedor jTable
 * @return {void}
 *
 */
DivisionN1Index.initializeNewSearch = function (sender, containerHTML) {
    //Re-load records when user click 'load records' button.
    $(sender).button().click(function (e) {
        e.preventDefault();
        $(containerHTML).jtable('load');
        $('#txtName').val('');
    });
};

/**
 * Inicializaar boton de busqueda
 *
 * @param {object} sender
 * @param {object} containerHTML contenedor jTable
 * @return {void}
 *
 */
DivisionN1Index.initializeSearch = function (sender, containerHTML) {
    //Re-load records when user click 'load records' button.
    $(sender).button().click(function (e) {
        e.preventDefault();
        $(containerHTML).jtable('load', {
            name: $('#txtName').val(),
        });
    });
};

/**
 * Iniciaizar tabla
 *
 * @param {object} containerHTML contenedor 
 * @param {object} listCmd Comando de lista.
 * @param {object} deleteCmd Comnado de eliminacion.
 * @param {object} updateCmd Comando de actualizacioon.
 * @param {object} createCmd Comando de creacion.
 * @return {void}
 *
 */
DivisionN1Index.initializeTable = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd) {
    $(containerHTML).jtable({
        title: 'División N1',
        paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'DIV_N1_NAME ASC',
        actions: {
            listAction: listCmd,
            deleteAction: deleteCmd,
            updateAction: updateCmd,
            createAction: createCmd
        },
        fields: {
            DIV_N1_ID: {
                key: true,
                create: false,
                edit: false,
                list: false
            },
            DIV_N1_NAME: {
                title: 'Nombre',
                inputClass: 'validate[required, maxSize[60]]'
            },
            AREA_ID: {
                title: 'Área',
                options: '/DivisionN1/GetAreaOptions'
            }
        },
        //Registro Insertado
        recordAdded: function (event, data) {
            var dataName = data.record.DIV_N1_NAME;
            var resultMessage = String.format("Registro {0} ingresado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Actualizado
        recordUpdated: function (event, data) {
            var dataName = data.record.DIV_N1_NAME;
            var resultMessage = String.format("Registro {0} actualizado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Eliminado
        recordDeleted: function (event, data) {
            var dataName = data.record.DIV_N1_NAME;
            var resultMessage = String.format("Registro {0} eliminado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        formCreated: function (event, data) {
            data.form.validationEngine({ promptPosition: "topLeft" });
        },
        formSubmitting: function (event, data) {
            return data.form.validationEngine('validate');
        },
        formClosed: function (event, data) {
            data.form.validationEngine('hide');
            data.form.validationEngine('detach');
        }
    });
    $(containerHTML).jtable('load');
};