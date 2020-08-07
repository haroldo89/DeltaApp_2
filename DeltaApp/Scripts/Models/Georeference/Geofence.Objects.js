/*===========================Reperesenta la informacion de la vista de geocercas=======================-*/
//Representa la informacion del inventario de la geocerca.
function GeofenceInventoryChart() {

    /*--Propiedades--*/
    var _geofenceId;
    var _geofenceName;
    var _totalVehicles;
    

    /*Setters*/
    this.setGeofenceId = function (geofenceId) {
        _geofenceId = geofenceId;
    }

    this.setGeofenceName = function (geofenceName) {
        _geofenceName = geofenceName;
    }

    this.setTotalVehicles = function (totalVehicles) {
        _totalVehicles = totalVehicles;
    }

    /*Getters*/
    this.getGeofenceId = function () {
        return _geofenceId;
    }

    this.getGeofenceName = function () {
        return _geofenceName;
    }

    this.getTotalVehicles = function () {
        return _totalVehicles;
    }

    /*--Contructor--*/
    this.setGeofenceInventory = function (geofenceInventory) {
        if (geofenceInventory) {
            this.setGeofenceId(geofenceInventory.geofenceId);
            this.setGeofenceName(geofenceInventory.geofenceName);
            this.setTotalVehicles(geofenceInventory.totalVehicles);
        }
    }
}


