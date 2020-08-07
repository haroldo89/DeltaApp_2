function MeasureIndex() { }

MeasureIndex.initializeComponents = function () {

    $(document).ajaxStart(function () {
        $.blockUI({ message: '<h1><img src="Content/Images/loading1.gif" /> Cargando Registros...</h1>' });
    }).ajaxStop($.unblockUI);

    //Carga de Vaores por Defecto de los Controles DDL
    MeasureIndex.getddlOptions("GetProductOptions", "ddlProducto", "Seleccione un Producto");
    MeasureIndex.getddlOptions("GetAreaOptions", "ddlArea", "Seleccione un Area");
    MeasureIndex.getddlOptionswithParametter("GetDivisionN1Options", "ddlDivisionN1", "Seleccione una División N1", { areaID: $("select[id$='ddlArea']").val() });
    MeasureIndex.getddlOptionswithParametter("GetDivisionN2Options", "ddlDivisionN2", "Seleccione una División N2", { divisionN1Id: $("select[id$='ddlDivisionN1']").val() });
    MeasureIndex.getddlOptionswithParametter("GetDivisionN3Options", "ddlDivisionN3", "Seleccione una División N3", { divisionN3Id: $("select[id$='ddlDivisionN2']").val() });


    $("#tabsProductCode").tabs();

    var index = $('#tabsProductCode').index($('#tabsNoProductCode'));
    $('#tabsProductCode').tabs('option', 'active', index);
    $("#tabsProductCode").tabs({ disabled: [1, 2] });

    $("#tabsOpportunityType").tabs();
    MeasureIndex.SetTabs("#tabsOpportunityType", "#tabsOpportunityTypeAdvance");


    $("#tabsOportunityDelivery").tabs();
    $("#tabsMeasurement").tabs();
    $("#tabsPertinences").tabs();
    $("#btnSave").button();
    $("#btnSave").click(function (event) {
        $.msg({
            autoUnblock: false,
            clickUnblock: false
            //content: MasterSite.getLoadingImage()
        });
        setTimeout(function () {
            MeasureIndex.btnSave_Click(event);
        }, 500);
        event.preventDefault();
    });
    $("#btnAddPertinencesItem").button();
    $("#ulPickingItems").selectable();

    $("#btnAddPertinencesItem").click(MeasureIndex.btnAddPickItems_Click);

    //DDL para Seleccionar Producto
    $("select[id$='ddlProducto']").change(function () {
        MeasureIndex.getProductInfo();
        MeasureIndex.getddlOptions("GetAreaOptions", "ddlArea", "Seleccione un Area");
        MeasureIndex.getddlOptionswithParametter("GetDivisionN1Options", "ddlDivisionN1", "Seleccione una División N1", { areaID: $("select[id$='ddlArea']").val() });
        MeasureIndex.getddlOptionswithParametter("GetDivisionN2Options", "ddlDivisionN2", "Seleccione una División N2", { divisionN1Id: $("select[id$='ddlDivisionN1']").val() });
        MeasureIndex.getddlOptionswithParametter("GetDivisionN3Options", "ddlDivisionN3", "Seleccione una División N3", { divisionN3Id: $("select[id$='ddlDivisionN2']").val() });


    });




    //DDL para seleccionar Area y Divisiones
    $("select[id$='ddlArea']").change(function () {
        MeasureIndex.getddlOptionswithParametter("GetDivisionN1Options", "ddlDivisionN1", "Seleccione una División N1", { areaID: $("select[id$='ddlArea']").val() });
        MeasureIndex.getddlOptionswithParametter("GetDivisionN2Options", "ddlDivisionN2", "Seleccione una División N2", { divisionN1Id: $("select[id$='ddlDivisionN1']").val() });
        MeasureIndex.getddlOptionswithParametter("GetDivisionN3Options", "ddlDivisionN3", "Seleccione una División N3", { divisionN3Id: $("select[id$='ddlDivisionN2']").val() });
    });
    $("select[id$='ddlDivisionN1']").change(function () {
        MeasureIndex.getddlOptionswithParametter("GetDivisionN2Options", "ddlDivisionN2", "Seleccione una División N2", { divisionN1Id: $("select[id$='ddlDivisionN1']").val() });
        MeasureIndex.getddlOptionswithParametter("GetDivisionN3Options", "ddlDivisionN3", "Seleccione una División N3", { divisionN3Id: $("select[id$='ddlDivisionN2']").val() });
    });
    $("select[id$='ddlDivisionN2']").change(function () {
        MeasureIndex.getddlOptionswithParametter("GetDivisionN3Options", "ddlDivisionN3", "Seleccione una División N3", { divisionN3Id: $("select[id$='ddlDivisionN2']").val() });
    });

    MeasureIndex.LoadProductCodes("txtProductCode", "ddlProductoCode", "txtNewProductCode");
    MeasureIndex.LoadProductCodes("txtNoProductCode", "ddlProductoNoCode", "txtNewProductNoCode");

}

