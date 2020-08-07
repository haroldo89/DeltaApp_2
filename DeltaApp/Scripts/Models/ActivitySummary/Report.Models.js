// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2014/03/10.
// Producto o sistema	    :   Wizenz.Navi
// Empresa			        :   Wizenz Technologies
// Proyecto			        :   NAVI30
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Entidades para graficas del modulo de resumenes.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
//#region Actividad
//------------------------------Modelo de grafica de distancia recorrida(Actividad)--- -------------------------//
function DistanceChartItem() {

    //---Propiedades---//
    var _vehicleName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _traveledDistance;

    //---Setters---//
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setTraveledDistance = function (traveledDistance) {
        _traveledDistance = traveledDistance;
    }

    //---Getters---//
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getTraveledDistance = function () {
        return _traveledDistance;
    }

    //---Constructor---//
    this.setDistanceChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setVehicleName(summaryGraphInfo.displayName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setTraveledDistance(summaryGraphInfo.traveledDistance);
        }
    }
}

//------------------------------Modelo de grafica de velocidad promedio(Actividad)--- --------------------------//
function AverageSpeedChartItem() {

    //---Propiedades---//
    var _vehicleName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _averageSpeed;

    //---Setters---//
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setAverageSpeed = function (averageSpeed) {
        //El valor -1 es para omitir en las graficas
        _averageSpeed = averageSpeed != 0 ? averageSpeed : -1;
    }

    //---Getters---//
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getAverageSpeed = function () {
        return _averageSpeed;
    }

    //---Constructor---//
    this.setAverageSpeedChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setVehicleName(summaryGraphInfo.displayName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setAverageSpeed(summaryGraphInfo.averageSpeed);
        }
    }
}

//------------------------------Modelo de grafica de uso de vehiculo(Actividad)---------------------------------//
function VehicleUsageChartItem() {

    //---Propiedades---//
    var _vehicleName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _ignitionTime
    var _idleTime;
    var _totalUsage;

    //---Setters---//
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setIgnitionTime = function (ignitionTime) {
        _ignitionTime = ignitionTime;
    }

    this.setIdleTime = function (idleTime) {
        _idleTime = idleTime;
    }

    this.setTotalUsage = function (ignitionTime, idleTime) {
        _totalUsage = ignitionTime + idleTime;
    }


    //---Getters---//
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getIgnitionTime = function () {
        return _ignitionTime;
    }

    this.getIdleTime = function () {
        return _idleTime;
    }

    this.getTotalUsage = function () {
        return _totalUsage;
    }

    //---Constructor---//
    this.setVehicleUsageChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setVehicleName(summaryGraphInfo.displayName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setIgnitionTime(summaryGraphInfo.ignitionTime);
            this.setIdleTime(summaryGraphInfo.idleTime);
            this.setTotalUsage(summaryGraphInfo.ignitionTime, summaryGraphInfo.idleTime);
        }
    }
}

//------------------------------Modelo de grafica de eficiencia de uso de vehiculo(Actividad)- ------------------//
function VehicleEficienceMovingChartItem() {

    //---Propiedades---//
    var _vehicleName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _movingTime
    var _detainedTime;
    var _totalIgnitionTime;

    //---Setters---//
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setMovingTime = function (movingTime) {
        _movingTime = movingTime;
    }

    this.setDetainedTime = function (detainedTime) {
        _detainedTime = detainedTime;
    }

    this.setTotalIgnitionTime = function (movingTime, detainedTime) {
        _totalIgnitionTime = movingTime + detainedTime;
    }

    //---Getters---//
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getMovingTime = function () {
        return _movingTime;
    }

    this.getDetainedTime = function () {
        return _detainedTime;
    }

    this.getTotalIgnitionTime = function () {
        return _totalIgnitionTime;
    }

    //---Constructor---//
    this.setVehicleEficienceMovingChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setVehicleName(summaryGraphInfo.displayName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setMovingTime(summaryGraphInfo.movingTime);
            this.setDetainedTime(summaryGraphInfo.detainedTime);
            this.setTotalIgnitionTime(summaryGraphInfo.movingTime, summaryGraphInfo.detainedTime);
        }
    }
}
//#endregion Actividad

//#region Calidad de conduccion
//------------------------------Modelo de grafica de Infraciones(Calidad de conduccion) -------------------------//
function DrivingQualityInfractionChartItem() {

    //---Propiedades---//
    var _vehicleName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _speeding;

    //---Setters---//
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setSpeeding = function (speeding) {
        _speeding = speeding;
    }

    //---Getters---//
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getSpeeding = function () {
        return _speeding;
    }

    //---Constructor---//
    this.setDrivingQualityInfractionChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setVehicleName(summaryGraphInfo.displayName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setSpeeding(summaryGraphInfo.speedings);
        }
    }
}

