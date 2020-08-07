// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2014/04/10.
// Empresa			        :   Wizenz Technologies
// Proyecto			        :   NAVI30
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Funciones generales del mapa de bing.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================
function BingMapHelper() { }


BingMapHelper.INFOBOX_HTML_TEMPLATE = '<div class="infobox"><div class="infobox_content">{content}</div></div>';

//Crea instancia de un mapa.
BingMapHelper.createMap = function (container, options) {
    var map = new Microsoft.Maps.Map(container, options);
    return map;
}

//Crea una instancia de objeto Map Location
BingMapHelper.createLocation = function (latitude, longitude) {
    var location = new Microsoft.Maps.Location(latitude, longitude);
    return location;
}

//Crea una instancia de tipo punto
BingMapHelper.createPoint = function (coordinateX, coordinateY) {
    var point = new Microsoft.Maps.Point(coordinateX, coordinateY)
    return point;
}

//Permite centrar un punto especifico en el mapa.
BingMapHelper.centerMap = function (map, latitude, longitude) {
    var pointLocation = BingMapHelper.createLocation(latitude.toString(), longitude.toString());
    map.setView(
    {
        center: pointLocation
    });
}

//Permite crear una polilinea a partir de un conjunto de puntos.
BingMapHelper.createPolyline = function (points, options) {
    var polyline = null;
    if (points) {
        polyline = new Microsoft.Maps.Polyline(points, options);
    }
    return polyline;
}

//Permite crear un poligono a partir de un conjunto de puntos.
BingMapHelper.createPolygon = function (points, options) {
    var polygon = null;
    if (points) {
        polygon = new Microsoft.Maps.Polygon(points, options);
    }
    return polygon;
}

//Convierte la coordena a radianes
BingMapHelper.toRadian = function (v) {
    return v * (Math.PI / 180);
};

//Convierte la coordena a grados
BingMapHelper.toDegrees = function (radians) {
    return radians * 180 / Math.PI;
};

//Crear el poligono del radio desede el centro de una coordenada
BingMapHelper.createCircle = function (centerPoint, radius) {
    //var earthRadiusInMiles = 3956.0;
    var earthRadiusInMeters = 6367.0 * 1000;
    var lat = BingMapHelper.toRadian(centerPoint.latitude); //radians
    var lon = BingMapHelper.toRadian(centerPoint.longitude); //radians
    var d = parseFloat(radius) / earthRadiusInMeters;  // d = angular distance covered on earth's surface
    var points = new Array();
    for (x = 0; x <= 360; x++) {
        var brng = BingMapHelper.toRadian(x); //radians
        var latRadians = Math.asin(Math.sin(lat) * Math.cos(d) + Math.cos(lat) * Math.sin(d) * Math.cos(brng));
        var lngRadians = lon + Math.atan2(Math.sin(brng) * Math.sin(d) * Math.cos(lat), Math.cos(d) - Math.sin(lat) * Math.sin(latRadians));

        points.push(BingMapHelper.createLocation(BingMapHelper.toDegrees(latRadians), BingMapHelper.toDegrees(lngRadians)));
    }
    //Opciones de poligono o geocerca
    var optionsPolygon = {
        //color de relleno
        fillColor: CommonUtils.toHexToColor('#FF008000'),
        //color de borde
        strokeColor: new Microsoft.Maps.Color(255, 0, 0, 0),
        //tamaño del borde
        strokeThickness: 1
    };
    var circlePolygon = BingMapHelper.createPolygon(points, optionsPolygon);
    return circlePolygon;
}

//Permite crear un infobox.
BingMapHelper.createInfobox = function (point, options) {
    var infobox = null;
    if (point) {
        infobox = new Microsoft.Maps.Infobox(point, options);
    }
    return infobox;
}

//Permite centrar una lista de puntos especificos en el mapa
BingMapHelper.boundCenterMap = function (map, points) {
    var pointsLocation = new Microsoft.Maps.LocationRect.fromLocations(points);
    map.setView(
    {
        bounds: pointsLocation
    });
}

//Permite hacer zoom sobre el mapa a un nivel especifico.
BingMapHelper.zoomMap = function (map, zoom) {
    map.setView(
    {
        zoom: zoom
    });
}

//Permite obtener un color para el mapa.
BingMapHelper.colorFromHex = function (hex) {
    var color = null;
    if (hex) {
        color = new Microsoft.Maps.Color.fromHex(hex);
    }
    return color;
}

//Permite crear un objeto tipo pushpin.
BingMapHelper.createPushpin = function (location, options) {
    var pushpin = new Microsoft.Maps.Pushpin(location, options);
    return pushpin
}

//Devuelve el punto central de una georeferencia
BingMapHelper.getCenter = function (points) {
    if (points) {
        //Obtener centro de geocerca por medio de un rectangulo.
        var minLongitude = Enumerable.from(points).min("$.longitude");
        var minLatitude = Enumerable.from(points).min("$.latitude");;
        var maxLongitude = Enumerable.from(points).max("$.longitude");
        var maxLatitude = Enumerable.from(points).max("$.latitude");
        var northwestLocation = new Microsoft.Maps.Location(maxLatitude, minLongitude);
        var southeastLocation = new Microsoft.Maps.Location(minLatitude, maxLongitude);
        //Creacion de rectangulo.
        var rectangle = Microsoft.Maps.LocationRect.fromCorners(northwestLocation, southeastLocation);
        return rectangle.center;
    }
    return null;
}