/*
 * Funciones de Carga de Opciones de controles ddl
 * 
 */
MeasureIndex.getddlOptions = function (controlFunction, ddlID, selectText) {
    var urlPage = '/Measure/' + controlFunction;
    $.ajax({
        url: urlPage,
        method: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            MeasureIndex.getddlOptions_onSucces(result, ddlID, selectText);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getddlOptions_onError(jqXHR, textStatus, errorThrown);
        }
    });
}
/**
 * Manejador onSuccess de Carga de Opciones de controles ddl
 */
MeasureIndex.getddlOptions_onSucces = function (result, ddlID, selectText) {
    $("select[id$='" + ddlID + "']").html('<option value="">' + selectText + '</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='" + ddlID + "']").html('');
            var listItems = '<option value="">' + selectText + '</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='" + ddlID + "']").html(listItems);

        }
        else {
            console.log(result.errorMessage);
        }
    }
};

/**
 * Manejador onError de Carga de Opciones de controles ddl
 */
MeasureIndex.getddlOptions_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de Productos.');
}

/*
 * Funciones de Carga de Opciones de controles ddl
 * 
 */
MeasureIndex.getddlOptionswithParametter = function (controlFunction, ddlControl, selectText, dataParameters) {

    var urlPage = '/Measure/' + controlFunction;
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            MeasureIndex.getddlOptionswithParametter_onSucces(result, ddlControl, selectText);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getddlOptionswithParametter_onError(jqXHR, textStatus, errorThrown);
        }
    });
}
/**
 * Manejador onSuccess de Carga de Opciones de controles ddl
 */
MeasureIndex.getddlOptionswithParametter_onSucces = function (result, ddlControl, selectText) {



    $("select[id$='" + ddlControl + "']").html('<option value="">' + selectText + '</option>');
    if (result != null) {
        if (result.errorMessage == null) {
            $("select[id$='" + ddlControl + "']").html('');
            var listItems = '<option value="">' + selectText + '</option>';
            $.each(result.Options, function (e, option) {
                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
            });
            $("select[id$='" + ddlControl + "']").html(listItems);



            if (ddlControl == "ddlProductoNoCode") {
                var length = $('#ddlProductoNoCode').children('option').length;
                var lastValue = $('#ddlProductoNoCode option:last-child').val();
                lastValue++;
                $('#txtNewProductNoCode').val(lastValue);
            }

        }
        else {
            console.log(result.errorMessage);
        }
    }
};
/**
 * Manejador onError de Carga de Opciones de controles ddl
 */
MeasureIndex.getddlOptionswithParametter_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de Productos.');
}

/*
 * Funcion Pare Traer la Informacion Básica del Producto
 */
MeasureIndex.getProductInfo = function () {
    var dataParameters = {
        pdtID: $("select[id$='ddlProducto']").val()
    };
    var urlPage = '/Measure/GetProductInfo';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            MeasureIndex.getProductInfo_onSucess(result);

        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getProductInfo_onError(jqXHR, textStatus, errorThrown);
        }
    });

}
/*
 * Evento On Succes de la informacion Basica del Producto
 */
