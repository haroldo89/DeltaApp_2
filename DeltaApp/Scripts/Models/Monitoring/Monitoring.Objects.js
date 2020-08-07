// ===================================================================================================
// Desarrollado Por		    :   Harold Caicedo.
// Fecha de Creación		:   2014/12/30.
// Producto o sistema	    :   Wizenz.Navi
// Empresa			        :   Wizenz Technologies
// Proyecto			        :   NAVI30
// Cliente			        :   Varios.
// ===================================================================================================
// Versión	        Descripción
// 1.0.0.0	        Objetos en el modulo de monitoreo.
// ===================================================================================================
// HISTORIAL DE CAMBIOS:
// ===================================================================================================
// Ver.	 Fecha		    Autor					Descripción
// ---	 -------------	----------------------	------------------------------------------------------
// XX	 yyyy/MM/dd	    [Nombre Completo]	    [Razón del cambio realizado] 
// ===================================================================================================

//Representa la lista de todos los vehiculos en el mapa
var VehicleInfo = {
    vehiclesInfo: [],
    selectedVehicleInfo: null,
    getVehicleInfo: function (vehicleName) {
        var vehicleInfo = Enumerable.from(this.vehiclesInfo).firstOrDefault(function (v) { return v.vehicleName == vehicleName });
        if (vehicleInfo) {
            return vehicleInfo;
        }
        return null;
    }
}

/*Represente un vehiculo en el mapa*/
function VehicleInfoProperties(viewVehicleInfo) {
    if (viewVehicleInfo != null) {
        this.vehicleId = viewVehicleInfo.vehicleId;
        this.vehicleName = viewVehicleInfo.displayName;
        this.vehiclePlate = viewVehicleInfo.plate;
        this.latitude = viewVehicleInfo.latitude;
        this.longitude = viewVehicleInfo.longitude;
        this.iconName = viewVehicleInfo.iconFullPath;
    }
}

/*Representa los detalles de un vehiculo seleccionado.*/
function SelectedVehicleInfoProperties(viewVehicleInfo) {
    if (viewVehicleInfo != null) {
        this.vehicleId = viewVehicleInfo.vehicleId;
        this.vehicleName = viewVehicleInfo.displayName;
        this.vehiclePlate = viewVehicleInfo.plate;
        this.latitude = viewVehicleInfo.latitude;
        this.longitude = viewVehicleInfo.longitude;
        this.address = viewVehicleInfo.address;
        this.speed = viewVehicleInfo.speed;
        this.dateTimeUTC = viewVehicleInfo.dateTimeString;
        this.iconName = viewVehicleInfo.iconFullPath;
        this.engineStatus = viewVehicleInfo.engineStatus;
        this.odometer = viewVehicleInfo.odometer;
        this.fleetName = viewVehicleInfo.fleetName;
        this.allowMaxSpeed = viewVehicleInfo.allowMaxSpeed;
    }
}

/*===========================Reperesenta la informacion de servicio de medicion de combustible=======================-*/
function VehicleFuelMeasureInfo() {

    /*--Propiedades--*/
    var _datetimeUTC;
    var _vehicleId;
    var _displayName;
    var _plate;
    var _fleetId;
    var _fleetName;
    var _fuelLevelValue;
    var _rPMValue;
    var _acceleration;
    var _engineTemperature;

    /*--Setters--*/
    this.setDatetimeUTC = function (datetimeUTC) {
        _datetimeUTC = datetimeUTC;
    }

    this.setVehicleId = function (vehicleId) {
        _vehicleId = vehicleId;
    }

    this.setDisplayName = function (displayName) {
        _displayName = displayName;
    }

    this.setPlate = function (plate) {
        _plate = plate;
    }

    this.setFleetId = function (fleetId) {
        _fleetId = fleetId;
    }

    this.setFleetName = function (fleetName) {
        _fleetName = fleetName;
    }

    this.setFuelLevelValue = function (fuelLevelValue) {
        _fuelLevelValue = fuelLevelValue;
    }

    this.setRPMValue = function (rPMValue) {
        _rPMValue = rPMValue;
    }

    this.setAcceleration = function (acceleration) {
        _acceleration = acceleration;
    }

    this.setEngineTemperature = function (engineTemperature) {
        _engineTemperature = engineTemperature;
    }

    /*--Getters--*/
    this.getDatetimeUTC = function () {
        return _datetimeUTC;
    }

    this.getVehicleId = function () {
        return _vehicleId;
    }

    this.getDisplayName = function () {
        return _displayName;
    }

    this.getPlate = function () {
        return _plate;
    }

    this.getFleetId = function () {
        return _fleetId;
    }

    this.getFleetName = function () {
        return _fleetName;
    }

    this.getFuelLevelValue = function () {
        return _fuelLevelValue;
    }

    this.getRPMValue = function () {
        return _rPMValue;
    }

    this.getAcceleration = function () {
        return _acceleration;
    }

    this.getEngineTemperature = function () {
        return _engineTemperature;
    }
    
    /*--Constructor--*/
    this.setVehicleFuelMeasureInfo = function (vehicleFuelMeasureInfo) {
        if (vehicleFuelMeasureInfo) {
            this.setDatetimeUTC(vehicleFuelMeasureInfo.formatedDateTimeUTC);
            this.setVehicleId(vehicleFuelMeasureInfo.vehicleId);
            this.setDisplayName(vehicleFuelMeasureInfo.displayName);
            this.setPlate(vehicleFuelMeasureInfo.plate);
            this.setFleetId(vehicleFuelMeasureInfo.fleetId);
            this.setFleetName(vehicleFuelMeasureInfo.fleetName);
            this.setFuelLevelValue(vehicleFuelMeasureInfo.fuelLevelValue);
            this.setRPMValue(vehicleFuelMeasureInfo.rPMValue);
            this.setAcceleration(vehicleFuelMeasureInfo.acceleration);
            this.setEngineTemperature(vehicleFuelMeasureInfo.engineTemperature);
        }
    }
}

