function EditProductDetailIndex() { }

EditProductDetailIndex.initializeComponents = function () {

    $(document).ajaxStart(function () {
        $.blockUI({ message: '<h1><img src="Content/Images/loading1.gif" /> Cargando Registros...</h1>' });
    }).ajaxStop($.unblockUI);

    EditProductDetailIndex.loadProductInfo();

    //EditProductDetailIndex.getProcess0Options();
    //EditProductDetailIndex.getGoalConfiabilityOptions();
    $("#tabsProductCode").tabs();
    $("#tabsOpportunityType").tabs();
    $("#tabsMeasurement").tabs();
    $("#tabsPertinences").tabs();
    $("input[id$='txtOpportunityTypeAccordDate']").datepicker({
        dateFormat: "yy-mm-dd"
    });
    $("#btnSave").button();
    $("#btnSave").click(function (event) {
        $.msg({
            autoUnblock: false,
            clickUnblock: false
            //content: MasterSite.getLoadingImage()
        });
        setTimeout(function () {
            EditProductDetailIndex.btnSave_Click(event);
        }, 500);
        event.preventDefault();
    });
    $("#btnAddPertinencesItem").button();
    $("#ulPickingItems").selectable();

    $("#btnAddPertinencesItem").click(EditProductDetailIndex.btnAddPickItems_Click);

    $("select[id$='ddlProcess']").change(function () {
        EditProductDetailIndex.getProcess1Options();
        EditProductDetailIndex.getProcess2Options();
        EditProductDetailIndex.getProcess3Options();
    });
    $("select[id$='ddlProcessN1']").change(function () {
        EditProductDetailIndex.getProcess2Options();
        EditProductDetailIndex.getProcess3Options();
    });
    $("select[id$='ddlProcessN2']").change(function () {
        EditProductDetailIndex.getProcess3Options();
    });
    $("select[id$='ddlReliability']").change(function () {
        EditProductDetailIndex.ddlReliability_SelectedIndexChanged();
    });

}

