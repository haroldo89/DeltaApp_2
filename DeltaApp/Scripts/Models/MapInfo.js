/*Modelo del mapa*/
function MapInfo() {

    //Recuperar clave de acceso a los servicios de Bing Maps.
    var bingMapKey = sessionStorage.getItem('BingMapKey');
    //Clave de acceso a los servicios de Bing Maps
    MapInfo.BING_MAP_KEY = bingMapKey;
    //Cursor por defecto del mapa
    MapInfo.DEFAULT_CURSOR = 'url("http://ecn.dev.virtualearth.net/mapcontrol/v7.0/cursors/grab.cur"), move';

    //Propiedades privadas
    var _zoomLevel;
    var _latitude;
    var _longitude;

    //Getters y Setters
    this.getZoomLevel = function () {
        return _zoomLevel;
    }

    this.setZoomLevel = function (value) {
        _zoomLevel = value;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.setLatitude = function (value) {
        _latitude = value;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.setLongitude = function (value) {
        _longitude = value;
    }

    //Mètodos públicos
    this.setLocation = function (geoText) {
        //Obtener latitud apartir del punto geografico.
        var latitude = CommonUtils.getLatitude(geoText);
        //Obtener Longitud apartir del punto geografico.
        var longitude = CommonUtils.getLongitude(geoText);
        //Latitud
        this.setLatitude(latitude);
        //Longitud
        this.setLongitude(longitude);
    }
}

//Representa la información de una geocerca que es representada en un mapa.
function GeoFenceInfo() {

    /*--properties--*/
    var _points;
    var _geoFenceName;
    var _geoFenceDescription;
    var _geoFenceColor;

    /*--setters--*/

    /*Establecer Puntos de geocerca*/
    this.setPoints = function (points) {
        _points = new Array();
        points.forEach(function (point) {
            var location = BingMapHelper.createLocation(point.latitude, point.longitude);
            _points.push(location);
        });
    }
    /*Establecer Nombre de Geocerca*/
    this.setGeoFenceName = function (geoFenceName) {
        _geoFenceName = geoFenceName;
    }
    /*Establecer Descripcion de geocerca*/
    this.setGeoFenceDescription = function (geoFenceDescription) {
        _geoFenceDescription = geoFenceDescription;
    }
    /*Establecer Color de geocerca formato hexadecimal*/
    this.setGeoFenceColor = function (geoFenceColor) {
        _geoFenceColor = geoFenceColor;
    }

    /*--getters--*/

    /*Obtener puntos de geocerca*/
    this.getPoints = function () {
        return _points;
    }

    /*Obtener nombre de geocerca*/
    this.getGeoFenceName = function () {
        return _geoFenceName;
    }

    /*Obtener descripcion de geocerca*/
    this.getGeoFenceDescription = function () {
        return _geoFenceDescription;
    }

    /*Obtener color de geocerca formato hexadecimal*/
    this.getGeoFenceColor = function () {
        return _geoFenceColor;
    }

    /*Establecer propiedades de geocerca*/
    this.setGeoFenceInfo = function (geoFenceInfo) {
        if (geoFenceInfo) {
            /*Nombre*/
            this.setGeoFenceName(geoFenceInfo.geoFenceName);
            /*Descripcion*/
            this.setGeoFenceDescription(geoFenceInfo.geoFenceDescription);
            /*Color de geocerca*/
            this.setGeoFenceColor(geoFenceInfo.geoFenceColor);
            /*Establecer puntos de geocerca*/
            this.setPoints(geoFenceInfo.geoFencePoints);
        }
    }
}

//Representa la información de una ruta que es representado en un mapa.
function RouteInfo() {

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
    this.setRouteInfo = function (routeInfo) {
        if (routeInfo) {
            this.setRouteId(routeInfo.routeId);
            this.setRouteName(routeInfo.routeName);
            this.setRouteDescription(routeInfo.routeDescription);
            this.setRouteColor(routeInfo.routeColor);
            this.setPoints(routeInfo.routePoints);
        }
    }
}

/*Representa la información de un punto de control o referencia que es visualizado en un mapa.*/
function CheckPointInfo() {
    /*Propiedades*/
    var _checkPointId;
    var _name;
    var _latitude;
    var _longitude;
    var _address;
    var _checkPointTypeId;
    var _iconPath;
    var _customerId;
    var _radius;

    /*Getters y Setters*/
    this.getCheckPointId = function () {
        return _checkPointId;
    }

    this.setCheckPointId = function (checkPointId) {
        _checkPointId = checkPointId;
    }

    this.getName = function () {
        return _name;
    }

    this.setName = function (name) {
        _name = name;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.getAddress = function () {
        return _address;
    }

    this.setAddress = function (address) {
        _address = address;
    }

    this.getCheckPointTypeId = function () {
        return _checkPointTypeId;
    }

    this.setCheckPointTypeId = function (checkPointTypeId) {
        _checkPointTypeId = checkPointTypeId;
    }

    this.getIconPath = function () {
        return _iconPath;
    }

    this.setIconPath = function (iconPath) {
        _iconPath = iconPath;
    }
 
    this.getCustomerId = function () {
        return _customerId;
    }

    this.setCustomerId = function (customerId) {
        _customerId = customerId;
    }

    this.getRadius = function () {
        return _radius;
    }

    this.setRadius = function (radius) {
        _radius = radius;
    }
    
    /*Establecer propiedaades del punto*/
    this.setCheckPointInfo = function (checkPoint) {
        if (checkPoint) {
            this.setCheckPointId(checkPoint.checkPointId);
            this.setLatitude(checkPoint.latitude);
            this.setLongitude(checkPoint.longitude);
            this.setName(checkPoint.name);
            this.setAddress(checkPoint.address);
            this.setCheckPointTypeId(checkPoint.checkPointTypeId);
            this.setIconPath(checkPoint.iconPath);
            this.setCustomerId(checkPoint.customerId);
            this.setRadius(checkPoint.radius);
        }
    }
}

/*Representa la información de un escla de viaje que es visualizado en un mapa.*/
function TripScaleInfo() {
    /*Propiedades*/
    var _checkPointId;
    var _name;
    var _latitude;
    var _longitude;
    var _address;
    var _checkPointTypeId;
    var _iconPath;
    var _customerId;
    var _radius;
    var _tripScale;

    /*Getters y Setters*/
    this.getCheckPointId = function () {
        return _checkPointId;
    }

    this.setCheckPointId = function (checkPointId) {
        _checkPointId = checkPointId;
    }

    this.getName = function () {
        return _name;
    }

    this.setName = function (name) {
        _name = name;
    }

    this.getLatitude = function () {
        return _latitude;
    }

    this.setLatitude = function (latitude) {
        _latitude = latitude;
    }

    this.getLongitude = function () {
        return _longitude;
    }

    this.setLongitude = function (longitude) {
        _longitude = longitude;
    }

    this.getAddress = function () {
        return _address;
    }

    this.setAddress = function (address) {
        _address = address;
    }

    this.getCheckPointTypeId = function () {
        return _checkPointTypeId;
    }

    this.setCheckPointTypeId = function (checkPointTypeId) {
        _checkPointTypeId = checkPointTypeId;
    }

    this.getIconPath = function () {
        return _iconPath;
    }

    this.setIconPath = function (iconPath) {
        _iconPath = iconPath;
    }

    this.getCustomerId = function () {
        return _customerId;
    }

    this.setCustomerId = function (customerId) {
        _customerId = customerId;
    }

    this.getRadius = function () {
        return _radius;
    }

    this.setRadius = function (radius) {
        _radius = radius;
    }

    this.getTripScale = function () {
        return _tripScale;
    }

    this.setTripScale = function (tripScale) {
        _tripScale = tripScale;
    }

    /*Establecer propiedaades del punto*/
    this.setTripScaleInfo = function (tripScaleInfo) {
        if (tripScaleInfo) {
            this.setCheckPointId(tripScaleInfo.checkPointId);
            this.setLatitude(tripScaleInfo.latitude);
            this.setLongitude(tripScaleInfo.longitude);
            this.setName(tripScaleInfo.name);
            this.setAddress(tripScaleInfo.address);
            this.setCheckPointTypeId(tripScaleInfo.checkPointTypeId);
            this.setIconPath(tripScaleInfo.iconPath);
            this.setCustomerId(tripScaleInfo.customerId);
            this.setRadius(tripScaleInfo.radius);
            this.setTripScale(tripScaleInfo.tripScale);
        }
    }
}