/*===========================Reperesenta la informacion de servicio de conductores=======================-*/
function VehicleDriverInfo() {

    /*Properties*/
    var _contactId;
    var _identification;
    var _firstName;
    var _lastName;
    var _email;
    var _phone;
    var _mobileNumber;
    var _contactTypeId;
    var _customerId;
    var _externalCode;
    var _licenseExpirationDate;
    var _rHFactor;
    var _operationType;
    var _photoURL;
    var _formatedMobileNumber;
    var _formatedLicenseExpirationDate;
    var _formatedIdentification;
    var _formatedDriverRH;
    var _formatedDriverGS;

    /*Setters*/
    this.setContactId = function (contactId) {
        _contactId = contactId;
    }

    this.setIdentification = function (identification) {
        _identification = identification;
    }

    this.setFirstName = function (firstName) {
        _firstName = firstName;
    }

    this.setLastName = function (lastName) {
        _lastName = lastName;
    }

    this.setEmail = function (email) {
        _email = email;
    }

    this.setPhone = function (phone) {
        _phone = phone;
    }

    this.setMobileNumber = function (mobileNumber) {
        _mobileNumber = mobileNumber;
    }

    this.setContactTypeId = function (contactTypeId) {
        _contactTypeId = contactTypeId;
    }

    this.setCustomerId = function (customerId) {
        _customerId = customerId;
    }

    this.setExternalCode = function (externalCode) {
        _externalCode = externalCode;
    }

    this.setLicenseExpirationDate = function (licenseExpirationDate) {
        _licenseExpirationDate = licenseExpirationDate;
    }

    this.setRHFactor = function (rHFactor) {
        _rHFactor = rHFactor;
    }

    this.setOperationType = function (operationType) {
        _operationType = operationType;
    }

    this.setPhotoURL = function (photoURL) {
        _photoURL = photoURL;
    }

    this.getContactId = function () {
        return _contactId;
    }

    this.setFormatedMobileNumber = function (formatedMobileNumber) {
        _formatedMobileNumber = formatedMobileNumber;
    }

    this.setFormatedLicenseExpirationDate = function (formatedLicenseExpirationDate) {
        _formatedLicenseExpirationDate = formatedLicenseExpirationDate;
    }

    this.setFormatedIdentification = function (formatedIdentification) {
        _formatedIdentification = formatedIdentification;
    }

    this.setFormatedDriverGS = function (formatedDriverGS) {
        _formatedDriverGS = formatedDriverGS;
    }

    this.setFormatedDriverRH = function (formatedDriverRH) {
        _formatedDriverRH = formatedDriverRH;
    }

    /*Getters*/
    this.getIdentification = function () {
        return _identification;
    }

    this.getFirstName = function () {
        return _firstName;
    }

    this.getLastName = function () {
        return _lastName;
    }

    this.getEmail = function () {
        return _email;
    }

    this.getPhone = function () {
        return _phone;
    }

    this.getMobileNumber = function () {
        return _mobileNumber;
    }

    this.getContactTypeId = function () {
        return _contactTypeId;
    }

    this.getCustomerId = function () {
        return _customerId;
    }

    this.getExternalCode = function () {
        return _externalCode;
    }

    this.getLicenseExpirationDate = function () {
        return _licenseExpirationDate;
    }

    this.getRHFactor = function () {
        return _rHFactor;
    }

    this.getOperationType = function () {
        return _operationType;
    }

    this.getPhotoURL = function () {
        return _photoURL;
    }

    this.getFormatedMobileNumber = function () {
        return _formatedMobileNumber;
    }

    this.getFormatedLicenseExpirationDate = function () {
        return _formatedLicenseExpirationDate;
    }

    this.getFormatedIdentification = function () {
        return _formatedIdentification;
    }

    this.getFormatedDriverGS = function () {
        return _formatedDriverGS;
    }

    this.getFormatedDriverRH = function () {
        return _formatedDriverRH;
    }

    /*--Constructor--*/
    this.setVehicleDriverInfo = function (vehicleDriverServiceInfo) {
        if (vehicleDriverServiceInfo) {
            this.setContactId(vehicleDriverServiceInfo.contactId);
            this.setIdentification(vehicleDriverServiceInfo.identification);
            this.setFirstName(vehicleDriverServiceInfo.firstName);
            this.setLastName(vehicleDriverServiceInfo.lastName);
            this.setEmail(vehicleDriverServiceInfo.email);
            this.setPhone(vehicleDriverServiceInfo.phone);
            this.setMobileNumber(vehicleDriverServiceInfo.mobileNumber);
            this.setContactTypeId(vehicleDriverServiceInfo.contactTypeId);
            this.setCustomerId(vehicleDriverServiceInfo.customerId);
            this.setExternalCode(vehicleDriverServiceInfo.externalCode);
            this.setLicenseExpirationDate(vehicleDriverServiceInfo.licenseExpirationDate);
            this.setRHFactor(vehicleDriverServiceInfo.rHFactor);
            this.setOperationType(vehicleDriverServiceInfo.operationType);
            this.setPhotoURL(vehicleDriverServiceInfo.photoURL);
            this.setFormatedMobileNumber(vehicleDriverServiceInfo.formatedMobileNumber);
            this.setFormatedLicenseExpirationDate(vehicleDriverServiceInfo.formatedLicenseExpirationDate);
            this.setFormatedIdentification(vehicleDriverServiceInfo.formatedIdentification);
            this.setFormatedDriverGS(vehicleDriverServiceInfo.formatedDriverGS);
            this.setFormatedDriverRH(vehicleDriverServiceInfo.formatedDriverRH);
        }
    }
}

