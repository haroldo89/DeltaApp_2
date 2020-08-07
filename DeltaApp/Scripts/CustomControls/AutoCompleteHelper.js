// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2016/02/23.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones generales para control autocomplete.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================

function AutoCompleteHelper() { }

/**
 * Obtiene DataSource para un control de tipo autocomplete a partir de los elementos de un lista deplegable.
 *
 * @param {object} request - Valor insertado en control textbox.
 * @param {object} matcher - Valor a evaluar insertado en control textbox.
 * @param {object} sourceListControlName - Id del control lista desplegable.
 * @return {object[]} Coleccion de elementos para control autocomplete.
 *
 */
AutoCompleteHelper.getAutocompleteDataSource = function (request, matcher, sourceListControlName) {
    var autocompleteDataSource = null;
    var sourceListControlSelector = String.format("select[id$='{0}']", sourceListControlName);
    var sourceListControl = $(sourceListControlSelector);
    if (sourceListControl) {
        autocompleteDataSource = sourceListControl.children("option").map(function () {
            var text = $(this).text();
            var selectedValue = $(this).val();
            if (this.value && (!request.term || matcher.test(text))) {
                return {
                    label: text,
                    value: selectedValue,
                    option: this
                };
            }
        });
    }
    return autocompleteDataSource;
}

/*
 * Agrega el comportamiento al control autocomplete para buscar elementos cuando el control pierde el foco.
 *
 * @param {object} ui control contenedor del elemento a buscar.
 * @param {string} sourceSearchControlId Id de control de busqueda.
 * @param {string} sourceListControlId Id del control lista desplegable.
 *
 */
AutoCompleteHelper.onControlBlur = function (ui, sourceSearchControlId, sourceListControlId) {
    var sourceSearchControlIdSelector = String.format("input[id$='{0}']", sourceSearchControlId);
    var sourceListControlSelector = String.format("select[id$='{0}']", sourceListControlId);
    //No hacer nada si hay elemento seleccionado
    if (ui.item) {
        return;
    }
    else {
        if (sourceSearchControlIdSelector && sourceListControlSelector) {
            //Buscar elemento a partir del texto ingresado
            var value = $(sourceSearchControlIdSelector).val();
            var valid = false;
            $(sourceListControlSelector).children("option").each(function () {
                if ($(this).text().toLowerCase() === value.toLowerCase()) {
                    this.selected = true;
                    valid = true;
                    $(sourceListControlSelector).val($(this).val());
                    return false;
                }
            });
            //La búsqueda no arrojo ningun elemento
            if (!valid) {
                //Limpiar control de búsqueda y mostrar aviso informativo
                $(sourceSearchControlIdSelector).val("").tooltip({ content: "Ningun elemento coincide con el valor de búsqueda " });
                $(sourceSearchControlIdSelector).tooltip('open');
                $(sourceListControlSelector).val(0);
                window.setTimeout(function () {
                    $(sourceSearchControlIdSelector).attr("title", "");
                    $(sourceSearchControlIdSelector).tooltip("destroy");
                }, 2500);
            }
        }
    }
}