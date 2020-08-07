// ===================================================================================================
// Desarrollado Por		    :   Haold Caicedo.
// Fecha de Creación		:   2016/02/27.
// Producto o sistema	    :   DeltaApp
// Empresa			        :   albatrosSoft
// Proyecto			        :   DeltaApp
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones javascript de vista parcial de Pertinence.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
function UserIndex() { }


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
UserIndex.initializeComponents = function (listCmd, deleteCmd, updateCmd, createCmd) {
    var containerHTML = String.format('#{0}', 'divUserTableContainerValue');
    //Establecer funcion de busqueda sobre la tabla
    var sender = String.format('#{0}', 'btnSearch');
    var senderNewSearch = String.format('#{0}', 'btnNewSearch');
    UserIndex.initializeNewSearch(senderNewSearch, containerHTML);
    UserIndex.initializeSearch(sender, containerHTML);
    //Inicializar tabla
    UserIndex.initializeTable(containerHTML, listCmd, deleteCmd, updateCmd, createCmd);
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
UserIndex.initializeNewSearch = function (sender, containerHTML) {
    CommonUtils.hideMessage('lblMessage');
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
UserIndex.initializeSearch = function (sender, containerHTML) {
    //Re-load records when user click 'load records' button.
    $(sender).button().click(function (e) {
        e.preventDefault();
        $(containerHTML).jtable('load', {
            name: $('#txtName').val(),
        });
        CommonUtils.hideMessage('lblMessage');
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
UserIndex.initializeTable = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd) {
    $(containerHTML).jtable({
        title: 'Usuarios',
        paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'USR_NAME ASC',
        actions: {
            listAction: listCmd,
            deleteAction: deleteCmd,
            updateAction: updateCmd,
            createAction: createCmd
        },
        fields: {
            USR_ID: {
                key: true,
                create: false,
                edit: false,
                list: false
            },
            USR_DOCUMENT: {
                title: 'Documento',
                inputClass: 'validate[required, maxSize[60]]'
            },
            ROL_ID: {
                title: 'Rol',
                options: '/Rol/GetRolOptions',
                inputClass: 'validate[required, maxSize[60]]'
            },
            USR_NAME: {
                title: 'Nombre',
                inputClass: 'validate[required, maxSize[60]]'
            },
            USR_PU: {
                title: 'P.U',
                inputClass: 'validate[required, maxSize[60]]'
            },
            USR_MAIL: {
                title: 'E-mail',
                inputClass: 'validate[required, maxSize[60]]'
            },
            USR_NICK: {
                title: 'Nombre Usuario',
                inputClass: 'validate[required, maxSize[60]]'
            },
            USR_PASS: {
                title: 'Contraseña',
                type: 'password',
                inputClass: 'validate[required, maxSize[60]]'
            },
            USR_ACTIVE: {
                title: 'Estado',
                type: 'checkbox',
                values: { 'true': 'Activo', 'false': 'Inactivo' },
                defaultValue: 'true',
               // inputClass: 'validate[required, maxSize[60]]'
            },
            USR_TYPE: {
                title: 'Tipo de Usuario',
                type: 'radiobutton',
                options: {  '0': 'Administrador', 
                            '1': 'Super Usuario', 
                            '2': 'Usuario' },
                inputClass: 'validate[required, maxSize[60]]'
            },

        },
        //Registro Insertado
        recordAdded: function (event, data) {
            var dataName = data.record.USR_NAME;
            var resultMessage = String.format("Registro {0} ingresado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Actualizado
        recordUpdated: function (event, data) {
            var dataName = data.record.USR_NAME;
            var resultMessage = String.format("Registro {0} actualizado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Eliminado
        recordDeleted: function (event, data) {
            var dataName = data.record.USR_NAME;
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