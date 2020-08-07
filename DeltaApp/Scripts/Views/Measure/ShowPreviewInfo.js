// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2016/02/23.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones javascript de vista parcial de formulario popup 'vista previa' de 
//                  creacion de Medición.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================

function ShowMeasureInfo() { }

/*
 * Indice de tab de seleccion origen destino
 */

ShowMeasureInfo.TABS_PRODUCT_WITH_CODE_INDEX = 0
/**
 * Indice de tab de seleccion de tipo de oportunidad 'anticipo'
 */
ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_ADVANCE = 0
/**
 * Indice de tab de seleccion de tipo de oportunidad 'retrazo'
 */
ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_DELAY = 1
/**
 * Indice de tab de seleccion de tipo de oportunidad 'fecha acordada'
 */
ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_ACCORDDATE = 2
/**
 * Tipo de vehiculo cabina.
 */
ShowMeasureInfo.TABS_MEASUREMENT_100 = 0;
/**
 * Tipo de vehiculo furgonado.
 */
ShowMeasureInfo.TABS_MEASUREMENT_AMOUNT = 1;


ShowMeasureInfo.initializeComponents = function () {
    $("#btnSaveProductInfoPopup").unbind("click");
    $("#btnCancelProductInfoPopup").unbind("click");
    $("#btnSaveProductInfoPopup").button().click(function (event) {
        $.msg({
            autoUnblock: false,
            clickUnblock: false
            //content: MasterSite.getLoadingImage()
        });
        setTimeout(function () {
            ShowMeasureInfo.btnSaveProductInfoPopup_Click(event);
        }, 500);
        event.preventDefault();
    });
    $("#btnCancelProductInfoPopup").button().click(ShowMeasureInfo.btnCancelProductInfoPopup_Click);
    ShowMeasureInfo.ClearMeasureInfo();
    ShowMeasureInfo.ShowMeasureInfo();
}

/**
 * Mostrar informacion del viaje
 */
ShowMeasureInfo.ShowMeasureInfo = function () {
    // Cuenta Reproceso.
    var reprocessCount = $("input[id$='txtreprocessCount']").val();
    $("#lblRepCountInfoPopup").text(reprocessCount);
    // Nombre del Producto.
    $("#lblproductNameInfoPopup").text($("select[id$='ddlProducto']").children("option:selected").text());
    // Sigla
    var initial = $("input[id$='txtInitial']").val();
    $("#lblInitialInfoPopup").text(initial);
    // Codigo
    var productCode = ShowMeasureInfo.getSelectedProductCode();
    $("#lblCodeInfoPopup").text(productCode);
    //Proceso
    var selectedProcess = $("input[id$='txtProcessN0']").val();
    $("#lblProcessInfoPopup").text(selectedProcess);
    //Procedimiento N1
    ShowMeasureInfo.showProcessN1Info();
    // Procedimiento N2
    ShowMeasureInfo.showProcessN2Info();
    //Procedimiento N3
    ShowMeasureInfo.showProcessN3Info();
    //Tipo oportunidad.
    var selectedOpportunityType = ShowMeasureInfo.getSelectedOportunityType();
    $("#lblOpportunityTypeInfoPopup").text(selectedOpportunityType);
    //Cumplimiento Oportunidad
    var OpportunityTypeOK = ShowMeasureInfo.getOportunityOK();
    $("#lblOpOkInfoPopup").text(OpportunityTypeOK);

    // Punto de referencia
    ShowMeasureInfo.showPointReference();
   // ShowMeasureInfo.ShowOportunityOK();
    ShowMeasureInfo.showPickingProductInfo();
    $.msg('unblock');
}




/**
 * Mostrar informacion de proceso n1
 */
ShowMeasureInfo.showProcessN1Info = function () {
    if ($("input[id$='txtProcessN1']").val() != "") {
        $("#tbProcessN1InfoPopup").css("display", 'table');
        $("#lblProcessN1InfoPopup").text($("input[id$='txtProcessN1']").val());
    }
}

/**
 * Mostrar informacion de proceso n2 
 */
ShowMeasureInfo.showProcessN2Info = function () {
    if ($("input[id$='txtProcessN2']").val() != "") {
        $("#tbProcessN2InfoPopup").css("display", 'table');
        $("#lblProcessN2InfoPopup").text($("input[id$='txtProcessN2']").val());
    }
}

/**
 * Mostrar informacion de proceso n3 
 */
