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
function ProcessIndex() { }


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
ProcessIndex.initializeComponents = function (listCmd, deleteCmd, updateCmd, createCmd) {
    var containerHTML = String.format('#{0}', 'divProcessTableContainerValue');
    //Establecer funcion de busqueda sobre la tabla
    var sender = String.format('#{0}', 'btnSearch');
    var senderNewSearch = String.format('#{0}', 'btnNewSearch');
    ProcessIndex.initializeNewSearch(senderNewSearch, containerHTML);
    ProcessIndex.initializeSearch(sender, containerHTML);
    //Inicializar tabla
    ProcessIndex.initializeTable(containerHTML, listCmd, deleteCmd, updateCmd, createCmd);
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
ProcessIndex.initializeNewSearch = function (sender, containerHTML) {
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
ProcessIndex.initializeSearch = function (sender, containerHTML) {
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
ProcessIndex.initializeTable = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd) {
    $(containerHTML).jtable({
        title: 'Procesos',
        paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'PROC_N0_NAME ASC',
        actions: {
            listAction: listCmd,
            deleteAction: deleteCmd,
            updateAction: updateCmd,
            createAction: createCmd
        },
        fields: {
            PROC_N0_ID: {
                key: true,
                create: false,
                edit: false,
                list: false
            },
            PROC_N0_NAME: {
                width: '98%',
                title: 'Nombre',
                inputClass: 'validate[required, maxSize[60]]'
            },
            PROCEDURES: {
                title: '',
                width: '1%',
                height: '10pt',
                sorting: false,
                edit: false,
                create: false,
                display: function (data) {
                    var titleImage = 'Procedimientos';
                    //crea la imagen a mostrar
                    var $img = $('<img src= "/Content/images/treeNode.png" title="' + titleImage + '" style="cursor: pointer;" />');
                    //Accion asociada a la imagen
                    $img.click(function () {
                        ProcessIndex.showDivisionPopup(data.record.PROC_N0_ID, data.record.PROC_N0_NAME);
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

ProcessIndex.showDivisionPopup = function (areaId, areaName) {
    $("#divDivisionContainer").dialog({
        width: 850, height: 450, resizable: true, autoOpen: false, modal: true,
        title: 'Divisiones',
        open: function (event, ui) {
            ProcessIndex.initializeDivisionComponents(areaId, areaName);
        },
        close: function (event, ui) {
            //RoutePlanTripIndex.clearControls();
        },
        buttons: [
            {
                text: "CERRAR",
                click: function () {
                    $(this).dialog("close");
                }
            }
        ]
    });
    $("#divDivisionContainer").dialog('open');
};

ProcessIndex.initializeDivisionComponents = function (areaId, areaName) {
    $("#divDivisionN1TableContainer").html("<div id='divDivisionN1TableContainerValue'></div>")
    var containerHTML = String.format('#{0}', 'divDivisionN1TableContainerValue');
    var listCmd = '/ProcessN1/GetProcess1ByProcess0?processId0=' + areaId
    var deleteCmd = '/ProcessN1/DeleteProcess1'
    var updateCmd = '/ProcessN1/UpdateProcess1'
    var createCmd = '/ProcessN1/CreateProcess1'
    ProcessIndex.initializeDivisionControlsComponents(listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName);
};

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
ProcessIndex.initializeDivisionControlsComponents = function (listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName) {
    var containerHTML = String.format('#{0}', 'divDivisionN1TableContainerValue');
    //Inicializar tabla
    ProcessIndex.initializeDivisionN1Table(containerHTML, listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName);
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
ProcessIndex.initializeDivisionN1Table = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName) {
    $(containerHTML).jtable({
        title: areaName + ' - PROCEDIMIENTOS N1',
        paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'PROC_N1_NAME ASC',
        actions: {
            listAction: listCmd,
            deleteAction: deleteCmd,
            updateAction: updateCmd,
            createAction: createCmd
        },
        fields: {
            PROC_N1_ID: {
                key: true,
                create: false,
                edit: false,
                list: false
            },
            PROC_N2: {
                title: '',
                width: '1%',
                sorting: false,
                edit: false,
                create: false,
                display: function (rowData) {
                    //Create an image that will be used to open child table
                    var titleImage = 'Procedimientos';
                    var $img = $('<img src="Content/images/Node.png" title="' + titleImage + '" style="cursor: pointer;" />');
                    //Open child table when user clicks the image
                    $img.click(function () {
                        $(containerHTML).jtable('openChildTable',
                            //Parent row
                            $img.closest('tr'),
                                {
                                    title: rowData.record.PROC_N1_NAME + ' - PROCEDIMIENTOS N2',
                                    actions: {
                                        listAction: '/ProcessN2/GetProcess2ByProcess1?processId1=' + rowData.record.PROC_N1_ID,
                                        deleteAction: '/ProcessN2/DeleteProcess2',
                                        updateAction: '/ProcessN2/UpdateProcess2',
                                        createAction: '/ProcessN2/CreateProcess2'
                                    },
                                    fields: {
                                        PROC_N2_ID: {
                                            key: true,
                                            create: false,
                                            edit: false,
                                            list: false
                                        },
                                        PROC_N3: {
                                            title: '',
                                            width: '1%',
                                            sorting: false,
                                            edit: false,
                                            create: false,
                                            display: function (rowData) {
                                                //Create an image that will be used to open child table
                                                var titleImage = 'Procedimientos';
                                                var $img = $('<img src="Content/images/Node.png" title="' + titleImage + '" style="cursor: pointer;" />');
                                                //Open child table when user clicks the image
                                                $img.click(function () {
                                                    $(containerHTML).jtable('openChildTable',
                                                        //Parent row
                                                        $img.closest('tr'),
                                                            {
                                                                title: rowData.record.PROC_N2_NAME + ' - PROCEDIMIENTOS N3',
                                                                actions: {
                                                                    listAction: '/ProcessN3/GetProcess3ByProcess2?process2Id=' + rowData.record.PROC_N2_ID,
                                                                    deleteAction: '/ProcessN3/DeleteProcess3',
                                                                    updateAction: '/ProcessN3/UpdateProcess3',
                                                                    createAction: '/ProcessN3/CreateProcess3'
                                                                },
                                                                fields: {
                                                                    PROC_N3_ID: {
                                                                        key: true,
                                                                        create: false,
                                                                        edit: false,
                                                                        list: false
                                                                    },
                                                                    PROC_N3_NAME: {
                                                                        title: 'Nombre',
                                                                        inputClass: 'validate[required, maxSize[60]]'
                                                                    },
                                                                    PROC_N2_ID: {
                                                                        type: 'hidden',
                                                                        defaultValue: rowData.record.PROC_N2_ID,
                                                                    }
                                                                },
                                                                //Registro Insertado
                                                                recordAdded: function (event, data) {
                                                                    var resultMessage = "Registro(s) ingresado correctamente";
                                                                    var notifyType = 'success'
                                                                    var notifySize = 'mini';
                                                                    if (data.serverResponse.ResultMessage) {
                                                                        resultMessage += " " + data.serverResponse.ResultMessage;
                                                                        notifyType = 'warning';
                                                                        notifySize = 'normal';
                                                                    }
                                                                    Lobibox.notify(notifyType, {
                                                                        size: notifySize,
                                                                        rounded: true,
                                                                        msg: resultMessage,
                                                                        sound: false
                                                                    });
                                                                    $(".jtable-child-table-container").children(".jtable-child-table-container").jtable("load");
                                                                },
                                                                //Registro Actualizado
                                                                recordUpdated: function (event, data) {
                                                                    var resultMessage = "Registro actualizado correctamente";
                                                                    Lobibox.notify('info', {
                                                                        size: 'mini',
                                                                        rounded: true,
                                                                        msg: resultMessage,
                                                                        sound: false
                                                                    });
                                                                    $(".jtable-child-table-container").children(".jtable-child-table-container").jtable("load");
                                                                },
                                                                //Registro Eliminado
                                                                recordDeleted: function (event, data) {
                                                                    var resultMessage = "Registro eliminado correctamente";
                                                                    Lobibox.notify('info', {
                                                                        size: 'mini',
                                                                        rounded: true,
                                                                        msg: resultMessage,
                                                                        sound: false
                                                                    });
                                                                    $(".jtable-child-table-container").children(".jtable-child-table-container").jtable("load");
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
                                                            }, function (data) { //opened handler
                                                                data.childTable.jtable('load');
                                                            });
                                                });
                                                //Return image to show on the row
                                                return $img;
                                            }
                                        },
                                        PROC_N2_NAME: {
                                            width: '98%',
                                            title: 'Nombre',
                                            inputClass: 'validate[required, maxSize[60]]'
                                        },
                                        PROC_N1_ID: {
                                            type: 'hidden',
                                            defaultValue: rowData.record.PROC_N1_ID
                                        }
                                    },
                                    //Registro Insertado
                                    recordAdded: function (event, data) {
                                        var resultMessage = "Registro(s) ingresado correctamente";
                                        var notifyType = 'success'
                                        var notifySize = 'mini';
                                        if (data.serverResponse.ResultMessage) {
                                            resultMessage += " " + data.serverResponse.ResultMessage;
                                            notifyType = 'warning';
                                            notifySize = 'normal';
                                        }
                                        Lobibox.notify(notifyType, {
                                            size: notifySize,
                                            rounded: true,
                                            msg: resultMessage,
                                            sound: false
                                        });
                                        $(".jtable-child-table-container").jtable("load");
                                    },
                                    //Registro Actualizado
                                    recordUpdated: function (event, data) {
                                        var resultMessage = "Registro actualizado correctamente";
                                        Lobibox.notify('info', {
                                            size: 'mini',
                                            rounded: true,
                                            msg: resultMessage,
                                            sound: false
                                        });
                                        $(".jtable-child-table-container").jtable("load");
                                    },
                                    //Registro Eliminado
                                    recordDeleted: function (event, data) {
                                        var resultMessage = "Registro eliminado correctamente";
                                        Lobibox.notify('info', {
                                            size: 'mini',
                                            rounded: true,
                                            msg: resultMessage,
                                            sound: false
                                        });
                                        $(".jtable-child-table-container").jtable("load");
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
                                }, function (data) { //opened handler
                                    data.childTable.jtable('load');
                                });
                    });
                    //Return image to show on the row
                    return $img;
                }
            },
            PROC_N1_NAME: {
                width: '98%',
                title: 'Nombre',
                inputClass: 'validate[required, maxSize[60]]'
            },
            PROC_N0_ID: {
                type: 'hidden',
                defaultValue: areaId
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