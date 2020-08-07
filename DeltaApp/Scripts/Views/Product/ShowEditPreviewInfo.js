// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2016/02/23.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones javascript de vista parcial de formulario popup 'vista previa' de 
//                  creacion de producto.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================

function ShowEditProductInfo() { }

/*
 * Indice de tab de seleccion origen destino
 */

ShowEditProductInfo.TABS_PRODUCT_WITH_CODE_INDEX = 0
/**
 * Indice de tab de seleccion de tipo de oportunidad 'anticipo'
 */
ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ADVANCE = 0
/**
 * Indice de tab de seleccion de tipo de oportunidad 'retrazo'
 */
ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_DELAY = 1
/**
 * Indice de tab de seleccion de tipo de oportunidad 'fecha acordada'
 */
ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ACCORDDATE = 2
/**
 * Tipo de vehiculo cabina.
 */
ShowEditProductInfo.TABS_MEASUREMENT_100 = 0;
/**
 * Tipo de vehiculo furgonado.
 */
ShowEditProductInfo.TABS_MEASUREMENT_AMOUNT = 1;


ShowEditProductInfo.initializeComponents = function () {
    $("#btnSaveProductInfoPopup").unbind("click");
    $("#btnCancelProductInfoPopup").unbind("click");
    $("#btnSaveProductInfoPopup").button().click(function (event) {
        $.msg({
            autoUnblock: false,
            clickUnblock: false
            //content: MasterSite.getLoadingImage()
        });
        setTimeout(function () {
            ShowEditProductInfo.btnSaveProductInfoPopup_Click(event);
        }, 500);
        event.preventDefault();
    });
    $("#btnCancelProductInfoPopup").button().click(ShowEditProductInfo.btnCancelProductInfoPopup_Click);
    ShowEditProductInfo.ShowProductInfo();
}

/**
 * Mostrar informacion del producto
 */
ShowEditProductInfo.ShowProductInfo = function () {
    // Nombre del cliente.
    var productName = $("input[id$='txtProductName']").val();
    $("#lblProductNameInfoPopup").text(productName);
    // Sigla
    var initial = $("input[id$='txtInitial']").val();
    $("#lblProductInitialInfoPopup").text(initial);
    // Codigo
    var productCode = ShowEditProductInfo.getSelectedProductCode();
    $("#lblProductCodeInfoPopup").text(productCode);
    //Proceso
    var selectedProcess = $("select[id$='ddlProcess']").children("option:selected").text()
    $("#lblProcessInfoPopup").text(selectedProcess);
    //Procedimiento N1
    var selectedProcessN1 = $("select[id$='ddlProcessN1']").children("option:selected").text()
    $("#lblProcessN1InfoPopup").text(selectedProcessN1);
    // Procedimiento N2
    ShowEditProductInfo.showProcessN2Info();
    //Procedimiento N3
    ShowEditProductInfo.showProcessN3Info();
    //Tipo oportunidad.
    var selectedOpportunityType = ShowEditProductInfo.getSelectedOportunityType();
    $("#lblOpportunityTypeInfoPopup").text(selectedOpportunityType);
    // Punto de referencia
    var selectedReferencePoint = $("#txtReferencePoint").val();
    $("#lblReferencePointInfoPopup").text(selectedReferencePoint);
    //Dias
    var selectedDaysReferencePoint = $("#txtDaysReferencePoint").val();
    $("#lblDaysReferencePointInfoPopup").text(selectedDaysReferencePoint);
    // Horas
    var selectedHoursReferencePoint = $("#txtHoursReferencePoint").val();
    $("#lblHoursReferencePointInfoPopup").text(selectedHoursReferencePoint);
    // Minutos
    var selectedMinuteReferencePoint = $("#txtMinuteReferencePoint").val()
    $("#lblMinutesReferencePointInfoPopup").text(selectedMinuteReferencePoint);
    // Meta medicion
    ShowEditProductInfo.showMeasurementGoal()
    // Mostrar informacion de picking
    ShowEditProductInfo.showPickingProductInfo();
    $.msg('unblock');
}

/**
 * Mostrar informacion de proceso n2 
 */
