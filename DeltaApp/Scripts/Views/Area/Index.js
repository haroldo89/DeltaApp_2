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
function AreaIndex() { }


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
AreaIndex.initializeComponents = function (listCmd, deleteCmd, updateCmd, createCmd) {
    var containerHTML = String.format('#{0}', 'divAreaTableContainerValue');
    //Establecer funcion de busqueda sobre la tabla
    var sender = String.format('#{0}', 'btnSearch');
    var senderNewSearch = String.format('#{0}', 'btnNewSearch');
    AreaIndex.initializeNewSearch(senderNewSearch, containerHTML);
    AreaIndex.initializeSearch(sender, containerHTML);
    //Inicializar tabla
    AreaIndex.initializeTable(containerHTML, listCmd, deleteCmd, updateCmd, createCmd);
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
AreaIndex.initializeNewSearch = function (sender, containerHTML) {
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
AreaIndex.initializeSearch = function (sender, containerHTML) {
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
AreaIndex.initializeTable = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd) {
    $(containerHTML).jtable({
        title: 'Areas',
        paging: true,
        pageSize: 10,
        sorting: true,
        defaultSorting: 'AREA_NAME ASC',
        actions: {
            listAction: listCmd,
            deleteAction: deleteCmd,
            updateAction: updateCmd,
            createAction: createCmd
        },
        fields: {
            AREA_ID: {
                key: true,
                create: false,
                edit: false,
                list: false
            },
            AREA_NAME: {
                width: '98%',
                title: 'Nombre',
                inputClass: 'validate[required, maxSize[60]]'
            },
            DIVISIONS: {
                title: '',
                width: '1%',
                height: '10pt',
                sorting: false,
                edit: false,
                create: false,
                display: function (data) {
                    var titleImage = 'Divisiones';
                    //crea la imagen a mostrar
                    var $img = $('<img src= "/Content/images/treeNode.png" title="' + titleImage + '" style="cursor: pointer;" />');
                    //Accion asociada a la imagen
                    $img.click(function () {
                        AreaIndex.showDivisionPopup(data.record.AREA_ID, data.record.AREA_NAME);
                    });
                    //Retorna la imagen a mostrar por registro
                    return $img;
                }
            }
        },
        //Registro Insertado
        recordAdded: function (event, data) {
            var dataName = data.record.AREA_NAME;
            var resultMessage = String.format("Registro {0} ingresado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Actualizado
        recordUpdated: function (event, data) {
            var dataName = data.record.AREA_NAME;
            var resultMessage = String.format("Registro {0} actualizado correctamente", dataName);
            Lobibox.notify('info', {
                size: 'mini',
                rounded: true,
                msg: resultMessage
            });
        },
        //Registro Eliminado
        recordDeleted: function (event, data) {
            var dataName = data.record.AREA_NAME;
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

AreaIndex.showDivisionPopup = function (areaId, areaName) {
    $("#divDivisionContainer").dialog({
        width: 850, height: 450, resizable: true, autoOpen: false, modal: true,
        title: 'Divisiones',
        open: function (event, ui) {
            AreaIndex.initializeDivisionComponents(areaId, areaName);
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

AreaIndex.initializeDivisionComponents = function (areaId, areaName) {
    $("#divDivisionN1TableContainer").html("<div id='divDivisionN1TableContainerValue'></div>")
    var containerHTML = String.format('#{0}', 'divDivisionN1TableContainerValue');
    var listCmd = '/DivisionN1/GetDivisionN1ByArea?areaId=' + areaId
    var deleteCmd = '/DivisionN1/DeleteDivisionN1'
    var updateCmd = '/DivisionN1/UpdateDivisionN1'
    var createCmd = '/DivisionN1/CreateDivisionN1'
    AreaIndex.initializeDivisionControlsComponents(listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName);
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
AreaIndex.initializeDivisionControlsComponents = function (listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName) {
    var containerHTML = String.format('#{0}', 'divDivisionN1TableContainerValue');
    //Inicializar tabla
    AreaIndex.initializeDivisionN1Table(containerHTML, listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName);
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
AreaIndex.initializeDivisionN1Table = function (containerHTML, listCmd, deleteCmd, updateCmd, createCmd, areaId, areaName) {
    $(containerHTML).jtable({
        title: 'Division N1 ' + areaName,
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
            DIV_N2: {
                title: '',
                width: '1%',
                sorting: false,
                edit: false,
                create: false,
                display: function (routePlanData) {
                    //Create an image that will be used to open child table
                    var titleImage = 'Transacciones';
                    var $img = $('<img src="Content/images/Node.png" title="' + titleImage + '" style="cursor: pointer;" />');
                    //Open child table when user clicks the image
                    $img.click(function () {
                        $(containerHTML).jtable('openChildTable',
                            //Parent row
                            $img.closest('tr'),
                                {
                                    title: routePlanData.record.DIV_N1_NAME + ' - DIVISIONES N2',
                                    actions: {
                                        listAction: '/DivisionN2/GetDivisionN2sByDivisionN1?divisionN1Id=' + routePlanData.record.DIV_N1_ID,
                                        deleteAction: '/DivisionN2/DeleteDivisionN2',
                                        updateAction: '/DivisionN2/UpdateDivisionN2',
                                        createAction: '/DivisionN2/CreateDivisionN2'
                                    },
                                    fields: {
                                        DIV_N2_ID: {
                                            key: true,
                                            create: false,
                                            edit: false,
                                            list: false
                                        },
                                        DIV_N3: {
                                            title: '',
                                            width: '1%',
                                            sorting: false,
                                            edit: false,
                                            create: false,
                                            display: function (routePlanData) {
                                                //Create an image that will be used to open child table
                                                var titleImage = 'Transacciones';
                                                var $img = $('<img src="Content/images/Node.png" title="' + titleImage + '" style="cursor: pointer;" />');
                                                //Open child table when user clicks the image
                                                $img.click(function () {
                                                    $(containerHTML).jtable('openChildTable',
                                                        //Parent row
                                                        $img.closest('tr'),
                                                            {
                                                                title: routePlanData.record.DIV_N2_NAME + ' - DIVISIONES N3',
                                                                actions: {
                                                                    listAction: '/DivisionN3/GetDivisionN3sByDivisionN2?divisionN2Id=' + routePlanData.record.DIV_N2_ID,
                                                                    deleteAction: '/DivisionN3/DeleteDivisionN3',
                                                                    updateAction: '/DivisionN3/UpdateDivisionN3',
                                                                    createAction: '/DivisionN3/CreateDivisionN3'
                                                                },
                                                                fields: {
                                                                    DIV_N3_ID: {
                                                                        key: true,
                                                                        create: false,
                                                                        edit: false,
                                                                        list: false
                                                                    },
                                                                    DIV_N3_NAME: {
                                                                        title: 'Nombre',
                                                                        inputClass: 'validate[required, maxSize[60]]'
                                                                    },
                                                                    DIV_N2_ID: {
                                                                        type: 'hidden',
                                                                        defaultValue: routePlanData.record.DIV_N2_ID,
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
                                        DIV_N2_NAME: {
                                            width: '98%',
                                            title: 'Nombre',
                                            inputClass: 'validate[required, maxSize[60]]'
                                        },
                                        DIV_N1_ID: {
                                            type: 'hidden',
                                            defaultValue: routePlanData.record.DIV_N1_ID
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
            DIV_N1_NAME: {
                width: '98%',
                title: 'Nombre',
                inputClass: 'validate[required, maxSize[60]]'
            },
            AREA_ID: {
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