MeasureIndex.getProductInfo_onSucess = function (result) {
    if (result != null) {
        if (result.errorMessage == null) {

            if (!result.Product) {
                return;
            }

            $('#txtreprocessCount').val(0); 

            if (result.Product.PDT_SIGLA) {
                $('#txtInitial').val(result.Product.PDT_SIGLA);
            }

            if (result.Product.PROC_N0_NAME) {
                $('#txtProcessN0').val(result.Product.PROC_N0_NAME);
            } else {
                $('#txtProcessN0').val('');
            }
            if (result.Product.PROC_N1_NAME) {
                $('#txtProcessN1').val(result.Product.PROC_N1_NAME);
            } else {
                $('#txtProcessN1').val('');
            }
            if (result.Product.PROC_N2_NAME) {
                $('#txtProcessN2').val(result.Product.PROC_N2_NAME);
            } else {
                $('#txtProcessN2').val('');
            }
            if (result.Product.PROC_N3_NAME) {
                $('#txtProcessN3').val(result.Product.PROC_N3_NAME);
            } else {
                $('#txtProcessN3').val('');
            }

            if (result.Product.PDT_HASCODE) {
                $('#txtProductCode').val(result.Product.PDT_CODE);
                MeasureIndex.setTabsInfo("#tabsProductCode", "#tabsWithProductCode", 0);
                document.getElementById('lblNewSigla').innerHTML = (result.Product.PDT_SIGLA);
                document.getElementById('lblSigla').innerHTML = (result.Product.PDT_SIGLA);
                MeasureIndex.getddlOptionswithParametter("GetMeasureCodeOptions", "ddlProductoCode", "", { pdtID: $("select[id$='ddlProducto']").val() });

                $('#txtNewProductNoCode').val('');
                //MeasureIndex.getProductPertinence($("select[id$='ddlProducto']").val());

            } else {

                $("#tabsProductCode").tabs("enable", "#tabsNoProductCode");
                MeasureIndex.setTabsInfo("#tabsProductCode", "#tabsNoProductCode", 1);
                document.getElementById('lblDefNewSigla').innerHTML = (result.Product.PDT_SIGLA);
                document.getElementById('lblNewSigla').innerHTML = (result.Product.PDT_SIGLA);
                document.getElementById('lblDefSigla').innerHTML = (result.Product.PDT_SIGLA);
                $('#txtProductCode').val('');
                MeasureIndex.getddlOptionswithParametter("GetMeasureCodeOptions", "ddlProductoNoCode", "", { pdtID: $("select[id$='ddlProducto']").val() });
                // MeasureIndex.getMeasureCodesOptionsOptions(false);
            }



            if (result.Product.OP_TYPE_ID) {
               
                switch (result.Product.OP_TYPE_ID) {
                    case 1:
                        $("#tabsOpportunityType").tabs("enable", "#tabsOpportunityTypeAdvance");
                        $('#txtAReferencePoint').val(result.Product.PDT_OPORTUNITY_PTO_REF);
                        $('#txtADaysReferencePoint').val(result.Product.PDT_OPORTUNITY_DAYS);
                        $('#txtAHoursReferencePoint').val(result.Product.PDT_OPORTUNITY_HOURS);
                        $('#txtAMinuteReferencePoint').val(result.Product.PDT_OPORTUNITY_MINUTES);
                        $('#txtDReferencePoint').val('');
                        $('#txtDDaysReferencePoint').val('');
                        $('#txtDHoursReferencePoint').val('');
                        $('#txtDMinuteReferencePoint').val('');
                        $('#txtOpportunityTypeAccordDate').val('');
                        MeasureIndex.setTabsInfo("#tabsOpportunityType", "#tabsOpportunityTypeAdvance", 0);
                        break;
                    case 2:
                        $("#tabsOpportunityType").tabs("enable", "#tabsOpportunityTypeDelay");
                        $('#txtDReferencePoint').val(result.Product.PDT_OPORTUNITY_PTO_REF);
                        $('#txtDDaysReferencePoint').val(result.Product.PDT_OPORTUNITY_DAYS);
                        $('#txtDHoursReferencePoint').val(result.Product.PDT_OPORTUNITY_HOURS);
                        $('#txtDMinuteReferencePoint').val(result.Product.PDT_OPORTUNITY_MINUTES);
                        $('#txtAReferencePoint').val('');
                        $('#txtADaysReferencePoint').val('');
                        $('#txtAHoursReferencePoint').val('');
                        $('#txtAMinuteReferencePoint').val('');
                        $('#txtOpportunityTypeAccordDate').val('');
                        MeasureIndex.setTabsInfo("#tabsOpportunityType", "#tabsOpportunityTypeDelay", 1);
                        break;
                    case 3:
                        $("#tabsOpportunityType").tabs("enable", "#tabsOpportunityTypeAccordDate");
                        $('#txtOpportunityTypeAccordDate').val(result.Product.PDT_OPORTUNITY_DATE_ACCORDED_FORMAT);
                        MeasureIndex.setTabsInfo("#tabsOpportunityType", "#tabsOpportunityTypeAccordDate", 2);
                        $('#txtDReferencePoint').val('');
                        $('#txtDDaysReferencePoint').val('');
                        $('#txtDHoursReferencePoint').val('');
                        $('#txtDMinuteReferencePoint').val('');


                        break;
                }
            }

            //MeasureIndex.clearCheckBox("#pertContainer");
            MeasureIndex.getPertinencesProduct();




        }
        else {
            console.log(result.errorMessage);
        }
    }
}

