// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2016/08/01.
// Producto o sistema	    :   DeltaApp
// Empresa			        :   DeltaApp
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones con funcionalidad javascript del pop up de los productos a asociar a un 
//                  rol seleccionado 
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================

function UserRolByProductPopUp() { }

//#region Carga las categorias de los evento
UserRolByProductPopUp.getProductsByUserRole = function (selectedUserRoleId, selectedUserRoleName) {
    var dataParameters = {
        userRoleId: parseInt(selectedUserRoleId)
    }
    $.ajax({
        url: '/Rol/GetProductsByUserRole',
        data: dataParameters,
        contentType: "application/json",
        dataType: "html",
        cache: false,
        success: function (result) {
            UserRolByProductPopUp.getProductsByUserRole_onSuccess(result);
        },
        error: function (request, status, error) {
            console.error(status + ", " + error);
        }
    });
    $("#lblRolNamePopup").text(selectedUserRoleName);
}

UserRolByProductPopUp.getProductsByUserRole_onSuccess = function (result) {
    $('#divChangeUserRoleProductsPopup').html(result);
    var categoryCodes = ($('#cbxAvaliableProducts').val());
    console.log(categoryCodes);
    //if (categoryCodes == null) {
    //    LayoutHelper.setVisible('btnDesvincularCategorias', false);
    //}
    //else {
    //    LayoutHelper.setVisible('btnDesvincularCategorias', true);
    //}
}
//#endregion Carga los vehiculos que no poseen un modelo de sensor asigando

//#region Desvincular categorias del evento seleccionado
UserRolByProductPopUp.btnDisassociateUserRoleProduct_Click = function (userRoleId) {
    var disassociateUserRoleProduct = confirm("¿Esta seguro que desea desasociar los productos al rol seleccionado?");
    if (disassociateUserRoleProduct == true) {
        UserRolByProductPopUp.disassociateUserRoleProduct(userRoleId);
    }
}

UserRolByProductPopUp.disassociateUserRoleProduct = function (selectedUserRoleId) {
    var dataParameters = {
        userRoleId: selectedUserRoleId,
    };
    $.ajax({
        url: '/Rol/DisassociateUserRoleProducts',
        cache: false,
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        data: JSON.stringify(dataParameters),
        success: function (result) {
            UserRolByProductPopUp.disassociateVehicleEventType_onSucces(result);
        },
        error: function (request, status, error) {
            UserRolByProductPopUp.disassociateVehicleEventType_onError(request, status, error);
        }
    });
}

UserRolByProductPopUp.disassociateVehicleEventType_onSucces = function (result) {
    if (result.errorMessage == null) {
        alert(result.resultMessage);
        $("#divUserRoleProductsPopup").dialog("close");
    }
    else {
        console.error(result.errorMessage);
    }
}

UserRolByProductPopUp.disassociateVehicleEventType_onError = function (request, status, error) {
    console.error(status + ", " + error);
}
//#endregion Desvincular categorias del evento seleccionado

//#region Asociar categorias al evento seleccionado
UserRolByProductPopUp.btnSaveUserRolProducts_Click = function (userRoleId) {
    UserRolByProductPopUp.saveUserRolProducts(userRoleId);
}


UserRolByProductPopUp.saveUserRolProducts = function (selectedUserRoleId) {
    var categoryCodes = ($('#cbxAvaliableProducts').val());
    if (categoryCodes == null) {
        alert('Debe seleccionar al menos un producto para asociar.');
    }
    else {
        var dataParameters = {
            userRoleId: selectedUserRoleId,
            productIds: categoryCodes.toString()
        };
        $.ajax({
            type: "GET",
            url: '/Rol/AssociateUserRoleProducts',
            cache: false,
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            //data: JSON.stringify(dataParameters),
            data: dataParameters,
            success: function (result) {
                UserRolByProductPopUp.saveUserRolProducts_onSucces(result);
            },
            error: function (request, status, error) {
                UserRolByProductPopUp.saveUserRolProducts_onError(request, status, error);
            }
        });
    }
}

UserRolByProductPopUp.saveUserRolProducts_onSucces = function (result) {
    if (result.errorMessage == null) {
        alert(result.resultMessage);
        $("#divUserRoleProductsPopup").dialog("close");
    }
    else {
        alert(result.errorMessage);
    }
}

UserRolByProductPopUp.saveUserRolProducts_onError = function (request, status, error) {
    console.log(error);
}
//#endregion Asociar categorias al evento seleccionado