//------------------------------Modelo de grafica de Calidad de conducccion(Calidad de conduccion) --------------//
function DrivingQualitySummaryChartItem() {

    //---Propiedades---//
    var _vehicleName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _abruptAccelerations;
    var _abruptBrakings;

    //---Setters---//
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setAbruptAccelerations = function (abruptAccelerations) {
        _abruptAccelerations = abruptAccelerations;
    }

    this.setAbruptBrakings = function (abruptBrakings) {
        _abruptBrakings = abruptBrakings;
    }

    //---Getters---//
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getAbruptAccelerations = function () {
        return _abruptAccelerations;
    }

    this.getAbruptBrakings = function () {
        return _abruptBrakings;
    }

    //---Constructor---//
    this.setDrivingQualitySummaryChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setVehicleName(summaryGraphInfo.displayName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setAbruptAccelerations(summaryGraphInfo.abruptAccelerations);
            this.setAbruptBrakings(summaryGraphInfo.abruptBrakings);
        }
    }
}

//------------------------------Modelo de grafica de Conducta(Calidad de conduccion) ---------------------------//
function DrivingQualityBehaviorChartItem() {

    //---Propiedades---//
    var _vehicleName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _indicator1;
    var _indicator2;
    var _indicator3;

    //---Setters---//
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setIndicator1 = function (indicator1) {
        _indicator1 = indicator1;
    }

    this.setIndicator2 = function (indicator2) {
        _indicator2 = indicator2;
    }

    this.setIndicator3 = function (indicator3) {
        _indicator3 = indicator3;
    }
    //---Getters---//
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getIndicator1 = function () {
        return _indicator1;
    }

    this.getIndicator2 = function () {
        return _indicator2;
    }

    this.getIndicator3 = function () {
        return _indicator3;
    }

    //---Constructor---//
    this.setDrivingQualityBehaviorChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setVehicleName(summaryGraphInfo.displayName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setIndicator1(summaryGraphInfo.indicator1);
            this.setIndicator2(summaryGraphInfo.indicator2);
            this.setIndicator3(summaryGraphInfo.indicator3);
        }
    }
}

//#endregion Calidad de conduccion

//#region Actividad conductor
//------------------------------Modelo de grafica de distancia recorrida(conductor)--- -------------------------//
function DriverTraveledDistanceChartItem() {

    //---Propiedades---//
    var _identification;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _traveledDistance;

    //---Setters---//
    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setTraveledDistance = function (traveledDistance) {
        _traveledDistance = traveledDistance;
    }

    //---Getters---//
    this.getIdentification = function () {
        return _identification;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getTraveledDistance = function () {
        return _traveledDistance;
    }

    //---Constructor---//
    this.setDriverTraveledDistanceChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setIdentification(summaryGraphInfo.identification);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setTraveledDistance(summaryGraphInfo.traveledDistance);
        }
    }
}

//------------------------------Modelo de grafica de velocidad promedio(Actividad)--- --------------------------//
function DriverAverageSpeedChartItem() {

    //---Propiedades---//
    var _identification;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _averageSpeed;

    //---Setters---//
    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setAverageSpeed = function (averageSpeed) {
        //El valor -1 es para omitir en las graficas
        _averageSpeed = averageSpeed != 0 ? averageSpeed : -1;
    }

    //---Getters---//
    this.getIdentification = function () {
        return _identification;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getAverageSpeed = function () {
        return _averageSpeed;
    }

    //---Constructor---//
    this.setDriverAverageSpeedChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setIdentification(summaryGraphInfo.identification);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setAverageSpeed(summaryGraphInfo.averageSpeed);
        }
    }
}

//------------------------------Modelo de grafica de eficiencia de uso de vehiculo(Actividad)- ------------------//
function DriverEficienceUsageChartItem() {

    //---Propiedades---//
    var _identification;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _movingTime
    var _detainedTime;
    var _totalIgnitionTime;

    //---Setters---//
    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setMovingTime = function (movingTime) {
        _movingTime = movingTime;
    }

    this.setDetainedTime = function (detainedTime) {
        _detainedTime = detainedTime;
    }

    this.setTotalIgnitionTime = function (movingTime, detainedTime) {
        _totalIgnitionTime = movingTime + detainedTime;
    }

    //---Getters---//
    this.getIdentification = function () {
        return _identification;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getMovingTime = function () {
        return _movingTime;
    }

    this.getDetainedTime = function () {
        return _detainedTime;
    }

    this.getTotalIgnitionTime = function () {
        return _totalIgnitionTime;
    }

    //---Constructor---//
    this.setDriverEficienceUsageChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setIdentification(summaryGraphInfo.identification);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setMovingTime(summaryGraphInfo.movingTime);
            this.setDetainedTime(summaryGraphInfo.detainedTime);
            this.setTotalIgnitionTime(summaryGraphInfo.movingTime, summaryGraphInfo.detainedTime);
        }
    }
}

//------------------------------Modelo de grafica de infracciones de conductor(Actividad)- ------------------//
function DriverInfractionsChartItem() {

    //---Propiedades---//
    var _identification;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _speedings;

    //---Setters---//
    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setSpeedings = function (speedings) {
        _speedings = speedings;
    }

    //---Getters---//
    this.getIdentification = function () {
        return _identification;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getSpeedings = function () {
        return _speedings;
    }

    //---Constructor---//
    this.setDriverInfractionsChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setIdentification(summaryGraphInfo.identification);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setSpeedings(summaryGraphInfo.speedings);
        }
    }
}