ShowMeasureInfo.showProcessN3Info = function () {
    if ($("input[id$='txtProcessN3']").val() != "") {
        $("#tbProcessN3InfoPopup").css("display", 'table');
        $("#lblProcessN3InfoPopup").text($("input[id$='txtProcessN3']").val());
    }
}

ShowMeasureInfo.showPointReference = function () {

    $("#tbRefPointInfoPopup").css("display", 'none');
    $("#lblReferencePointInfoPopup").text('');
    $("#tbRefPointDaysInfoPopup").css("display", 'none');
    $("#lblRefDayInfoPopup").text('');
    $("#tbRefPointHourInfoPopup").css("display", 'none');
    $("#lblRefHourInfoPopup").text('');
    $("#tbRefPointMinInfoPopup").css("display", 'none');
    $("#lblRefMinInfoPopup").text('');
    //lock control
    $("#tbDateInfoPopup").css("display", 'none');
    $("#lblDateInfoPopup").text('');

    if ($("input[id$='txtDReferencePoint']").val() != "") {
        $("#tbRefPointInfoPopup").css("display", 'table');
        $("#lblReferencePointInfoPopup").text($("input[id$='txtDReferencePoint']").val());

        $("#tbRefPointDaysInfoPopup").css("display", 'table');
        $("#lblRefDayInfoPopup").text($("input[id$='txtDDaysReferencePoint']").val());

        $("#tbRefPointHourInfoPopup").css("display", 'table');
        $("#lblRefHourInfoPopup").text($("input[id$='txtDHoursReferencePoint']").val());

        $("#tbRefPointMinInfoPopup").css("display", 'table');
        $("#lblRefMinInfoPopup").text($("input[id$='txtDMinuteReferencePoint']").val());


    } else if ($("input[id$='txtAReferencePoint']").val() != "") {
        $("#tbRefPointInfoPopup").css("display", 'table');
        $("#lblReferencePointInfoPopup").text($("input[id$='txtAReferencePoint']").val());


        $("#tbRefPointDaysInfoPopup").css("display", 'table');
        $("#lblRefDayInfoPopup").text($("input[id$='txtADaysReferencePoint']").val());

        $("#tbRefPointHourInfoPopup").css("display", 'table');
        $("#lblRefHourInfoPopup").text($("input[id$='txtAHoursReferencePoint']").val());

        $("#tbRefPointMinInfoPopup").css("display", 'table');
        $("#lblRefMinInfoPopup").text($("input[id$='txtAMinuteReferencePoint']").val());


    } else if ($("input[id$='txtOpportunityTypeAccordDate']").val() != "") {
        $("#tbDateInfoPopup").css("display", 'table');
        $("#lblDateInfoPopup").text($("input[id$='txtOpportunityTypeAccordDate']").val());

    }
}

ShowMeasureInfo.showDelayDetail = function (isOK) {

    $("#tbOpDInfoPopup").css("display", 'table');
    $("#lblOpDInfoPopup").text($("input[id$='txtMeasureDaysReferencePoint']").val());

    $("#tbOpHInfoPopup").css("display", 'table');
    $("#lblOpHInfoPopup").text($("input[id$='txtMeasureHoursReferencePoint']").val());

    $("#tbOpMInfoPopup").css("display", 'table');
    $("#lblOpMInfoPopup").text($("input[id$='txtMeasureMinuteReferencePoint']").val());
   
}


ShowMeasureInfo.showMeasurementGoal = function () {
    var selectedProductCode = $("#tabsMeasurement").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowMeasureInfo.TABS_MEASUREMENT_100:
            ShowMeasureInfo.showMeasurement100Info();
            break;
        case ShowMeasureInfo.TABS_MEASUREMENT_AMOUNT:
            ShowMeasureInfo.showSampleMeasurementAmountInfo();
            break;
        default:
            ShowMeasureInfo.showMeasurement100Info();
            break;
    }
}

ShowMeasureInfo.showMeasurement100Info = function () {
    $("#tbMeasurementAmountInfoPopup").css("display", 'table');
    $("#lblMeasurementAmountInfoPopup").text($("input[id$='txtMeasurementAmount']").val());
}


ShowMeasureInfo.showSampleMeasurementAmountInfo = function () {
    $("#tbRepresentativeSampleInfoPopup").css("display", 'table');
    $("#lblPopulationInfoPopup").text($("input[id$='txtPopulation']").val());
    $("#lblReliabilityInfoPopup").text($("select[id$='ddlReliability']").children("option:selected").text());
    $("#lblSamplesMeasuredInfoPopup").text($("input[id$='txtSamplesMeasured']").val());
}

