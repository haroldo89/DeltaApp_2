// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
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
function EditProductIndex() { }


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
EditProductIndex.initializeComponents = function (listCmd, deleteCmd) {
    var containerHTML = String.format('#{0}', 'divProductTableContainerValue');
    //Establecer funcion de busqueda sobre la tabla
    var sender = String.format('#{0}', 'btnSearch');
    var senderNewSearch = String.format('#{0}', 'btnNewSearch');
    EditProductIndex.initializeNewSearch(senderNewSearch, containerHTML);
    EditProductIndex.initializeSearch(sender, containerHTML);
    //Inicializar tabla
    EditProductIndex.initializeTable(containerHTML, listCmd, deleteCmd);

};

/**
 * Inicializar boton de nueva busqueda
 *
 * @param {object} sender
 * @param {object} containerHTML contenedor jTable
 * @return {void}
 *
 */
EditProductIndex.initializeNewSearch = function (sender, containerHTML) {
    CommonUtils.hideMessage('lblMessage');
    //Re-load records when user click 'load records' button.
    $(sender).button().click(function (e) {
        $(containerHTML).jtable('load');
        $('#txtProductName').val('');
        $('#txtProductSigla').val('');
        $('#txtProductDesc').val('');
        e.preventDefault();
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
EditProductIndex.initializeSearch = function (sender, containerHTML) {
    //Re-load records when user click 'load records' button.
    $(sender).button().click(function (e) {
        e.preventDefault();
        $(containerHTML).jtable('load', {
            PDT_NAME: $('#txtProductName').val(),
            PDT_SIGLA: $('#txtProductSigla').val(),
            PDT_DESC: $('#txtProductDesc').val()
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
EditProductIndex.initializeTable = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd) {
    $(containerHTML).jtable({
        title: 'Productos',
        paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'PROC_N0_NAME ASC',
        actions: {
            listAction: listCmd,
            deleteAction: deleteCmd
        },
        fields: {
            PDT_ID: {
                key: true,
                create: false,
                edit: false,
                list: false
            },
            PDT_NAME: {
                title: 'Nombre'
            },
            PDT_SIGLA: {
                title: 'Nombre'
            },
            PDT_DESC: {
                title: 'Nombre'
            },
            PROC_N0_NAME: {
                title: 'Proc'
            },
            PROC_N1_NAME: {
                title: 'Proc 1'
            },
            PROC_N2_NAME: {
                title: 'Proc 2'
            },
            PROC_N3_NAME: {
                title: 'Proc 3'
            },
            EditProduct: {
                title: '',
                width: '1%',
                height: '10pt',
                sorting: false,
                edit: false,
                create: false,
                display: function (data) {
                    var titleImage = 'Editar Producto';
                    //crea la imagen a mostrar
                    var $img = $('<img src= "/Content/images/Preview.png" title="' + titleImage + '" style="cursor: pointer;" />');
                    //Accion asociada a la imagen
                    $img.click(function () {
                        window.location.href = 'EditDetailIndex?PDT_ID=' + data.record.PDT_ID;
                    });
                    //Retorna la imagen a mostrar por registro
                    return $img;
                }
            }
        },
        //Registro Insertado
        recordAdded: function (event, data) {
            var dataName = data.record.PROC_N0_NAME;
            var resultMessage = String.format("Registro {0} ingresado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Actualizado
        recordUpdated: function (event, data) {
            var dataName = data.record.PROC_N0_NAME;
            var resultMessage = String.format("Registro {0} actualizado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Eliminado
        recordDeleted: function (event, data) {
            var dataName = data.record.PROC_N0_NAME;
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