EditProductDetailIndex.loadProductInfo = function () {
    var urlPage = '/Product/GetSelectedProductInfo';
    var dataParameters = {
        PDT_ID: $("input[id$='hdnProductId']").val()
    }
    $.ajax({
        url: urlPage,
        data: JSON.stringify(dataParameters),
        method: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            EditProductDetailIndex.loadProductInfo_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            EditProductDetailIndex.loadProductInfo_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del EditProductDetailIndex.loadProductInfo
 */
EditProductDetailIndex.loadProductInfo_onSucces = function (result) {
    if (result != null) {
        if (result.errorMessage == null) {
            var productInfo = result.productInfo;
            //Establecer valores de controles.
            EditProductDetailIndex.setControls(productInfo);
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

EditProductDetailIndex.setControls = function (productInfo) {
    if (productInfo) {
        // Obtener procesos.
        EditProductDetailIndex.getProcess0Options(productInfo);
        //
        EditProductDetailIndex.getGoalConfiabilityOptions(productInfo);

        // Nombre producto
        $("#txtProductName").val(productInfo.PDT_NAME);
        // Sigla
        $("#txtInitial").val(productInfo.PDT_SIGLA);
        // Descripcion
        $("#txtDescription").val(productInfo.PDT_DESC);
        // Codigo 
        if (productInfo.PDT_HASCODE) {
            $("#tabsProductCode").tabs({ active: 0 });
            $("#txtProductCode").val(productInfo.PDT_CODE);
        }
        else {
            $("#tabsProductCode").tabs({ active: 1 });
        }
        // Tipo de oportunidad
        if (productInfo.OP_TYPE_ID == 1) {
            $("#tabsOpportunityType").tabs({ active: 0 });
            $("#txtReferencePointAdvance").val(productInfo.PDT_OPORTUNITY_PTO_REF);
            $("#txtDaysReferencePointAdvance").val(productInfo.PDT_OPORTUNITY_DAYS);
            $("#txtHoursReferencePointAdvance").val(productInfo.PDT_OPORTUNITY_HOURS);
            $("#txtMinuteReferencePointAdvance").val(productInfo.PDT_OPORTUNITY_MINUTES);
        }
        else if (productInfo.OP_TYPE_ID == 2) {
            $("#tabsOpportunityType").tabs({ active: 1 });
            $("#txtReferencePointDelay").val(productInfo.PDT_OPORTUNITY_PTO_REF);
            $("#txtDaysReferencePointDelay").val(productInfo.PDT_OPORTUNITY_DAYS);
            $("#txtHoursReferencePointDelay").val(productInfo.PDT_OPORTUNITY_HOURS);
            $("#txtMinuteReferencePointDelay").val(productInfo.PDT_OPORTUNITY_MINUTES);
        }
        else if (productInfo.OP_TYPE_ID == 3) {
            $("#tabsOpportunityType").tabs({ active: 2 });
            $("input[id$='txtOpportunityTypeAccordDate']").val(productInfo.PDT_OPORTUNITY_DATE_ACCORDED_FORMAT);
        }
        // Meta de medicion
        if (productInfo.GOAL_TYPE_ID == 1) {
            $("#tabsMeasurement").tabs({ active: 0 });
            $("#txtMeasurementAmount").val(productInfo.GOAL_QUANTITY_MONTH);
        }
        else if (productInfo.GOAL_TYPE_ID == 2) {
            $("#tabsMeasurement").tabs({ active: 1 });
            $("#txtPopulation").val(productInfo.GOAL_POBLATION);
            $("#ddlReliability").val(productInfo.GOAL_CONFIABILITY_INDEX);
            $("#txtSamplesMeasured").val(productInfo.GOAL_SAMPLES);
        }
        //Cargar pertinencias del producto seleccionado.
        EditProductDetailIndex.loadProductPickingsInfo();
    }
};

/**
 * Manejador onError de EditProductDetailIndex.loadProductInfo
 */
EditProductDetailIndex.loadProductInfo_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}

EditProductDetailIndex.loadProductPickingsInfo = function () {
    var urlPage = '/Product/GetProductPertineces';
    var dataParameters = {
        PDT_ID: $("input[id$='hdnProductId']").val()
    }
    $.ajax({
        url: urlPage,
        data: JSON.stringify(dataParameters),
        method: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            EditProductDetailIndex.loadProductPickingsInfo_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            EditProductDetailIndex.loadProductPickingsInfo_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del EditProductDetailIndex.loadProductPickingsInfo
 */
EditProductDetailIndex.loadProductPickingsInfo_onSucces = function (result) {
    $("#ulPickingItems").html("");
    if (result != null) {
        if (result.errorMessage == null) {
            if (result.resultMessage == null) {
                $.each(result.pertinencesInfo, function (e, element) {
                    var item = EditProductDetailIndex.createPickingItemList(element.PERT_DETAIL);
                    $("#ulPickingItems").append(item);
                    $("#ulPickingItems").selectable();
                    EditProductDetailIndex.initializeControlButtons();
                });
            }
            else {
                console.log(result.resultMessage);
            }
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de EditProductDetailIndex.loadCustomersByCountry
 */
EditProductDetailIndex.loadProductPickingsInfo_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de pickings (pertinencias).');
}

EditProductDetailIndex.getGoalConfiabilityOptions = function (productInfo) {
    var urlPage = '/Product/GetGoalConfiabilityOptions';
    $.ajax({
        url: urlPage,
        method: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            EditProductDetailIndex.getGoalConfiabilityOptions_onSucces(result, productInfo);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            EditProductDetailIndex.getGoalConfiabilityOptions_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del EditProductDetailIndex.getGoalConfiabilityOptions
 */
EditProductDetailIndex.getGoalConfiabilityOptions_onSucces = function (result, productInfo) {
    $("select[id$='ddlReliability']").html('<option value="">Seleccione un Proceso</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlReliability']").html('');
            var listItems = '<option value="">Seleccione un Valor</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlReliability']").html(listItems);
            if (productInfo != null) {
                if (productInfo.GOAL_TYPE_ID == 2) {
                    $("select[id$='ddlReliability']").val(productInfo.GOAL_CONFIABILITY_INDEX);
                }
            }
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de EditProductDetailIndex.getGoalConfiabilityOptions
 */
EditProductDetailIndex.getGoalConfiabilityOptions_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}


EditProductDetailIndex.getProcess0Options = function (productInfo) {
    var urlPage = '/Product/GetProcess0Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            EditProductDetailIndex.getProcess0Options_onSucces(result, productInfo);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            EditProductDetailIndex.getProcess0Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del EditProductDetailIndex.getProcess0Options
 */
EditProductDetailIndex.getProcess0Options_onSucces = function (result, productInfo) {
    $("select[id$='ddlProcess']").html('<option value="">Seleccione un Proceso</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcess']").html('');
            var listItems = '<option value="">Seleccione un Proceso</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcess']").html(listItems);
            if (productInfo != null) {
                $("select[id$='ddlProcess']").val(productInfo.PROC_N0_ID);
                EditProductDetailIndex.getProcess1Options(productInfo);
            }
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de EditProductDetailIndex.loadCustomers
 */
EditProductDetailIndex.getProcess0Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}


EditProductDetailIndex.getProcess1Options = function (productInfo) {
    var dataParameters = {
        processId: productInfo != null ? productInfo.PROC_N0_ID : $("select[id$='ddlProcess']").val()
    };
    var urlPage = '/Product/GetProcess1Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            EditProductDetailIndex.getProcess1Options_onSucces(result, productInfo);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            EditProductDetailIndex.getProcess1Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del EditProductDetailIndex.getProcess1Options
 */
EditProductDetailIndex.getProcess1Options_onSucces = function (result, productInfo) {
    $("select[id$='ddlProcessN1']").html('<option value="">Seleccione un Proceso N1</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcessN1']").html('');
            var listItems = '<option value="">Seleccione un Proceso N1</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcessN1']").html(listItems);
            if (productInfo != null) {
                $("select[id$='ddlProcessN1']").val(productInfo.PROC_N1_ID);
                EditProductDetailIndex.getProcess2Options(productInfo);
            }
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de EditProductDetailIndex.loadCustomers
 */
EditProductDetailIndex.getProcess1Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}

EditProductDetailIndex.getProcess2Options = function (productInfo) {
    var dataParameters = {
        processId: productInfo != null ? productInfo.PROC_N1_ID : $("select[id$='ddlProcessN1']").val()
    };
    var urlPage = '/Product/GetProcess2Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            EditProductDetailIndex.getProcess2Options_onSucces(result, productInfo);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            EditProductDetailIndex.getProcess2Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del EditProductDetailIndex.getProcess1Options
 */
EditProductDetailIndex.getProcess2Options_onSucces = function (result, productInfo) {
    $("select[id$='ddlProcessN2']").html('<option value="">Seleccione un Proceso N2</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcessN2']").html('');
            var listItems = '<option value="">Seleccione un Proceso N2</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcessN2']").html(listItems);
            if (productInfo != null) {
                $("select[id$='ddlProcessN2']").val(productInfo.PROC_N2_ID);
                EditProductDetailIndex.getProcess3Options(productInfo);
            }
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de EditProductDetailIndex.loadCustomers
 */
EditProductDetailIndex.getProcess2Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}

EditProductDetailIndex.getProcess3Options = function (productInfo) {
    var dataParameters = {
        processId: productInfo != null ? productInfo.PROC_N2_ID : $("select[id$='ddlProcessN2']").val()
    };
    var urlPage = '/Product/GetProcess3Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            EditProductDetailIndex.getProcess3Options_onSucces(result, productInfo);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            EditProductDetailIndex.getProcess3Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del EditProductDetailIndex.getProcess1Options
 */
EditProductDetailIndex.getProcess3Options_onSucces = function (result, productInfo) {
    $("select[id$='ddlProcessN3']").html('<option value="">Seleccione un Proceso N3</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcessN3']").html('');
            var listItems = '<option value="">Seleccione un Proceso N3</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcessN3']").html(listItems);
            if (productInfo != null) {
                $("select[id$='ddlProcessN3']").val(productInfo.PROC_N3_ID);
            }
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de EditProductDetailIndex.loadCustomers
 */
EditProductDetailIndex.getProcess3Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}


EditProductDetailIndex.btnSave_Click = function (event) {
    $("#formProduct").validationEngine({ autoHidePrompt: true, autoHideDelay: 5000 });
    // Validar formulario
    if ($("#formProduct").validationEngine('validate')) {
        EditProductDetailIndex.showProductInfoPopup();
    }
    else {
        Lobibox.notify('error', {
            size: 'mini',
            rounded: true,
            msg: 'Revisar todos los campos obligatorios.',
            sound: false
        });
        $.msg('unblock');
    };
    event.preventDefault();
}

EditProductDetailIndex.showProductInfoPopup = function () {
    var $dialogContainer = $("#divProductTableContainer");
    var $detachedChildren = $dialogContainer.children().detach();
    $dialogContainer.dialog({
        width: 450, height: 550, autoOpen: false, modal: true,
        draggable: false, resizable: false,
        title: 'Vista Previa',
        open: function (event, ui) {
            $detachedChildren.appendTo($dialogContainer);
            ShowEditProductInfo.initializeComponents();
        }
    });
    $dialogContainer.dialog('open');
}

EditProductDetailIndex.btnAddPickItems_Click = function (event) {
    var element = $("input[id$='txtPertinencesItem']").val();
    if (!CommonUtils.isNullOrEmpty(element)) {
        var item = EditProductDetailIndex.createPickingItemList(element);
        $("#ulPickingItems").append(item);
        $("#ulPickingItems").selectable();
        EditProductDetailIndex.initializeControlButtons();
        $("input[id$='txtPertinencesItem']").val('');
    }
    event.preventDefault();
}

EditProductDetailIndex.ddlReliability_SelectedIndexChanged = function () {
    if ($("#txtPopulation").val() != "" && $("#ddlReliability").val() != "") {
        var n = 0;
        var N = parseInt($("#txtPopulation").val());
        var z = 1.645;
        switch (parseInt($("#ddlReliability").children("option:selected").text())) {

            case 90:
                z = 1.645;
                break;
            case 95:
                z = 1.96;
                break;
            case 99:
                z = 2.575;
                break;
            default:
                z = 1.645;
        }

        var p = (0.5);
        var e = 0.05;

        n = (N * (z * z) * p * (1 - p)) / (((N - 1) * (e * e)) + ((z * z) * p * (1 - p)));

        var calculo = parseInt($("#txtPopulation").val()) + parseInt($("#ddlReliability").children("option:selected").text())
        $("#txtSamplesMeasured").val(parseInt(n));
    }
    else {
        $("#txtSamplesMeasured").val("");
    }
}

//Crear item para pickingList
EditProductDetailIndex.createPickingItemList = function (countItems) {
    var listItem = '<li style="text-align:left;" class="ui-state-default"> ' +
                        '<table style="width:100%;">' +
                            '<tr>' +
                                '<td style="width:80%;">' +
                                    '<span></span>' + countItems +
                                    '<input type="hidden" name="hdnCountItems" value="' + countItems + '" />' +
                                '</td>' +
                                '<td style="width:20%; text-align:right;">';
    //Boton de eliminar item.
    var deleteButton = EditProductDetailIndex.deleteButtonPickingItemList();
    var endListItem = '</td>' +
                      '</tr>' +
                     '</table>' +
                    '</li>';
    listItem = String.format("{0}{1}{2}", listItem, deleteButton, endListItem);
    return listItem;
};

//Boton de eliminar para pickingList item
EditProductDetailIndex.deleteButtonPickingItemList = function () {
    var deleteButton = '<button type="submit" name="btnDelete" ' +
                            'title="Eliminar" ' +
                            'class="button" style="background: blue; padding: 3px; width: auto; height: auto; text-align: center; color: white; border: #1C78DE">' +
                            'X' +
                        '</button>';
    return deleteButton;
}

//Inicializar botones para control de picking list.
EditProductDetailIndex.initializeControlButtons = function () {
    /*Quitar evento clic de botones*/
    $("#ulPickingItems li table tbody tr td button[name='btnDelete']").unbind("click");

    /*Eliminar escala*/
    $("#ulPickingItems li table tbody tr td button[name='btnDelete']").on('click', function () {
        $(this).closest("table").parent("li").remove();
    });
}