ShowMeasureInfo.ClearMeasureInfo = function () {
    // Cuenta Reproceso.
    $("#lblRepCountInfoPopup").text('');
    // Nombre del Producto.
    $("#lblproductNameInfoPopup").text('');
    // Sigla
    $("#lblInitialInfoPopup").text('');
    // Codigo

    $("#lblCodeInfoPopup").text('');
    //Proceso
    $("#lblProcessInfoPopup").text('');
    //Procedimiento N1
    $("#lblProcessN1InfoPopup").text('');
    $("#tbProcessN1InfoPopup").css("display", 'none');
    // Procedimiento N2
    $("#lblProcessN2InfoPopup").text('');
    $("#tbProcessN2InfoPopup").css("display", 'none');
    //Procedimiento N3
    $("#lblProcessN3InfoPopup").text('');
    $("#tbProcessN3InfoPopup").css("display", 'none');
    //Tipo oportunidad.
    $("#lblOpportunityTypeInfoPopup").text('');
    // Punto de referencia
    $("#lblReferencePointInfoPopup").text('');
    //Dias
    $("#lblDaysReferencePointInfoPopup").text('');
    // Horas
    $("#lblHoursReferencePointInfoPopup").text('');
    // Minutos
    $("#lblMinutesReferencePointInfoPopup").text('');
    // Mostrar informacion de Pertinecias
    ShowMeasureInfo.showPickingProductInfo();

}

/**
 * Mostrar informacion de pickings asociados al viaje
 */
ShowMeasureInfo.showPickingProductInfo = function () {
    $("#divSelectedPickNumber").html('');
    if ($("#pertContainer").length > 0) {
        var listItems = $("#pertContainer").find('input');;
        selectedItems = '';
        $.each(listItems, function (i, item) {
            var pertinenceValue = "No Cumple";

            if ($("input[id$='pert" + (i + 1) + "']").is(":checked")) {
                pertinenceValue = "Cumple";
            }

            var itemValue = $("input[id$='pert" + (i + 1) + "']").val() + " : " + pertinenceValue;
            selectedItems += '<label style="font-weight:normal;">' + itemValue + '</label> </br>';
        });
        $("#tbProductInfoPickingPopup").css("display", 'table');
        $("#divSelectedPickNumber").html(selectedItems);
    }
}


/*
 * Obtener codigo de producto
 */
ShowMeasureInfo.getSelectedProductCode = function () {
    var selectedProductCodeValue = '';
    var selectedProductCode = $("#tabsProductCode").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowMeasureInfo.TABS_PRODUCT_WITH_CODE_INDEX:
            var codeProduct = $("input[id$='txtNewProductCode']").val();
            selectedProductCodeValue = codeProduct;
            break;
        default:
            selectedProductCodeValue = $("input[id$='txtNewProductNoCode']").val();;
            break;
    }
    return selectedProductCodeValue;
}

/*
 * Obtener tipo de oportunidad
 */
ShowMeasureInfo.getSelectedOportunityType = function () {
    var selectedOportunityTypeValue = '';
    var selectedProductCode = $("#tabsOpportunityType").tabs('option', 'active');
    switch (selectedProductCode) {
        case ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = 'Anticipo';
            break;
        case ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            selectedOportunityTypeValue = 'Retraso';
            break;
        case ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_ACCORDDATE:
            var opportunityTypeAccordDate = $("input[id$='txtOpportunityTypeAccordDate']").val();
            selectedOportunityTypeValue = 'Fecha Acordada';
            break;
        default:
            selectedOportunityTypeValue = 'NO';
            break;
    }
    return selectedOportunityTypeValue;
}

/*
 * Obtener Cumplimiento de  oportunidad
 */
ShowMeasureInfo.getOportunityOK = function () {
    var selectedOportunityTypeValue = '';
    var selectedOportunityOK = $("#tabsOportunityDelivery").tabs('option', 'active');
    switch (selectedOportunityOK) {
        case ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_ADVANCE:
            selectedOportunityTypeValue = 'Sí';

            $("#tbOpDInfoPopup").css("display", 'none');
            $("#lblOpDInfoPopup").text('');

            $("#tbOpHInfoPopup").css("display", 'none');
            $("#lblOpHInfoPopup").text('');

            $("#tbOpMInfoPopup").css("display", 'none');
            $("#lblOpMInfoPopup").text('');

            break;
        case ShowMeasureInfo.TABS_OPPORTUNITY_TYPE_DELAY:
            ShowMeasureInfo.showDelayDetail();
            selectedOportunityTypeValue = 'No';
            break;
        default:
            selectedOportunityTypeValue = 'NO';
            ShowMeasureInfo.showDelayDetail();
            break;
    }
    return selectedOportunityTypeValue;
}


