// ===================================================================================================
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
function RolIndex() { }

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
RolIndex.initializeComponents = function (listCmd, deleteCmd, updateCmd, createCmd) {
    var containerHTML = String.format('#{0}', 'divRolTableContainerValue');
    //Establecer funcion de busqueda sobre la tabla
    var sender = String.format('#{0}', 'btnSearch');
    var senderNewSearch = String.format('#{0}', 'btnNewSearch');
    RolIndex.initializeNewSearch(senderNewSearch, containerHTML);
    RolIndex.initializeSearch(sender, containerHTML);
    //Inicializar tabla
    RolIndex.initializeTable(containerHTML, listCmd, deleteCmd, updateCmd, createCmd);
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
RolIndex.initializeNewSearch = function (sender, containerHTML) {
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
RolIndex.initializeSearch = function (sender, containerHTML) {
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
RolIndex.initializeTable = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd) {
    $(containerHTML).jtable({
        title: 'Roles',
        paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'ROL_NAME ASC',
        actions: {
            listAction: listCmd,
            deleteAction: deleteCmd,
            updateAction: updateCmd,
            createAction: createCmd
        },
        fields: {
            ROL_ID: {
                key: true,
                create: false,
                edit: false,
                list: false
            },
            ROL_NAME: {
                title: 'Nombre',
                inputClass: 'validate[required, maxSize[60]]',
                width: '98%',
            },
            EditProductRole: {
                title: '',
                width: '1%',
                height: '10pt',
                sorting: false,
                edit: false,
                create: false,
                display: function (data) {
                    var titleImage = 'Editar Productos por Rol';
                    //crea la imagen a mostrar
                    var $img = $('<img src= "/Content/Images/asociate.png" title="' + titleImage + '" style="cursor: pointer;" />');
                    //Accion asociada a la imagen
                    $img.click(function () {
                        RolIndex.loadProductsByUserRolePopUp(data.record.ROL_ID, data.record.ROL_NAME);
                    });
                    //Retorna la imagen a mostrar por registro
                    return $img;
                }
            }
        },
        //Registro Insertado
        recordAdded: function (event, data) {
            var dataName = data.record.ROL_NAME;
            var resultMessage = String.format("Registro {0} ingresado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Actualizado
        recordUpdated: function (event, data) {
            var dataName = data.record.ROL_NAME;
            var resultMessage = String.format("Registro {0} actualizado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Eliminado
        recordDeleted: function (event, data) {
            var dataName = data.record.ROL_NAME;
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

RolIndex.loadProductsByUserRolePopUp = function (selectedUserRoleId, selectedUserRoleName) {
    $("#divUserRoleProductsPopup").dialog({
        modal: true,
        resizable: false,
        height: 550,
        width: 600,
        open: function () {
            UserRolByProductPopUp.getProductsByUserRole(selectedUserRoleId, selectedUserRoleName);
        },
        buttons: [
            {
                text: "Guardar",
                style: "margin: 1px 1px 1px 1px;",
                click: function () {
                    UserRolByProductPopUp.btnSaveUserRolProducts_Click(selectedUserRoleId);
                }
            },
            {
                text: "Cancelar",
                style: "margin: 1px 1px 1px 1px;",
                click: function () {
                    $(this).dialog("close");
                }
            }
        ]
    });
    $('#divUserRoleProductsPopup').dialog('open');
};