/*===========================Reperesenta la informacion de servicio de medicion de temperatura=======================-*/
function VehicleTemperatureMeasureInfo() {

    /*--Propiedades--*/
    var _datetimeUTC;
    var _vehicleId;
    var _displayName;
    var _plate;
    var _fleetId;
    var _fleetName;
    var _engineStatus;
    var _temperatureValue;

    /*--Setters--*/
    this.setDatetimeUTC = function (datetimeUTC) {
        _datetimeUTC = datetimeUTC;
    }

    this.setVehicleId = function (vehicleId) {
        _vehicleId = vehicleId;
    }

    this.setDisplayName = function (displayName) {
        _displayName = displayName;
    }

    this.setPlate = function (plate) {
        _plate = plate;
    }

    this.setFleetId = function (fleetId) {
        _fleetId = fleetId;
    }

    this.setFleetName = function (fleetName) {
        _fleetName = fleetName;
    }

    this.setEngineStatus = function (engineStatus) {
        _engineStatus = engineStatus;
    }

    this.setTemperatureValue = function (temperatureValue) {
        _temperatureValue = temperatureValue;
    }

    /*--Getters--*/
    this.getDatetimeUTC = function () {
        return _datetimeUTC;
    }

    this.getVehicleId = function () {
        return _vehicleId;
    }

    this.getDisplayName = function () {
        return _displayName;
    }

    this.getPlate = function () {
        return _plate;
    }

    this.getFleetId = function () {
        return _fleetId;
    }

    this.getFleetName = function () {
        return _fleetName;
    }

    this.getEngineStatus = function () {
        return _engineStatus;
    }
    
    this.getTemperatureValue = function () {
        return _temperatureValue;
    }

    /*--Constructor--*/
    this.setVehicleTemperatureMeasureInfo = function (vehicleTemperatureMeasureInfo) {
        if (vehicleTemperatureMeasureInfo) {
            this.setDatetimeUTC(vehicleTemperatureMeasureInfo.formatedDateTimeUTC);
            this.setVehicleId(vehicleTemperatureMeasureInfo.vehicleId);
            this.setDisplayName(vehicleTemperatureMeasureInfo.displayName);
            this.setPlate(vehicleTemperatureMeasureInfo.plate);
            this.setFleetId(vehicleTemperatureMeasureInfo.fleetId);
            this.setFleetName(vehicleTemperatureMeasureInfo.fleetName);
            this.setEngineStatus(vehicleTemperatureMeasureInfo.engineStatus);
            this.setTemperatureValue(vehicleTemperatureMeasureInfo.temperatureValue);
        }
    }
}