ShowEditProductInfo.showProcessN2Info = function () {
    if ($("select[id$='ddlProcessN2']").val() != "") {
        $("#tbProcessN2InfoPopup").css("display", 'table');
        $("#lblProcessN2InfoPopup").text($("select[id$='ddlProcessN2']").children("option:selected").text());
    }
}

/**
 * Mostrar informacion de proceso n3 
 */
ShowEditProductInfo.showProcessN3Info = function () {
    if ($("select[id$='ddlProcessN3']").val() != "") {
        $("#tbProcessN3InfoPopup").css("display", 'table');
        $("#lblProcessN3InfoPopup").text($("select[id$='ddlProcessN3']").children("option:selected").text());
    }
}


ShowEditProductInfo.showMeasurementGoal = function () {
    var selectedProductCode = $("#tabsMeasurement").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_MEASUREMENT_100:
            ShowEditProductInfo.showMeasurement100Info();
            break;
        case ShowEditProductInfo.TABS_MEASUREMENT_AMOUNT:
            ShowEditProductInfo.showSampleMeasurementAmountInfo();
            break;
        default:
            ShowEditProductInfo.showMeasurement100Info();
            break;
    }
}

ShowEditProductInfo.showMeasurement100Info = function () {
    $("#tbMeasurementAmountInfoPopup").css("display", 'table');
    $("#lblMeasurementAmountInfoPopup").text($("input[id$='txtMeasurementAmount']").val());
}


ShowEditProductInfo.showSampleMeasurementAmountInfo = function () {
    $("#tbRepresentativeSampleInfoPopup").css("display", 'table');
    $("#lblPopulationInfoPopup").text($("input[id$='txtPopulation']").val());
    $("#lblReliabilityInfoPopup").text($("select[id$='ddlReliability']").children("option:selected").text());
    $("#lblSamplesMeasuredInfoPopup").text($("input[id$='txtSamplesMeasured']").val());
}



/**
 * Mostrar informacion de pickings asociados al viaje
 */
ShowEditProductInfo.showPickingProductInfo = function () {
    $("#divSelectedPickNumber").html('');
    if ($("#ulPickingItems li").length > 0) {
        var listItems = $("#ulPickingItems li");
        selectedItems = '';
        $.each(listItems, function (i, item) {
            var itemValue = ShowEditProductInfo.getSelectedSortableControlValue(item, 'hdnCountItems');
            selectedItems += '<label style="font-weight:normal;">' + itemValue + '</label> </br>';
        });
        $("#tbProductInfoPickingPopup").css("display", 'table');
        $("#divSelectedPickNumber").html(selectedItems);
    }
}


/*
 * Obtener codigo de producto
 */
ShowEditProductInfo.getSelectedProductCode = function () {
    var selectedProductCodeValue = '';
    var selectedProductCode = $("#tabsProductCode").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_PRODUCT_WITH_CODE_INDEX:
            selectedProductCodeValue = 'SI';
            break;
        default:
            selectedProductCodeValue = 'NO';
            break;
    }
    return selectedProductCodeValue;
}

/*
 * Obtener tipo de oportunidad
 */
ShowEditProductInfo.getSelectedOportunityType = function () {
    $("#tbOportuniteAnticipoRetrasoPopup").css("display", 'none');
    $("#tbOportuniteDatePopup").css("display", 'none');
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = 'Anticipo';
            $("#tbOportuniteAnticipoRetrasoPopup").css("display", 'table');
            $("#lblReferencePointInfoPopup").text($("input[id$='txtReferencePointAdvance']").val());
            $("#lblDaysReferencePointInfoPopup").text($("input[id$='txtDaysReferencePointAdvance']").val());
            $("#lblHoursReferencePointInfoPopup").text($("input[id$='txtHoursReferencePointAdvance']").val());
            $("#lblMinutesReferencePointInfoPopup").text($("input[id$='txtMinuteReferencePointAdvance']").val());
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            selectedOportunityTypeValue = 'Retrazo';
            $("#tbOportuniteAnticipoRetrasoPopup").css("display", 'table');
            $("#lblReferencePointInfoPopup").text($("input[id$='txtReferencePointDelay']").val());
            $("#lblDaysReferencePointInfoPopup").text($("input[id$='txtDaysReferencePointDelay']").val());
            $("#lblHoursReferencePointInfoPopup").text($("input[id$='txtHoursReferencePointDelay']").val());
            $("#lblMinutesReferencePointInfoPopup").text($("input[id$='txtMinuteReferencePointDelay']").val());
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ACCORDDATE:
            $("#tbOportuniteDatePopup").css("display", 'table');
            $("#lblOpportunityTypeAccordDateInfoPopup").text($("input[id$='txtOpportunityTypeAccordDate']").val());
            selectedOportunityTypeValue = 'Fecha Acordada';
            break;
        default:
            selectedOportunityTypeValue = 'NO';
            break;
    }
    return selectedOportunityTypeValue;
};

