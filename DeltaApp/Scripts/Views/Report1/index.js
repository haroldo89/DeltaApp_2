function Report1Index() { }

Report1Index.initializeComponents = function () {

    $(document).ajaxStart(function () {
        $.blockUI({ message: '<h1><img src="Content/Images/loading1.gif" /> Cargando Registros...</h1>' });
    }).ajaxStop($.unblockUI);

    $("#btnGenerateReport").button();
    $("#btnGenerateReport").click(function (event) {
        $.msg({
            autoUnblock: false,
            clickUnblock: false
            //content: MasterSite.getLoadingImage()
        });
        setTimeout(function () {
            Report1Index.btnSave_Click(event);
        }, 500);
        event.preventDefault();
    });

    $("input[id$='txtFromDate']").datepicker({
        dateFormat: "yy-mm-dd"
    });

    $("input[id$='txtToDate']").datepicker({
        dateFormat: "yy-mm-dd"
    });


    $("#DownloadReport").button();
    $("#DownloadReport").click(function (event) {
        $.msg({
            autoUnblock: false,
            clickUnblock: false
            //content: MasterSite.getLoadingImage()
        });
        setTimeout(function () {
            Report1Index.btnDownload_Click(event);
        }, 500);
        event.preventDefault();
    });
}
Report1Index.btnDownload_Click = function (event) {
    var src = $("#reportJPG").attr('src');

    var urlPage = '/Report1/DownloadPDF';
    var dataParameters = {
        pdfString: src
    };

    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json",
        dataType: "json",
        cache: false,
        //contentType: "image/jpge",
        mimeType: "text/plain; charset=x-user-defined",

        success: function (result) {
            $.msg('unblock');

        },
        error: function (jqXHR, textStatus, errorThrown) {
            Report1Index.getGoalConfiabilityOptions_onError(jqXHR, textStatus, errorThrown);
        }
    });
}


Report1Index.btnSave_Click = function (event) {
    $("#formReport1").validationEngine({ autoHidePrompt: true, autoHideDelay: 5000 });
    // Validar formulario
    if ($("#formReport1").validationEngine('validate')) {
        Report1Index.getReport();
        //Report1Index.sendData();
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


Report1Index.getReport = function () {
    var urlPage = '/Report1/GenerateAndDisplayReport';
    var dataParameters = {
        QdateFrom: $("input[id$='txtFromDate']").val(),
        QdateTo: $("input[id$='txtToDate']").val(),
        format: "val"
    };
    $.ajax({
        url: urlPage,
        method: "POST",
        data: JSON.stringify(dataParameters),
        contentType: "application/json",
        dataType: "json",
        cache: false,
        //contentType: "image/jpge",
        mimeType: "text/plain; charset=x-user-defined",

        success: function (result) {
            $("#reportView").html('');
            $("<img>", {
                "src": "data:image/tiff;base64," + result.Report,
                "id": "reportJPG"
                // added `width` , `height` properties to `img` attributes

            }).appendTo("#reportView");

            $("<img>", {
                "src": "data:image/tiff;base64," + result.Report2
                // added `width` , `height` properties to `img` attributes

            }).appendTo("#reportView");

            /*$("<iframe>",{
                "src": "http://docs.google.com/viewer?url=" + result.base65,
                "width": "600",
                "height": "780",
                "style": "border: none;"
            }).appendTo("#reportView");*/

            $("iframe").each(
         function (index, elem) {
             elem.setAttribute("width", "600");
             elem.setAttribute("height", "780");
         }
 );
            $("#buttonHolder").html('');
            $("<button>",{
                "onclick": "window.location.href=' "+ result.base65 + "'",
                "text": "Descargar Reporte",
                "type": "submit"
            }).appendTo("#buttonHolder");;
            
            //$("#reportView").attr('src', 'data:image/jpeg;base64,' + base64Encode(result.Report));
            //$("#reportView").attr('src', 'application/pdf;base64,' + base64Encode(result.Report));
            $.msg('unblock');
        },
        error: function (jqXHR, textStatus, errorThrown) {
            Report1Index.getGoalConfiabilityOptions_onError(jqXHR, textStatus, errorThrown);
        }
    });
}


Report1Index.getGoalConfiabilityOptions_onError = function (jqXHR, textStatus, errorThrown) {
    console.log(textStatus + ' error en carga de clientes.');
}


function base64Encode(str) {
    var CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    var out = "", i = 0, len = str.length, c1, c2, c3;
    while (i < len) {
        c1 = str.charCodeAt(i++) & 0xff;
        if (i == len) {
            out += CHARS.charAt(c1 >> 2);
            out += CHARS.charAt((c1 & 0x3) << 4);
            out += "==";
            break;
        }
        c2 = str.charCodeAt(i++);
        if (i == len) {
            out += CHARS.charAt(c1 >> 2);
            out += CHARS.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
            out += CHARS.charAt((c2 & 0xF) << 2);
            out += "=";
            break;
        }
        c3 = str.charCodeAt(i++);
        out += CHARS.charAt(c1 >> 2);
        out += CHARS.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
        out += CHARS.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
        out += CHARS.charAt(c3 & 0x3F);
    }
    return out;
}


Report1Index.sendData = function () {
    var dataParameters = {
        dFrom: $("input[id$='txtFromDate']").val(),
        dTo: $("input[id$='txtFromDate']").val(),

    };
    var urlPage = '/Report1/metodoprueba';
    $.ajax({
        url: urlPage,
        data: JSON.stringify(dataParameters),
        method: "POST",
        contentType: "application/json",
        dataType: "json",
        cache: false,
        success: function (result) {
            Report1Index.getReport();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            ShowMeasureInfo.getGoalConfiabilityOptions_onError(jqXHR, textStatus, errorThrown);
        }
    });
}