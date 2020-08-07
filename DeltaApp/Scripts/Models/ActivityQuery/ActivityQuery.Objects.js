/*Representa la ubicacion de un evento de un vehiculo en el mapa.*/
function VehicleEventInfo() {

    /*properties*/
    var _vehicleName;
    var _dateTime;
    var _eventName;
    var _iconFullPath;
    var _latitude;
    var _longitude;
    var _location;

    /*setters*/
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setDateTime = function (dateTime) {
        _dateTime = dateTime;
    }

    this.setEventName = function (eventName) {
        _eventName = eventName;
    }

    this.setIconFullPath = function (iconFullPath) {
        _iconFullPath = iconFullPath;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.setLocation = function (latitude, longitude) {
        _location = BingMapHelper.createLocation(latitude, longitude);
    }

    /*getters*/
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getDateTime = function () {
        return _dateTime;
    }

    this.getEventName = function () {
        return _eventName;
    }

    this.getIconFullPath = function () {
        return _iconFullPath;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.getLocation = function () {
        return _location;
    }

    this.setVehicleEventInfo = function (vehicleEvent) {
        if (vehicleEvent != null) {
            this.setVehicleName(vehicleEvent.vehicleName);
            this.setDateTime(vehicleEvent.dateTime);
            this.setEventName(vehicleEvent.eventName);
            this.setIconFullPath(vehicleEvent.iconFullPath);
            this.setLatitude(vehicleEvent.latitude);
            this.setLongitude(vehicleEvent.longitude);
            this.setLocation(vehicleEvent.latitude, vehicleEvent.longitude);
        }
    }
}

/*Representa la ubicacion de una alerta de un vehiculo en el mapa.*/
function VehicleAlertInfo() {

    /*properties*/
    var _vehicleName;
    var _dateTime;
    var _eventName;
    var _iconFullPath;
    var _latitude;
    var _longitude;
    var _location;

    /*setters*/
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setDateTime = function (dateTime) {
        _dateTime = dateTime;
    }

    this.setEventName = function (eventName) {
        _eventName = eventName;
    }

    this.setIconFullPath = function (iconFullPath) {
        _iconFullPath = iconFullPath;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.setLocation = function (latitude, longitude) {
        _location = BingMapHelper.createLocation(latitude, longitude);
    }

    /*getters*/
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getDateTime = function () {
        return _dateTime;
    }

    this.getEventName = function () {
        return _eventName;
    }

    this.getIconFullPath = function () {
        return _iconFullPath;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.getLocation = function () {
        return _location;
    }

    this.setVehicleAlertInfo = function (vehicleEvent) {
        if (vehicleEvent != null) {
            this.setVehicleName(vehicleEvent.vehicleName);
            this.setDateTime(vehicleEvent.dateTime);
            this.setEventName(vehicleEvent.eventName);
            this.setIconFullPath(vehicleEvent.iconFullPath);
            this.setLatitude(vehicleEvent.latitude);
            this.setLongitude(vehicleEvent.longitude);
            this.setLocation(vehicleEvent.latitude, vehicleEvent.longitude);
        }
    }
}

/*Representa la información de una ruta o recorrido que es representado en un mapa.*/
function VehicleRouteInfo(routeName) {
    var _routeName = routeName;
    var _points;

    this.setPoints = function (points) {
        _points = new Array();
        points.forEach(function (point) {
            var location = BingMapHelper.createLocation(point.latitude, point.longitude);
            _points.push(location);
        });
    }

    this.getPoints = function () {
        return _points;
    }

    this.getName = function () {
        return _routeName;
    }

}

//Representa la información de una ruta de conductor que es representado en un mapa.
function DriverRouteInfo() {

    /*--properties--*/
    var _routeId;
    var _routeName;
    var _routeDescription;
    var _routeTypeId;
    var _routeTypeName;
    var _routeColor;
    var _points;

    /*--setters--*/

    this.setRouteId = function (routeId) {
        _routeId = routeId;
    }

    this.setRouteName = function (routeName) {
        _routeName = routeName;
    }

    this.setRouteDescription = function (routeDescription) {
        _routeDescription = routeDescription;
    }

    this.setRouteColor = function (routeColor) {
        _routeColor = routeColor;
    }

    /*Establecer Puntos de geocerca*/
    this.setPoints = function (points) {
        _points = new Array();
        points.forEach(function (point) {
            var location = BingMapHelper.createLocation(point.latitude, point.longitude);
            _points.push(location);
        });
    }

    /*--getters--*/

    /*Obtener puntos de geocerca*/

    this.getRouteId = function () {
        return _routeId;
    }

    this.getRouteName = function () {
        return _routeName;
    }

    this.getRouteDescription = function () {
        return _routeDescription;
    }

    this.getRouteColor = function () {
        return _routeColor;
    }

    this.getPoints = function () {
        return _points;
    }

    /*Establecer propiedades de geocerca*/
    this.setDriverRouteInfo = function (routeInfo) {
        if (routeInfo) {
            this.setRouteId(routeInfo.routeId);
            this.setRouteName(routeInfo.routeName);
            this.setRouteDescription(routeInfo.routeDescription);
            this.setRouteColor(routeInfo.routeColor);
            this.setPoints(routeInfo.routePoints);
        }
    }
}

//------------------------------Modelo de grafica de distancia recorrida --------------------------//
function VehicleActivityChartItem() {

    /*Properties*/
    var _vehicleName;
    var _dateTimeUTC;
    var _formatedDateTime;
    var _latitude;
    var _longitude;
    var _speed;

    /*Setters*/
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setDateTimeUTC = function (dateTimeUTC) {
        _dateTimeUTC = dateTimeUTC;
    }

    this.setFormatedDateTime = function (formatedDateTime) {
        _formatedDateTime = formatedDateTime;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.setSpeed = function (speed) {
        _speed = speed;
    }

    /*Getters*/
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getDateTimeUTC = function () {
        return _dateTimeUTC;
    }

    this.getFormatedDateTime = function () {
        return _formatedDateTime;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.getSpeed = function () {
        return _speed;
    }

    //---Constructor---//
    this.setVehicleActivityChartItem = function (queryGraphInfo) {
        if (queryGraphInfo) {
            this.setVehicleName(queryGraphInfo.name);
            var newDate = new Date(queryGraphInfo.dateTimeUTC);
            this.setDateTimeUTC(ChartUtils.parseDate(newDate.toISOString(), "%Y-%m-%dT%H:%M:%S.%LZ"));
            this.setFormatedDateTime(queryGraphInfo.formatedDateTimeUTC);
            this.setLatitude(queryGraphInfo.latitude);
            this.setLongitude(queryGraphInfo.longitude);
            this.setSpeed(queryGraphInfo.speed);
        }
    }
}

//------------------------------Modelo de grafica de medida de combustible y rpm --------------------------//
function VehicleFuelMeasureChartItem() {

    /*Properties*/
    var _vehicleName;
    var _dateTimeUTC;
    var _formatedDateTime;
    var _rPMValue;
    var _fuelLevelValue;
    var _aceleration;
    var _engineTemperature;

    /*Setters*/
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setDateTimeUTC = function (dateTimeUTC) {
        _dateTimeUTC = dateTimeUTC;
    }

    this.setFormatedDateTime = function (formatedDateTime) {
        _formatedDateTime = formatedDateTime;
    }

    this.setRPMValue = function (rPMValue) {
        _rPMValue = rPMValue;
    }

    this.setFuelLevelValue = function (fuelLevelValue) {
        _fuelLevelValue = fuelLevelValue;
    }

    this.setAceleration = function (aceleration) {
        _aceleration = aceleration;
    }

    this.setEngineTemperature = function (engineTemperature) {
        _engineTemperature = engineTemperature;
    }

    /*Getters*/
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getDateTimeUTC = function () {
        return _dateTimeUTC;
    }

    this.getFormatedDateTime = function () {
        return _formatedDateTime;
    }

    this.getRPMValue = function () {
        return _rPMValue;
    }

    this.getFuelLevelValue = function () {
        return _fuelLevelValue;
    }

    this.getAceleration = function () {
        return _aceleration;
    }

    this.getEngineTemperature = function () {
        return _engineTemperature;
    }

    //---Constructor---//
    this.setVehicleFuelMeasureChartItem = function (queryGraphInfo) {
        if (queryGraphInfo) {
            this.setVehicleName(queryGraphInfo.name);
            var newDate = new Date(queryGraphInfo.dateTimeUTC);
            this.setDateTimeUTC(ChartUtils.parseDate(newDate.toISOString(), "%Y-%m-%dT%H:%M:%S.%LZ"));
            this.setFormatedDateTime(queryGraphInfo.formatedDateTimeUTC);
            this.setRPMValue(queryGraphInfo.rPMValue);
            this.setFuelLevelValue(queryGraphInfo.fuelLevelValue);
            this.setAceleration(queryGraphInfo.aceleration);
            this.setEngineTemperature(queryGraphInfo.engineTemperature);
        }
    }
}

//------------------------------Modelo de grafica de actividad de conductor --------------------------//
function DriverActivityChartItem() {

    /*Properties*/
    var _driverId;
    var _dateTimeUTC;
    var _formatedDateTime;
    var _latitude;
    var _longitude;
    var _speed;

    /*Setters*/
    this.setDriverId = function (driverId) {
        _driverId = driverId;
    }

    this.setDateTimeUTC = function (dateTimeUTC) {
        _dateTimeUTC = dateTimeUTC;
    }

    this.setFormatedDateTime = function (formatedDateTime) {
        _formatedDateTime = formatedDateTime;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.setSpeed = function (speed) {
        _speed = speed;
    }

    /*Getters*/
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getDateTimeUTC = function () {
        return _dateTimeUTC;
    }

    this.getFormatedDateTime = function () {
        return _formatedDateTime;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.getSpeed = function () {
        return _speed;
    }

    //---Constructor---//
    this.setDriverActivityChartItem = function (queryGraphInfo) {
        if (queryGraphInfo) {
            this.setDriverId(queryGraphInfo.driverId);
            var newDate = new Date(queryGraphInfo.dateTimeUTC);
            this.setDateTimeUTC(ChartUtils.parseDate(newDate.toISOString(), "%Y-%m-%dT%H:%M:%S.%LZ"));
            this.setFormatedDateTime(queryGraphInfo.formatedDateTimeUTC);
            this.setLatitude(queryGraphInfo.latitude);
            this.setLongitude(queryGraphInfo.longitude);
            this.setSpeed(queryGraphInfo.speed);
        }
    }
}


//------------------------------Modelo de grafica de temperatura --------------------------//
function VehicleTemperatureActivityChartItem() {

    /*Properties*/
    var _vehicleName;
    var _dateTimeUTC;
    var _formatedDateTime;
    var _latitude;
    var _longitude;
    var _temperatureValue;

    /*Setters*/
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setDateTimeUTC = function (dateTimeUTC) {
        _dateTimeUTC = dateTimeUTC;
    }

    this.setFormatedDateTime = function (formatedDateTime) {
        _formatedDateTime = formatedDateTime;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.setTemperatureValue = function (temperatureValue) {
        _temperatureValue = temperatureValue;
    }

    /*Getters*/
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getDateTimeUTC = function () {
        return _dateTimeUTC;
    }

    this.getFormatedDateTime = function () {
        return _formatedDateTime;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.getTemperatureValue = function () {
        return _temperatureValue;
    }

    //---Constructor---//
    this.setVehicleTemperatureActivityChartItem = function (queryGraphInfo) {
        if (queryGraphInfo) {
            this.setVehicleName(queryGraphInfo.name);
            var newDate = new Date(queryGraphInfo.dateTimeUTC);
            this.setDateTimeUTC(ChartUtils.parseDate(newDate.toISOString(), "%Y-%m-%dT%H:%M:%S.%LZ"));
            this.setFormatedDateTime(queryGraphInfo.formatedDateTimeUTC);
            this.setLatitude(queryGraphInfo.latitude);
            this.setLongitude(queryGraphInfo.longitude);
            this.setTemperatureValue(queryGraphInfo.temperatureValue);
        }
    }
}

//------------------------------Modelo de grafica de consulta de eventos --------------------------//
function VehicleEventActivityChartItem() {

    /*`PROPERTIES*/
    var _vehicleName;
    var _dateTimeUTC;
    var _hourDate;
    var _formatedDateTime;
    var _latitude;
    var _longitude;
    var _eventTypeId;
    var _eventValue;

    /*SETTERS*/
    this.setVehicleName = function (vehicleName) {
        _vehicleName = vehicleName;
    }

    this.setDateTimeUTC = function (dateTimeUTC) {
        _dateTimeUTC = dateTimeUTC;
    }

    this.setHourDate = function (hourDate) {
        _hourDate = hourDate;
    }

    this.setFormatedDateTime = function (formatedDateTime) {
        _formatedDateTime = formatedDateTime;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.setEventTypeId = function (eventTypeId) {
        _eventTypeId = eventTypeId;
    }

    this.setEventValue = function (eventValue) {
        _eventValue = eventValue;
    }

    /*GETTERS*/
    this.getVehicleName = function () {
        return _vehicleName;
    }

    this.getDateTimeUTC = function () {
        return _dateTimeUTC;
    }

    this.getHourDate = function () {
        return _hourDate;
    }

    this.getFormatedDateTime = function () {
        return _formatedDateTime;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.getEventTypeId = function () {
        return _eventTypeId;
    }

    this.getEventValue = function () {
        return _eventValue;
    }

    /*CONSTRUCTOR*/
    this.setVehicleEventActivityChartItem = function (queryGraphInfo) {
        if (queryGraphInfo) {
            this.setVehicleName(queryGraphInfo.vehicleName);
            var newDate = new Date(queryGraphInfo.dateTimeUTC);
            this.setDateTimeUTC(ChartUtils.parseDate(newDate.toISOString(), "%Y-%m-%dT%H:%M:%S.%LZ"));
            this.setHourDate(ChartUtils.getHour(this.getDateTimeUTC()));
            this.setFormatedDateTime(queryGraphInfo.formatedDateTimeUTC);
            this.setLatitude(queryGraphInfo.latitude);
            this.setLongitude(queryGraphInfo.longitude);
            this.setEventTypeId(queryGraphInfo.eventTypeId);
            this.setEventValue(queryGraphInfo.eventValue);
        }
    }
}