/**
 * Guardar el viaje
 */
ShowEditProductInfo.saveProduct = function () {
    var dataParameters = ShowEditProductInfo.getSaveProductDataParameters();
    var urlPage = '/Product/UpdateProduct';
    $.ajax({
        url: urlPage,
        data: JSON.stringify(dataParameters),
        method: "POST",
        contentType: "application/json",
        dataType: "json",
        cache: false,
        success: function (result) {
            ShowEditProductInfo.saveProduct_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ShowEditProductInfo.saveProduct_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/**
 * Manejador onSuccess de ShowEditProductInfo.saveProduct
 */
ShowEditProductInfo.saveProduct_onSucces = function (result) {
    if (result != null) {
        if (result.errorMessage == null) {
            var resultMessage = result.resultMessage;
            var notifySize = resultMessage.length > 80 ? 'normal' : 'mini';
            Lobibox.notify('success', {
                size: notifySize,
                rounded: true,
                msg: resultMessage,
                sound: false
            });
            setTimeout(function () {
                window.location.href = '/Product/EditIndex';
            }, 2000);
        }
        else {
            Lobibox.notify('error', {
                size: 'mini',
                rounded: true,
                msg: result.errorMessage,
                sound: false
            });
        }
    }
    $.msg('unblock');
};

/**
 * Manejador onError de ShowEditProductInfo.saveProduct
 */
ShowEditProductInfo.saveProduct_onError = function (jqXHR, textStatus, errorThrown) {
    alert(textStatus + ' error en carga de clientes.');
}

ShowEditProductInfo.showGenerateProductWithSameCustomePopup = function () {
    $("div[id$='divSameCustomerConfirmPopup']").dialog({
        resizable: false, autoOpen: false, modal: true, closeOnEscape: false,
        open: function (event, ui) {
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
        },
        height: 180, width: $(window).width() > 450 ? 450 : 'auto',
        buttons: [
            {
                text: "Si",
                click: function () {
                    $(this).dialog("close");
                    CreateProduct.clearControls(true);
                }
            },
            {
                text: "No",
                click: function () {
                    $(this).dialog("close");
                    CreateProduct.clearControls(false);
                }
            }
        ]
    });
    $("div[id$='divSameCustomerConfirmPopup']").dialog('open');
}

/**
 * Obtener valores para guardar viaje
 */
ShowEditProductInfo.getSaveProductDataParameters = function () {
    var dataParameters = {
        PDT_ID: $("input[id$='hdnProductId']").val(),
        PDT_NAME: $("input[id$='txtProductName']").val(),
        PDT_SIGLA: $("input[id$='txtInitial']").val(),
        PDT_HASCODE: $("#tabsProductCode").tabs('option', 'active') == ShowEditProductInfo.TABS_PRODUCT_WITH_CODE_INDEX ? true : false,
        PDT_CODE: $("#tabsProductCode").tabs('option', 'active') == ShowEditProductInfo.TABS_PRODUCT_WITH_CODE_INDEX ? $("input[id$='txtProductCode']").val() : "",
        PROC_N0_ID: $("select[id$='ddlProcess']").val(),
        PROC_N1_ID: $("select[id$='ddlProcessN1']").val(),
        PROC_N2_ID: $("select[id$='ddlProcessN2']").val(),
        PROC_N3_ID: $("select[id$='ddlProcessN3']").val(),
        PDT_DESC: $("input[id$='txtDescription']").val(),
        // Tipo de oportunidad
        OP_TYPE_ID: ShowEditProductInfo.getSelectedOportunityTypeId(),
        PDT_OPORTUNITY_DATE_ACCORDED: ShowEditProductInfo.getSelectedOportunityTypeDateTime(),
        PDT_OPORTUNITY_PTO_REF: ShowEditProductInfo.getSelectedOportunityTypeReference(),
        PDT_OPORTUNITY_DAYS: ShowEditProductInfo.getSelectedOportunityTypeDays(),
        PDT_OPORTUNITY_HOURS: ShowEditProductInfo.getSelectedOportunityTypeHours(),
        PDT_OPORTUNITY_MINUTES: ShowEditProductInfo.getSelectedOportunityTypeMinutes(),
        // Medicion
        GOAL_TYPE_ID: ShowEditProductInfo.showMeasurementGoalId(),
        GOAL_QUANTITY_MONTH: $("#tabsMeasurement").tabs('option', 'active') != ShowEditProductInfo.TABS_MEASUREMENT_AMOUNT ?
            $("input[id$='txtMeasurementAmount']").val() : '',
        GOAL_POBLATION: $("#tabsMeasurement").tabs('option', 'active') == ShowEditProductInfo.TABS_MEASUREMENT_AMOUNT ?
            $("input[id$='txtPopulation']").val() : '',
        GOAL_CONFIABILITY_INDEX: $("#tabsMeasurement").tabs('option', 'active') == ShowEditProductInfo.TABS_MEASUREMENT_AMOUNT ?
            $("select[id$='ddlReliability']").val() : '',
        GOAL_SAMPLES: $("#tabsMeasurement").tabs('option', 'active') == ShowEditProductInfo.TABS_MEASUREMENT_AMOUNT ?
            $("input[id$='txtSamplesMeasured']").val() : '',
        // Lista de chequeo
        checkList: ShowEditProductInfo.getPickingItems()
    }
    return dataParameters;
}


$("#lblPopulationInfoPopup").text($("input[id$='txtPopulation']").val());
$("#lblReliabilityInfoPopup").text($("select[id$='ddlReliability']").children("option:selected").text());
$("#lblSamplesMeasuredInfoPopup").text($("input[id$='txtSamplesMeasured']").val());

ShowEditProductInfo.showMeasurementGoalId = function () {
    var selectedProductCode = $("#tabsMeasurement").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_MEASUREMENT_100:
            return '1';
            break;
        case ShowEditProductInfo.TABS_MEASUREMENT_AMOUNT:
            return '2';
            break;
        default:
            return '1';
            break;
    }
}

ShowEditProductInfo.getSelectedOportunityTypeId = function () {
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = '1';
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            selectedOportunityTypeValue = '2';
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ACCORDDATE:
            selectedOportunityTypeValue = '3';
            break;
        default:
            selectedOportunityTypeValue = '1';
            break;
    }
    return selectedOportunityTypeValue;
}

ShowEditProductInfo.getSelectedOportunityTypeReference = function () {
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = $("input[id$='txtReferencePointAdvance']").val();
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            selectedOportunityTypeValue = $("input[id$='txtReferencePointDelay']").val();
            break;
        default:
            selectedOportunityTypeValue = '';
            break;
    }
    return selectedOportunityTypeValue;
};

ShowEditProductInfo.getSelectedOportunityTypeDays = function () {
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = $("input[id$='txtDaysReferencePointAdvance']").val();
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            selectedOportunityTypeValue = $("input[id$='txtDaysReferencePointDelay']").val();
            break;
        default:
            selectedOportunityTypeValue = '';
            break;
    }
    return selectedOportunityTypeValue;
};

