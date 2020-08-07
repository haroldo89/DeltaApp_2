function ProductIndex() { }

ProductIndex.initializeComponents = function () {

    $(document).ajaxStart(function () {
        $.blockUI({ message: '<h1><img src="Content/Images/loading1.gif" /> Cargando Registros...</h1>' });
    }).ajaxStop($.unblockUI);

    ProductIndex.getProcess0Options();
    ProductIndex.getGoalConfiabilityOptions();
    $("#tabsProductCode").tabs();
    $("#tabsOpportunityType").tabs();
    $("#tabsMeasurement").tabs();
    $("#tabsPertinences").tabs();
    $("input[id$='txtOpportunityTypeAccordDate']").datepicker({
        dateFormat: "yy-mm-dd",
        minDate: new Date()
    });
    $("#btnSave").button();
    $("#btnSave").click(function (event) {
        $.msg({
            autoUnblock: false,
            clickUnblock: false
            //content: MasterSite.getLoadingImage()
        });
        setTimeout(function () {
            ProductIndex.btnSave_Click(event);
        }, 500);
        event.preventDefault();
    });
    $("#btnAddPertinencesItem").button();
    $("#ulPickingItems").selectable();

    $("#btnAddPertinencesItem").click(ProductIndex.btnAddPickItems_Click);

    $("select[id$='ddlProcess']").change(function () {
        ProductIndex.getProcess1Options();
        ProductIndex.getProcess2Options();
        ProductIndex.getProcess3Options();
    });
    $("select[id$='ddlProcessN1']").change(function () {
        ProductIndex.getProcess2Options();
        ProductIndex.getProcess3Options();
    });
    $("select[id$='ddlProcessN2']").change(function () {
        ProductIndex.getProcess3Options();
    });
    $("select[id$='ddlReliability']").change(function () {
        ProductIndex.ddlReliability_SelectedIndexChanged();
    });

}