/**
 * Guardar el viaje
 */
ShowMeasureInfo.saveMeasure = function () {
    var dataParameters = ShowMeasureInfo.getSaveProductDataParameters();
    var urlPage = '/Measure/CreateMeasure';
    $.ajax({
        url: urlPage,
        data: JSON.stringify(dataParameters),
        method: "POST",
        contentType: "application/json",
        dataType: "json",
        cache: false,
        success: function (result) {
            ShowMeasureInfo.saveMeasure_onSucces(result);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ShowMeasureInfo.saveMeasure_onError(jqXHR, textStatus, errorThrown);
        }
    });

}

/**
 * Manejador onSuccess de ShowMeasureInfo.saveProduct
 */
ShowMeasureInfo.saveMeasure_onSucces = function (result) {
    if (result != null) {
        if (result.errorMessage == null) {
            Lobibox.notify('success', {
                size: 'mini',
                rounded: true,
                msg: 'Cambios Guardados',
                sound: false
            });
            location.reload(false);
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
        else {
            Lobibox.notify('error', {
                size: 'mini',
                rounded: true,
                msg: result.d.errorMessage,
                sound: false
            });
        }
    
    
    
    var $dialogContainer = $("#divMeasureTableContainer");
    $dialogContainer.dialog('close');
    $.msg('unblock');

};

/**
 * Manejador onError de ShowMeasureInfo.saveProduct
 */
ShowMeasureInfo.saveMeasure_onError = function (jqXHR, textStatus, errorThrown) {
    alert(textStatus + ' error en carga de clientes.');
}

ShowMeasureInfo.showGenerateProductWithSameCustomePopup = function () {
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
 * Obtener informacion de pickings seleccionados
 */
ShowMeasureInfo.getPickingItems = function () {
    var selectedItems = '';

    if ($("#pertContainer").length > 0) {
        var listItems = $("#pertContainer").find('input');;
        $.each(listItems, function (i, item) {
            var inputValue = 0;
            if (($("input[id$='pert" + (i + 1) + "']").is(":checked"))) {
                inputValue = 1;
            }
            selectedItems += "|" + $("input[id$='pert" + (i + 1) + "']").val() + "/   " + inputValue;
        });
    }

    return selectedItems;

}

/**
 * Manejador clic del boton crear.
 */
ShowMeasureInfo.btnSaveProductInfoPopup_Click = function (event) {
    ShowMeasureInfo.saveMeasure();
    $("#divProductInfoTableContainer").dialog("close");
    event.preventDefault();
}

ShowMeasureInfo.btnCancelProductInfoPopup_Click = function (event) {
    $("#divProductInfoTableContainer").dialog("close");
    event.preventDefault();
}

/**
 * Obtener valor de control de pickings.
 */
ShowMeasureInfo.getSelectedSortableControlValue = function (parentControlContainer, controlName) {
    var controlValue = ''
    if (parentControlContainer != null && !CommonUtils.isNullOrEmpty(controlName)) {
        var selectedControl = String.format("input[name='{0}']", controlName);
        controlValue = $(parentControlContainer).find(selectedControl).val();
    }
    return controlValue;
}

ShowMeasureInfo.getSaveProductDataParameters = function () {
    var callProcedurex = new String( "CALL `planhnd_DeltaBD`.`INSERT_MEASURE`(" + $("select[id$='ddlProducto']").val() +
                                        "," +  $("input[id$='txtInitial']").val() +
                                        "," + ShowMeasureInfo.getRastCode() +
                                        "," + 9 +
                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlArea']").val()) ? null : $("select[id$='ddlArea']").val()) +
                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN1']").val()) ? null : $("select[id$='ddlDivisionN1']").val()) +
                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN2']").val()) ? null : $("select[id$='ddlDivisionN2']").val()) +
                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN3']").val()) ? null : $("select[id$='ddlDivisionN3']").val()) +
                                        "," +($("#tabsOportunityDelivery").tabs('option', 'active') == 0 ? true : false) +
                                        "," + $("input[id$='txtMeasureDaysReferencePoint']").val() +
                                        "," + $("input[id$='txtMeasureHoursReferencePoint']").val() +
                                        "," +$("input[id$='txtMeasureMinuteReferencePoint']").val()  +
                                        "," + (ShowMeasureInfo.GetisMsrOk()) +
                                        "," + ShowMeasureInfo.GetisPertOk() +
                                        ",'" + ShowMeasureInfo.getPickingItems() +
                                        "', @res); SELECT @res");

    /*var callProcedurex = new String ("CALL DeltaBD.INSERT_MEASURE(" + $("select[id$='ddlProducto']").val() +
                                                        "," + $("input[id$='txtInitial']").val() +
                                                        "," + ShowMeasureInfo.getRastCode() +
                                                        "," + "9" +
                                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlArea']").val()) ? null : $("select[id$='ddlArea']").val()) +
                                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN1']").val()) ? null : $("select[id$='ddlDivisionN1']").val()) +
                                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN2']").val()) ? null : $("select[id$='ddlDivisionN2']").val()) +
                                                        "," + (CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN3']").val()) ? null : $("select[id$='ddlDivisionN3']").val()) +
                                                        "," + ($("#tabsOportunityDelivery").tabs('option', 'active') == 0 ? true : false) +
                                                        "," + $("input[id$='txtMeasureDaysReferencePoint']").val() +
                                                        "," + $("input[id$='txtMeasureHoursReferencePoint']").val() +
                                                        "," + $("input[id$='txtMeasureMinuteReferencePoint']").val() +
                                                        "," + (ShowMeasureInfo.GetisMsrOk()) +
                                                        ",'" + ShowMeasureInfo.getPickingItems() +
                                                        "', @res); SELECT @res");*/
    var poit = callProcedurex;

    var dataParameters = {

        //Informacion de Producto
        PDT_ID: $("select[id$='ddlProducto']").val(),
        PDT_SIGLA: $("input[id$='txtInitial']").val(),
        PDT_RAST_CODE: ShowMeasureInfo.getRastCode(),
        USR_ID: 3,
        //Informacion Area
        AREA_ID: CommonUtils.isNullOrEmpty($("select[id$='ddlArea']").val()) ? null : $("select[id$='ddlArea']").val(),
        DIV_N1_ID: CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN1']").val()) ? null : $("select[id$='ddlDivisionN1']").val(),
        DIV_N2_ID: CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN2']").val()) ? null : $("select[id$='ddlDivisionN2']").val(),
        DIV_N3_ID: CommonUtils.isNullOrEmpty($("select[id$='ddlDivisionN3']").val()) ? null : $("select[id$='ddlDivisionN3']").val(),
        PDT_DELIVERY_OPT: $("#tabsOportunityDelivery").tabs('option', 'active') == 0 ? true : false,
        MSR_DAYS: $("input[id$='txtMeasureDaysReferencePoint']").val(),
        MSR_HOUR: $("input[id$='txtMeasureHoursReferencePoint']").val(),
        MSR_MINUTES: $("input[id$='txtMeasureMinuteReferencePoint']").val(),
        isMsrOk: ShowMeasureInfo.GetisMsrOk(),
        pertOK: ShowMeasureInfo.GetisPertOk(),
        checkList: ShowMeasureInfo.getPickingItems()
    }

    
    return dataParameters;
}

ShowMeasureInfo.getRastCode = function () {

    var rastCode = $("#tabsProductCode").tabs('option', 'active') == 0 ? true : false;
    if (rastCode) {

        return $("input[id$='txtNewProductCode']").val();

    } else {

        var value = $("input[id$='txtNewProductNoCode']").val();
        return  value;
    }

}

ShowMeasureInfo.GetisMsrOk = function () {
    var isMsrOk = true;

    if ($("#pertContainer").length > 0) {
        var listItems = $("#pertContainer").find('input');;
        $.each(listItems, function (i, item) {

            if (!$("input[id$='pert" + (i + 1) + "']").is(":checked")) {
                isMsrOk = false;
            }
        });

        var oportunityIsOK = $("#tabsOportunityDelivery").tabs('option', 'active') == 0 ? true : false;

        if (isMsrOk && oportunityIsOK) {
            return isMsrOk;
        } else {
            return false;
        }
    }

}

ShowMeasureInfo.GetisPertOk = function () {
    var isMsrOk = true;

    if ($("#pertContainer").length > 0) {
        var listItems = $("#pertContainer").find('input');;
        $.each(listItems, function (i, item) {

            if (!$("input[id$='pert" + (i + 1) + "']").is(":checked")) {
                isMsrOk = false;
            }
        });

        return isMsrOk;
    }

}