/*
 * Evento On Error Traer Informacion Basica del Producto
 */
MeasureIndex.getProductInfo_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de Productos.');
}




/**
 * Traer Pertinencias de un Producto seleccionado
 */
MeasureIndex.getPertinencesProduct = function () {
    var dataParameters = {
        pdtID: $("select[id$='ddlProducto']").val()
    };
    var urlPage = '/Measure/GetProductPertinences';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            MeasureIndex.getPertinencesProduct_onSucces(result);

        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getPertinencesProduct_onError();
        }
    });
}

/*
 * Agregar CheckBox con Pertinencias
 */
MeasureIndex.getPertinencesProduct_onSucces = function (result) {
    if (result != null) {
        if (result.errorMessage == null) {
            $("#pertContainer").html("");
            $.each(result.Pertinences, function (e, pertinence) {
                MeasureIndex.addCheckbox("#pertContainer", pertinence.PERT_DETAIL);
            });
        }
    }
}

/*
 * Funciones para Inicializar los controles Tabs
 */
MeasureIndex.SetTabs = function (containerID, tabID) {

    var index = $(containerID).index($(tabID));
    $(containerID).tabs('option', 'active', 0);
    $(containerID).tabs({ disabled: [1, 2, 3] });

}

MeasureIndex.setTabsInfo = function (containerID, tabsID, tabIndex) {

    $(containerID).tabs("enable", tabsID);
    var index = $(containerID).index($(tabsID));
    $(containerID).tabs('option', 'active', tabIndex);

    switch (containerID) {
        case tabsOpportunityType:
            $(containerID).tabs({ disabled: [0, 1, 2, 3] });
            break;
        case "#tabsOportunityDelivery":
            $(containerID).tabs({ enabled: [0, 1, 2, 3] });
            break;

        default:
            $(containerID).tabs({ disabled: [0, 1, 2, 3] });
    }

}

/*
 * Agregar input checkbox pertinencias
 */
MeasureIndex.addCheckbox = function (containerID, labelValue, chbxValue) {
    var container = $(containerID);
    var inputs = container.find('input');
    var id = inputs.length + 1;

    $('<input />', { type: 'checkbox', id: 'pert' + id, value: labelValue, class: "squared" }).appendTo(container);
    $(containerID).append(" ");
    $('<label />', { 'for': 'pert' + id, text: labelValue }).appendTo(container);
    $('<br />').appendTo(container);

    if (chbxValue == 1) {
        $('#' + 'pert' + id).attr('checked', 'checked');
    }


}

/*
 * 
 * Metodo para Autocompletar el control de codigos de rastreo
 */

MeasureIndex.LoadProductCodes = function (txtID, ddlID, NtxtID) {
    //$("#ddlDepartureCity").hide();
    //Asocia un elemento autocomplete al input tipo texto 
    $("input[id$='" + txtID + "']").autocomplete({
        minLength: 0,
        delay: 50,
        source: function (request, response) {
            //Asocia el source al autocomplete
            var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
            var dataSource = AutoCompleteHelper.getAutocompleteDataSource(request, matcher, ddlID);
            response(dataSource);
        },
        //Evento de foco seleccionado.
        focus: function (event, ui) {
            //El foco solo se da si se utilizan las teclas keyup y keydown.
            if (window.event.keyCode === 38 || window.event.keyCode === 40) {
                MeasureIndex.txtProductCode_SelectedIndexChanged(event, ui, txtID, ddlID, NtxtID);
            }
            return false;
        },
        //Evento de elemento seleccionado.
        select: function (event, ui) {
            MeasureIndex.txtProductCode_SelectedIndexChanged(event, ui, txtID, ddlID, NtxtID);
            return false;
        },
        change: function (event, ui) {
            AutoCompleteHelper.onControlBlur(ui, txtID, ddlID);
        },
        messages: {
            noResults: '',
            results: function (resultsCount) { }
        }
    });
}

/*
 * Metodo para traer uina medicion existente al seleccionar el Codigo de Rastreo
 */
