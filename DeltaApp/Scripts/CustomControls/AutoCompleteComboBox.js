// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2014/06/16.
// Producto o sistema	    :   Wizenz.Navi
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Control AutoComplete personalizado.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
//Definicion de constantes
var EMPTY_RESULT_MESSAGE = "Ningun elemento coincide con el valor de búsqueda ";
var SHOW_ALL_TOOLTIP_TEXT = "Mostrar todos los elementos";

function autoCompleteDropDownListFor(controlName) {
    (function ($) {
        $.widget("custom.combobox", {
            _create: function () {
                this.wrapper = $("<span>")
                  //.addClass("custom-combobox")
                  .insertAfter(this.element);

                this.element.hide();
                this._createAutocomplete();
                this._createShowAllButton();
            },
            _createAutocomplete: function () {
                var selected = this.element.children(":selected"),
                  value = selected.val() ? selected.text() : "";
                this.input = $("<input id='" + controlName + "_autoComplete'>")
                //this.input = $("<input>")
                  .appendTo(this.wrapper)
                  .val(value)
                  .attr("title", "")
                  .autocomplete({
                      delay: 0,
                      minLength: 0,
                      source: $.proxy(this, "_source")
                  })
                  .tooltip({
                      tooltipClass: "ui-state-highlight"
                  });
                this._on(this.input, {
                    autocompleteselect: function (event, ui) {
                        ui.item.option.selected = true;
                        this._trigger("select", event, {
                            item: ui.item.option
                        });
                    },
                    autocompletechange: "_removeIfInvalid"
                });
            },
            _createShowAllButton: function () {
                var input = this.input,
                  wasOpen = false;
                $("<a>")
                  .attr("tabIndex", -1)
                  .attr("title", SHOW_ALL_TOOLTIP_TEXT)
                  .tooltip()
                  .appendTo(this.wrapper)
                  .button({
                      icons: {
                          primary: "ui-icon-triangle-1-s"
                      },
                      text: false
                  })
                  .removeClass("ui-corner-all")
                  .addClass("custom-combobox-toggle buttonCbx")
                  .mousedown(function () {
                      wasOpen = input.autocomplete("widget").is(":visible");
                  })
                  .click(function () {
                      input.focus();
                      // Close if already visible
                      if (wasOpen) {
                          return;
                      }
                      // Pass empty string as value to search for, displaying all results
                      input.autocomplete("search", "");
                  });
            },
            _source: function (request, response) {
                var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
                response(this.element.children("option").map(function () {
                    var text = $(this).text();
                    if (this.value && (!request.term || matcher.test(text)))
                        return {
                            label: text,
                            value: text,
                            option: this
                        };
                }));
            },
            _removeIfInvalid: function (event, ui) {

                // Selected an item, nothing to do
                if (ui.item) {
                    return;
                }
                // Search for a match (case-insensitive)
                var value = this.input.val(),
                  valueLowerCase = value.toLowerCase(),
                  valid = false;
                this.element.children("option").each(function () {
                    if ($(this).text().toLowerCase() === valueLowerCase) {
                        this.selected = valid = true;
                        return false;
                    }
                });
                // Found a match, nothing to do
                if (valid) {
                    return;
                }
                // Remove invalid value
                this.input
                  .val("")
                  .attr("title", EMPTY_RESULT_MESSAGE)
                  .tooltip("open");
                this.element.val("");
                this._delay(function () {
                    this.input.tooltip("close").attr("title", "");
                }, 2500);
                this.input.data("ui-autocomplete").term = "";
            },
            _destroy: function () {
                this.wrapper.remove();
                this.element.show();
            }
        });
    })(jQuery);
    addToggleEvent(controlName);
}

function addToggleEvent(controlName) {
    var selector = String.format('#{0}', controlName);
    //var selector = "#" + controlName;
    $(selector).combobox();
    $("#toggle").click(function () {
        $(selector).toggle();
    });
}