//Genera menu contextual para el clic derecho sobre el mapa
BingMapHelper.getTooltipHtml = function (tooltipMessage, tooltipTitle) {
    var tooltipHtml = '';
    if (!CommonUtils.isNullOrEmpty(tooltipMessage)) {
        var tooltipMessageHtml = '<div style="width: auto;"> '
        //Tiene titulo
        if (!CommonUtils.isNullOrEmpty(tooltipTitle)) {
            tooltipMessageHtml += String.format('<b>{0}</b><br/>', titleMenu);
        }
        tooltipMessageHtml += String.format('<div>{0}</div></div>', tooltipMessage);
        tooltipHtml = BingMapHelper.INFOBOX_HTML_TEMPLATE.replace('{content}', tooltipMessageHtml);
    }
    return tooltipHtml;
}

BingMapHelper.createTooltip = function (point, tooltipText) {
    var infoboxOptions = {
        //Contenido HTML del infobox
        htmlContent: BingMapHelper.getTooltipHtml(tooltipText)
    };
    //Crear infobox para el tooltip
    var toolTipInfobox = BingMapHelper.createInfobox(point, infoboxOptions);
    return toolTipInfobox;
}

BingMapHelper.addGeoReferenceTooltip = function (sender, tooltipMessage, mapLayer) {
    var tooltip = null;
    if (sender) {
        var targetType = sender.targetType;
        switch (targetType) {
            case 'polygon':
                tooltip = BingMapHelper.addGeoFenceTooltip(sender, tooltipMessage);
                break;
            case 'polyline':
                tooltip = BingMapHelper.addWayTooltip(sender, tooltipMessage);
                break;
            case 'pushpin':
                tooltip = BingMapHelper.addPointTooltip(sender, tooltipMessage);
                break;
            default:
                break;
        }
        if (mapLayer) {
            if (tooltip) {
                //Adicionar infobox al Layer 
                mapLayer.push(tooltip);
            }
        }
    }
}

//Permite crear un tooltip a un objeto de tipo polygon.
BingMapHelper.addGeoFenceTooltip = function (sender, tooltipMessage) {
    var tooltip = null;
    //Obtener puntos de GeoCerca.
    var polygonPoints = sender.target.getLocations();
    //Establecer punto en donde se va a mostrar el tooltip
    var tooltipPoint = BingMapHelper.getCenter(polygonPoints);
    if (tooltipPoint != null) {
        //Creacion de tooltip.
        tooltip = BingMapHelper.createTooltip(tooltipPoint, tooltipMessage);
    }
    return tooltip;
}

//Permite crear un tooltip a un objeto de tipo polyline.
BingMapHelper.addWayTooltip = function (sender, tooltipMessage) {
    var tooltip = null;
    //Obtener puntos de Via.
    var polylinePoints = sender.target.getLocations();
    //Establecer punto en donde se va a mostrar el tooltip
    var tooltipPoint = BingMapHelper.getCenter(polylinePoints);
    //Obtener punto mas cercano al punto central creado.
    var queryResult = Enumerable.from(polylinePoints).orderBy(function (x) { return BingMapHelper.haversineDistance(x, tooltipPoint) }).first();
    if (queryResult != null) {
        //Creacion de tooltip.
        tooltip = BingMapHelper.createTooltip(queryResult, tooltipMessage);
    }
    return tooltip;
}

//Permite crear un tooltip a un objeto de tipo punto.
BingMapHelper.addPointTooltip = function (sender, tooltipMessage) {
    var tooltip = null;
    //Obtener punto.
    var tooltipPoint = sender.target.getLocation();
    if (tooltipPoint != null) {
        //Creacion de tooltip.
        tooltip = BingMapHelper.createTooltip(tooltipPoint, tooltipMessage);
    }
    return tooltip;
}

//Calcula la distancia entre dos puntos
BingMapHelper.haversineDistance = function (firstPoint, secondPoint) {
    var distance = 0;
    //radio en kilometros
    var EARTH_RADIUS_KMS = 6367;

    var firstPointLatitude = CommonUtils.DegrestoRadians(firstPoint.latitude);
    var firstPointLongitude = CommonUtils.DegrestoRadians(firstPoint.longitude);
    var secondPointLatitude = CommonUtils.DegrestoRadians(secondPoint.latitude);
    var secondPointLongitude = CommonUtils.DegrestoRadians(secondPoint.longitude);

    var latitudesDelta = secondPointLatitude - firstPointLatitude;
    var longitudesDelta = secondPointLongitude - firstPointLongitude;

    var cordLength = Math.pow(Math.sin(latitudesDelta / 2), 2) + Math.cos(firstPointLatitude) * Math.cos(secondPointLatitude) * Math.pow(Math.sin(longitudesDelta / 2), 2);
    var centralAngle = 2 * Math.atan2(Math.sqrt(cordLength), Math.sqrt(1 - cordLength));
    distance = centralAngle * EARTH_RADIUS_KMS;
    return distance;
}