MeasureIndex.getMeasureInfo = function (rCode) {
    var dataParameters = {
        rastCode: rCode,
        pdtID: $("select[id$='ddlProducto']").val()
    };
    var urlPage = '/Measure/GetMeasureInfo';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            MeasureIndex.getMeasureInfo_onSucess(result);

        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getMeasureInfo_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

/*
 * Evento On Succes al traer una medicion de un prosucto
 * 
 */

MeasureIndex.getMeasureInfo_onSucess = function (result) {

    if (result != null) {
        if (result.errorMessage == null) {

            if (result.Measure.REPROCES_COUNT) {
                $("input[id$='txtreprocessCount']").val(result.Measure.REPROCES_COUNT);
            }

            if (!result.Measure.PDT_DELIVERY_OPT) {
                MeasureIndex.setTabsInfo("#tabsOportunityDelivery", "#tabsOportunityDelivery", 1);
                $('#txtMeasureDaysReferencePoint').val(result.Measure.MSR_DAYS);
                $('#txtMeasureHoursReferencePoint').val(result.Measure.MSR_HOUR);
                $('#txtMeasureMinuteReferencePoint').val(result.Measure.MSR_MINUTES);

            } else {
                MeasureIndex.setTabsInfo("#tabsOportunityDelivery", "#tabsOportunityDelivery", 0);
                $('#txtMeasureDaysReferencePoint').val('');
                $('#txtMeasureHoursReferencePoint').val('');
                $('#txtMeasureMinuteReferencePoint').val('');
            }

            $("#ddlArea").val(result.Measure.AREA_ID);
            MeasureIndex.getMeasureDivisions(result.Measure.DIV_N1_ID, result.Measure.DIV_N2_ID, result.Measure.DIV_N3_ID)


        } else {
            console.log(result.errorMessage);
        }

    }
}

/*
 * Evento On Error al traer una medicion de un prosucto
 * 
 */

MeasureIndex.getMeasureInfo_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de Medicion.');
}

/*
 * Evento para la carga de informacion Area de una medicion
 */

MeasureIndex.getMeasureDivisions = function (defD1,defD2,defD3) {

    var dataParameters = {
        areaID: $("select[id$='ddlArea']").val()
    };
    var urlPage = '/Measure/GetDivisionN1Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
           $("select[id$='ddlDivisionN1']").html('<option value="">Seleccione un Proceso N1</option>');
            if (result != null) {
                if (result.errorMessage == null) {

                    $("select[id$='ddlDivisionN1']").html('<option value="">Seleccione una División N1</option>');
                    if (result != null) {
                        if (result.errorMessage == null) {

                            $("select[id$='ddlDivisionN1']").html('');
                            var listItems = '<option value="">Seleccione una División N1</option>';
                            $.each(result.Options, function (e, option) {
                                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
                            });
                            $("select[id$='ddlDivisionN1']").html(listItems);

                            $("#ddlDivisionN1").val(defD1);
                            MeasureIndex.getMeasureDivisionN2(defD2, defD3);
                            
                        }
                        else {
                            console.log(result.errorMessage);
                        }
                    }
                }
                else {
                    console.log(result.errorMessage);
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getMeasureAreaInfo_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

MeasureIndex.getMeasureDivisionN2 = function (defD2, defD3) {
    var dataParameters = {
        divisionN1Id: $("select[id$='ddlDivisionN1']").val()
    };
    var urlPage = '/Measure/GetDivisionN2Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            $("select[id$='ddlDivisionN2']").html('<option value="">Seleccione un Proceso N2</option>');
            if (result != null) {
                if (result.errorMessage == null) {

                    $("select[id$='ddlDivisionN2']").html('<option value="">Seleccione una División N2</option>');
                    if (result != null) {
                        if (result.errorMessage == null) {

                            $("select[id$='ddlDivisionN2']").html('');
                            var listItems = '<option value="">Seleccione una División N2</option>';
                            $.each(result.Options, function (e, option) {
                                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
                            });
                            $("select[id$='ddlDivisionN2']").html(listItems);

                            $("#ddlDivisionN2").val(defD2);
                            MeasureIndex.getMeasureDivisionN3(defD3);

                        }
                        else {
                            console.log(result.errorMessage);
                        }
                    }
                }
                else {
                    console.log(result.errorMessage);
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getMeasureAreaInfo_onError(jqXHR, textStatus, errorThrown);
        }
    });
}

MeasureIndex.getMeasureDivisionN3 = function (defD3) {

    var dataParameters = {
        divisionN3Id: $("select[id$='ddlDivisionN2']").val()
    };
    var urlPage = '/Measure/GetDivisionN3Options';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {
            $("select[id$='ddlDivisionN3']").html('<option value="">Seleccione un Proceso N3</option>');
            if (result != null) {
                if (result.errorMessage == null) {

                    $("select[id$='ddlDivisionN3']").html('<option value="">Seleccione una División N3</option>');
                    if (result != null) {
                        if (result.errorMessage == null) {

                            $("select[id$='ddlDivisionN3']").html('');
                            var listItems = '<option value="">Seleccione una División N3</option>';
                            $.each(result.Options, function (e, option) {
                                listItems += '<option value=' + option.Value + '>' + option.DisplayText + '</option>';
                            });
                            $("select[id$='ddlDivisionN3']").html(listItems);

                            $("#ddlDivisionN3").val(defD3);
                            

                        }
                        else {
                            console.log(result.errorMessage);
                        }
                    }
                }
                else {
                    console.log(result.errorMessage);
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getMeasureAreaInfo_onError(jqXHR, textStatus, errorThrown);
        }
    });

}

MeasureIndex.getMeasureAreaInfo_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de Medicion.');
}

/*
 * Cargar Pertinencias de una medicion
 */

MeasureIndex.getMeasurePertinence = function (rastCode, initial) {
    var dataParameters = {
        msrRastCode: rastCode,
        pdtID: initial

    };
    var urlPage = '/Measure/GetMeasurePertinences';
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        cache: false,
        success: function (result) {

            if (result.Pertinences.length > 0) {
                MeasureIndex.getMeasurePertinence_onSucces(result);
                //result.Pertinences[0].AREA_NAME


            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            MeasureIndex.getMeasurePertinence_onError();
        }
    });
}