//------------------------------Modelo de grafica de calidad de conduccion(Actividad)- ------------------//
function DriverDrivingQualityChartItem() {

    //---Propiedades---//
    var _identification;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _abruptAccelerations;
    var _abruptBrakings;
    var _idleReports;

    //---Setters---//
    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setAbruptAccelerations = function (abruptAccelerations) {
        _abruptAccelerations = abruptAccelerations;
    }

    this.setAbruptBrakings = function (abruptBrakings) {
        _abruptBrakings = abruptBrakings;
    }

    this.setIdleReports = function (idleReports) {
        _idleReports = idleReports;
    }

    //---Getters---//
    this.getIdentification = function () {
        return _identification;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getAbruptAccelerations = function () {
        return _abruptAccelerations;
    }

    this.getAbruptBrakings = function () {
        return _abruptBrakings;
    }

    this.getIdleReports = function () {
        return _idleReports;
    }

    //---Constructor---//
    this.setDriverDrivingQualityChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setIdentification(summaryGraphInfo.identification);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setAbruptAccelerations(summaryGraphInfo.abruptAccelerations);
            this.setAbruptBrakings(summaryGraphInfo.abruptBrakings);
            this.setIdleReports(summaryGraphInfo.idleReports);
        }
    }
}

//------------------------------Modelo de grafica de conducta de conduccion(Actividad)- ------------------//
function DriverBehaviorChartItem() {

    //---Propiedades---//
    var _identification;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _indicator1;
    var _indicator2;
    var _indicator3;

    //---Setters---//
    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setIndicator1 = function (indicator1) {
        _indicator1 = indicator1;
    }

    this.setIndicator2 = function (indicator2) {
        _indicator2 = indicator2;
    }

    this.setIndicator3 = function (indicator3) {
        _indicator3 = indicator3;
    }

    //---Getters---//
    this.getIdentification = function () {
        return _identification;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getIndicator1 = function () {
        return _indicator1;
    }

    this.getIndicator2 = function () {
        return _indicator2;
    }

    this.getIndicator3 = function () {
        return _indicator3;
    }

    //---Constructor---//
    this.setDriverBehaviorChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setIdentification(summaryGraphInfo.identification);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setIndicator1(summaryGraphInfo.indicator1);
            this.setIndicator2(summaryGraphInfo.indicator2);
            this.setIndicator3(summaryGraphInfo.indicator3);
        }
    }
}

//------------------------------Modelo de grafica de penalizacion(Actividad - Calificacion)- ------------------//
function DriverScoreChartItem() {

    //---Propiedades---//
    var _identification;
    var _driverFullName;
    var _summaryDate;
    var _summaryDay;
    var _summaryWeek;
    var _summaryMonth;
    var _driverScore;

    //---Setters---//
    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setDriverFullName = function (driverFullName) {
        _driverFullName = driverFullName;
    }

    this.setSummaryDate = function (summaryDate) {
        _summaryDate = summaryDate;
    }

    this.setSummaryDay = function (summaryDay) {
        _summaryDay = summaryDay;
    }

    this.setSummaryWeek = function (summaryWeek) {
        _summaryWeek = summaryWeek;
    }

    this.setSummaryMonth = function (summaryMonth) {
        _summaryMonth = summaryMonth;
    }

    this.setDriverScore = function (driverScore) {
        _driverScore = driverScore;
    }

    //---Getters---//
    this.getIdentification = function () {
        return _identification;
    }

    this.getDriverFullName = function () {
        return _driverFullName;
    }

    this.getSummaryDate = function () {
        return _summaryDate;
    }

    this.getSummaryDay = function () {
        return _summaryDay;
    }

    this.getSummaryWeek = function () {
        return _summaryWeek;
    }

    this.getSummaryMonth = function () {
        return _summaryMonth;
    }

    this.getDriverScore = function () {
        return _driverScore;
    }

    var _position;
    this.setPosition = function (position) {
        _position = position;
    }
    this.getPosition = function () {
        return _position;
    }

    //---Constructor---//
    this.setDriverScoreChartItem = function (summaryGraphInfo) {
        if (summaryGraphInfo) {
            this.setIdentification(summaryGraphInfo.identification);
            this.setDriverFullName(summaryGraphInfo.fullName);
            this.setSummaryDate(ChartUtils.parseDate(summaryGraphInfo.summaryDate, "%m/%d/%Y"));
            this.setSummaryDay(ChartUtils.getDay(this.getSummaryDate()));
            this.setSummaryWeek(ChartUtils.getWeek(this.getSummaryDate()));
            this.setSummaryMonth(ChartUtils.getMonth(this.getSummaryDate()));
            this.setDriverScore(summaryGraphInfo.driverScore);
            this.setPosition(summaryGraphInfo.positionDriverScore);
        }
    }
}


//#endregion Actividad conductor