ShowEditProductInfo.getSelectedOportunityTypeHours = function () {
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = $("input[id$='txtHoursReferencePointAdvance']").val();
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            selectedOportunityTypeValue = $("input[id$='txtHoursReferencePointDelay']").val();
            break;
        default:
            selectedOportunityTypeValue = '';
            break;
    }
    return selectedOportunityTypeValue;
};

ShowEditProductInfo.getSelectedOportunityTypeMinutes = function () {
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = $("input[id$='txtMinuteReferencePointAdvance']").val();
            break;
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            selectedOportunityTypeValue = $("input[id$='txtMinuteReferencePointDelay']").val();
            break;
        default:
            selectedOportunityTypeValue = '';
            break;
    }
    return selectedOportunityTypeValue;
};

ShowEditProductInfo.getSelectedOportunityTypeDateTime = function () {
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowEditProductInfo.TABS_OPPORTUNITY_TYPE_ACCORDDATE:
            selectedOportunityTypeValue = $("input[id$='txtOpportunityTypeAccordDate']").val();
            break;
        default:
            selectedOportunityTypeValue = '';
            break;
    }
    return selectedOportunityTypeValue;
};

/**
 * Obtener informacion de pickings seleccionados
 */
ShowEditProductInfo.getPickingItems = function () {
    var selectedItems = '';
    if ($("#ulPickingItems li").length > 0) {
        var listItems = $("#ulPickingItems li");
        $.each(listItems, function (i, item) {
            var itemValue = ShowEditProductInfo.getSelectedSortableControlValue(item, 'hdnCountItems');
            selectedItems += "|" + itemValue;
        });
    }
    return selectedItems;
}

