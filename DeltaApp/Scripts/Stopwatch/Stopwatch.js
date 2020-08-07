// ===================================================================================================
// Desarrollado Por		    :   Andrés Alberto Pinzón.
// Fecha de Creación		:   2015/01/27.
// Producto o sistema	    :   Wizenz.Navi
// Empresa			        :   Wizenz Technologies
// Proyecto			        :   NAVI30
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Code-Behind funcionalidad Stopwatch.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
function Stopwatch() {
    //Definición de propiedades (privadas)
    var _startDate;
    var _endDate;
    var _totalMilliseconds;

    //Getters
    this.getStartDate = function () {
        return _startDate;
    }

    this.getEndDate = function () {
        return _endDate;
    }

    this.getTotalMilliseconds = function () {
        return _totalMilliseconds;
    }

    //Métodos públicos
    this.start = function () {
        _totalMilliseconds = 0;
        _startDate = new Date();
    }

    this.stop = function () {
        _endDate = new Date();
        if (this.getStartDate() != null && this.getEndDate() != null) {
            _totalMilliseconds = this.getEndDate().getTime() - this.getStartDate().getTime();
        }
        else {
            _totalMilliseconds = 0;
        }
    }

    this.restart = function () {
        this.stop();
        this.start();
    }

    this.getTotalSeconds = function () {
        var totalSeconds = this.getTotalMilliseconds() / 1000;
        return totalSeconds;
    }
}