MeasureIndex.getMeasurePertinence_onSucces = function (result) {
    if (result != null) {
        if (result.errorMessage == null) {

            //MeasureIndex.clearCheckBox("#pertContainer");
            $("#pertContainer").html("");
            $.each(result.Pertinences, function (e, pertinence) {
                MeasureIndex.addCheckbox("#pertContainer", pertinence.PERT_DETAIL, pertinence.PERT_VALUE);
            });




        }
    }
}

MeasureIndex.getMeasurePertinence_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de Productos.');
}


/*
 * Evento llamado al seleccionar un codigo para cargar la informacion de un producto
 * 
 */
MeasureIndex.txtProductCode_SelectedIndexChanged = function (event, ui, txtID, ddlID, nTxtID) {
    setTimeout(function () {
        $("input[id$='" + txtID + "']").val(ui.item.label);
        $("input[id$='" + nTxtID + "']").val(ui.item.label);
        $("select[id$='" + ddlID + "']").val(ui.item.value);

        var msrCode = $("input[id$='" + nTxtID + "']").val();


        MeasureIndex.getMeasureInfo(msrCode);
        MeasureIndex.getMeasurePertinence(msrCode, $("select[id$='ddlProducto']").val());
        /*MeasureIndex.getMeasurePertinence(msrCode, pdtSigla);
        MeasureIndex.getMeasureInfobyrastCode(msrCode);
        MeasureIndex.getMeasureInfo();*/



    });
}

/*
 * Metodo del Evento Onclik del Boton Guardar
 * 
 */
MeasureIndex.btnSave_Click = function (event) {
    $("#formMeasure").validationEngine({ autoHidePrompt: true, autoHideDelay: 5000 });
    // Validar formulario
    if ($("#formMeasure").validationEngine('validate')) {
        MeasureIndex.showMeasureInfoPopup();
    }
    else {
        Lobibox.notify('error', {
            size: 'mini',
            rounded: true,
            msg: 'Revisar todos los campos obligatorios.',
            sound: false
        });
        $.msg('unblock');
    }
    event.preventDefault();
};

MeasureIndex.showMeasureInfoPopup = function () {
    var $dialogContainer = $("#divMeasureTableContainer");
    var $detachedChildren = $dialogContainer.children().detach();
    $dialogContainer.dialog({
        width: 450, height: 550, autoOpen: false, modal: true,
        draggable: false, resizable: false,
        title: 'Vista Previa',
        open: function (event, ui) {
            $detachedChildren.appendTo($dialogContainer);
            ShowMeasureInfo.initializeComponents();
        },
        close: function (event, ui) {
            //ShowTripInfo.clearTripInfo();
            //$("#frmSiteMaster").validationEngine('hide');
            //$("#frmSiteMaster").validationEngine('detach');
        }
    });
    $dialogContainer.dialog('open');
}