/**
 * Limpiar controls de informacion de viaje
 */
ShowEditProductInfo.clearProductInfo = function () {
    $("label[id$='lblproductNameProductInfoPopup']").text('')
    $("label[id$='lblRouteNameProductInfoPopup']").text('')
    $("label[id$='lblProgrammedDateProductInfoPopup']").text('')
    $("label[id$='lblManifestProductInfoPopup']").text('')
    $("label[id$='lblOrderProductInfoPopup']").text('')
    $("label[id$='lblContainerProductInfoPopup']").text('')
    $("label[id$='lblTransportProductInfoPopup']").text('')
    $("label[id$='lblVehiclePlateProductInfoPopup']").text('')
    $("label[id$='lblDriverIdentificationProductInfoPopup']").text('')
    $("label[id$='lblDriverNameProductInfoPopup']").text('')
    $("label[id$='lblDriverPhoneProductInfoPopup']").text('')
    $("#tbProductInfoTemperaturePopup").css("display", 'none');
    $("label[id$='lblMinTemperature']").text('');
    $("label[id$='lblMaxTemperature']").text('');
    $("#tbProductInfoProgrammedPopup").css("display", 'none');
    $("label[id$='lblInitialTimeProgrammed']").text('');
    $("label[id$='lblEndTimeProgrammed']").text('');
    $("#tbProductInfoPickingPopup").css("display", 'none');
    $("label[id$='lblSelectedPickingNumber']").text('');
    $("#tbProductInfoDissambleDateInfoPopup").css("display", 'none');
    $("label[id$='lblDisassemblyDateProductInfoPopup']").text('');
    $("label[id$='lblDisassemblyHourProductInfoPopup']").text('');
    $("#tbProductInfoSubCustomerInfoPopup").css("display", 'none');
    $("label[id$='lblSubproductNameProductInfoPopup']").text('');
};

/**
 * Manejador clic del boton crear.
 */
ShowEditProductInfo.btnSaveProductInfoPopup_Click = function (event) {
    ShowEditProductInfo.saveProduct();
    $("#divProductTableContainer").dialog("close");
    event.preventDefault();
}

ShowEditProductInfo.btnCancelProductInfoPopup_Click = function (event) {
    $("#divProductTableContainer").dialog("close");
    event.preventDefault();
}

/**
 * Obtener valor de control de pickings.
 */
ShowEditProductInfo.getSelectedSortableControlValue = function (parentControlContainer, controlName) {
    var controlValue = ''
    if (parentControlContainer != null && !CommonUtils.isNullOrEmpty(controlName)) {
        var selectedControl = String.format("input[name='{0}']", controlName);
        controlValue = $(parentControlContainer).find(selectedControl).val();
    }
    return controlValue;
}