ProductIndex.getGoalConfiabilityOptions = function () {
    var urlPage = '/Product/GetGoalConfiabilityOptions';
    $.ajax({
        url: urlPage,
        method: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            ProductIndex.getGoalConfiabilityOptions_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ProductIndex.getGoalConfiabilityOptions_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del ProductIndex.getGoalConfiabilityOptions
 */
ProductIndex.getGoalConfiabilityOptions_onSucces = function (result) {
    $("select[id$='ddlReliability']").html('<option value="">Seleccione un Proceso</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlReliability']").html('');
            var listItems = '<option value="">Seleccione un Valor</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlReliability']").html(listItems);
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de ProductIndex.getGoalConfiabilityOptions
 */
ProductIndex.getGoalConfiabilityOptions_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}


ProductIndex.getProcess0Options = function () {
    var urlPage = '/Product/GetProcess0Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            ProductIndex.getProcess0Options_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ProductIndex.getProcess0Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del ProductIndex.getProcess0Options
 */
ProductIndex.getProcess0Options_onSucces = function (result) {
    $("select[id$='ddlProcess']").html('<option value="">Seleccione un Proceso</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcess']").html('');
            var listItems = '<option value="">Seleccione un Proceso</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcess']").html(listItems);
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de ProductIndex.loadCustomers
 */
ProductIndex.getProcess0Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}


ProductIndex.getProcess1Options = function () {
    var dataParameters = {
        processId: $("select[id$='ddlProcess']").val()
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
            ProductIndex.getProcess1Options_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ProductIndex.getProcess1Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del ProductIndex.getProcess1Options
 */
ProductIndex.getProcess1Options_onSucces = function (result) {
    $("select[id$='ddlProcessN1']").html('<option value="">Seleccione un Proceso N1</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcessN1']").html('');
            var listItems = '<option value="">Seleccione un Proceso N1</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcessN1']").html(listItems);
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de ProductIndex.loadCustomers
 */
ProductIndex.getProcess1Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}

ProductIndex.getProcess2Options = function () {
    var dataParameters = {
        processId: $("select[id$='ddlProcessN1']").val()
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
            ProductIndex.getProcess2Options_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ProductIndex.getProcess2Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del ProductIndex.getProcess1Options
 */
ProductIndex.getProcess2Options_onSucces = function (result) {
    $("select[id$='ddlProcessN2']").html('<option value="">Seleccione un Proceso N2</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcessN2']").html('');
            var listItems = '<option value="">Seleccione un Proceso N2</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcessN2']").html(listItems);
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de ProductIndex.loadCustomers
 */
ProductIndex.getProcess2Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}

ProductIndex.getProcess3Options = function () {
    var dataParameters = {
        processId: $("select[id$='ddlProcessN2']").val()
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
            ProductIndex.getProcess3Options_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ProductIndex.getProcess3Options_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess del ProductIndex.getProcess1Options
 */
ProductIndex.getProcess3Options_onSucces = function (result) {
    $("select[id$='ddlProcessN3']").html('<option value="">Seleccione un Proceso N3</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='ddlProcessN3']").html('');
            var listItems = '<option value="">Seleccione un Proceso N3</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='ddlProcessN3']").html(listItems);
        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de ProductIndex.loadCustomers
 */
ProductIndex.getProcess3Options_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}


ProductIndex.btnSave_Click = function (event) {
    $("#formProduct").validationEngine({ autoHidePrompt: true, autoHideDelay: 5000 });
    // Validar formulario
    if ($("#formProduct").validationEngine('validate')) {
        ProductIndex.showProductInfoPopup();
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

ProductIndex.showProductInfoPopup = function () {
    var $dialogContainer = $("#divProductTableContainer");
    var $detachedChildren = $dialogContainer.children().detach();
    $dialogContainer.dialog({
        width: 450, height: 550, autoOpen: false, modal: true,
        draggable: false, resizable: false,
        title: 'Vista Previa',
        open: function (event, ui) {
            $detachedChildren.appendTo($dialogContainer);
            ShowProductInfo.initializeComponents();
        },
        close: function (event, ui) {
            //ShowTripInfo.clearTripInfo();
            //$("#frmSiteMaster").validationEngine('hide');
            //$("#frmSiteMaster").validationEngine('detach');
        }
    });
    $dialogContainer.dialog('open');
}

ProductIndex.btnAddPickItems_Click = function (event) {
    var element = $("input[id$='txtPertinencesItem']").val();
    if (!CommonUtils.isNullOrEmpty(element)) {
        var item = ProductIndex.createPickingItemList(element);
        $("#ulPickingItems").append(item);
        $("#ulPickingItems").selectable();
        ProductIndex.initializeControlButtons();
        $("input[id$='txtPertinencesItem']").val('');
    }
    event.preventDefault();
}

ProductIndex.ddlReliability_SelectedIndexChanged = function () {
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
        $("#txtSamplesMeasured").val(parseInt(n));
    }
}

//Crear item para pickingList
ProductIndex.createPickingItemList = function (countItems) {
    var listItem = '<li style="text-align:left;" class="ui-state-default"> ' +
                        '<table style="width:100%;">' +
                            '<tr>' +
                                '<td style="width:80%;">' +
                                    '<span></span>' + countItems +
                                    '<input type="hidden" name="hdnCountItems" value="' + countItems + '" />' +
                                '</td>' +
                                '<td style="width:20%; text-align:right;">';
    //Boton de eliminar item.
    var deleteButton = ProductIndex.deleteButtonPickingItemList();
    var endListItem = '</td>' +
                      '</tr>' +
                     '</table>' +
                    '</li>';
    listItem = String.format("{0}{1}{2}", listItem, deleteButton, endListItem);
    return listItem;
};

//Boton de eliminar para pickingList item
ProductIndex.deleteButtonPickingItemList = function () {
    var deleteButton = '<button type="submit" name="btnDelete" ' +
                            'title="Eliminar" ' +
                            'class="button" style="background: blue; padding: 3px; width: auto; height: auto; text-align: center; color: white; border: #1C78DE">' +
                            'X' +
                        '</button>';
    return deleteButton;
}

//Inicializar botones para control de picking list.
ProductIndex.initializeControlButtons = function () {
    /*Quitar evento clic de botones*/
    $("#ulPickingItems li table tbody tr td button[name='btnDelete']").unbind("click");

    /*Eliminar escala*/
    $("#ulPickingItems li table tbody tr td button[name='btnDelete']").on('click', function () {
        $(this).closest("table").parent("li").remove();
    });
}