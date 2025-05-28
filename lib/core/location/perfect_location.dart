import 'package:geolocator/geolocator.dart' as geo_locator;
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

// import '../../common/widget/util_widgets/util_widgets.dart';

enum LocationServiceEnum { SERVICEDISABLED, DISABLED, GRANTED }

class PerfectLocation {
  static Location location = Location();

  static bool? _serviceEnabled;
  static PermissionStatus? _permissionGranted;

  // static LocationData? _locationData;

  //this fun uses location for getting current position
  //but sometimes it fails to fetch the location
  // static Future<(LocationData? locationData, String locationPermissionGranted)>
  //     getPermissionAndLocation([bool isCompulsory = false]) async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled!) {
  //     _serviceEnabled = await location.requestService();
  //     Logger().i(_serviceEnabled);
  //     if (!_serviceEnabled!) {
  //       Logger().i(_serviceEnabled);
  //       return (null, LocationServiceEnum.SERVICEDISABLED.name);
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted == PermissionStatus.denied) {
  //       return (null, LocationServiceEnum.DISABLED.name);
  //     }
  //     if (_permissionGranted == PermissionStatus.deniedForever) {
  //       return (null, LocationServiceEnum.DISABLED.name);
  //     }
  //   }
  //
  //   _locationData = await location.getLocation();
  //   return (_locationData, LocationServiceEnum.GRANTED.name);
  // }

  //this fun uses geoLocator for getting current position
  static Future<(geo_locator.Position?, String)>
      getPermissionAndLocationUsingGeoLocator() async {
    try {
      //check if location service is enabled or not
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled!) {
        // if not enabled then ask for permission
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled!) {
          return (null, LocationServiceEnum.SERVICEDISABLED.name);
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          return (null, LocationServiceEnum.DISABLED.name);
        }
        if (_permissionGranted == PermissionStatus.deniedForever) {
          return (null, LocationServiceEnum.DISABLED.name);
        }
      }

      Logger().w("fetch location");
      //using geoLocator to get current location
      geo_locator.Position position =
          await geo_locator.Geolocator.getCurrentPosition();
      Logger().i(position);
      return (position, LocationServiceEnum.GRANTED.name);
    } catch (e) {
      rethrow;
    }
  }

  // static Future<void> checkPermission() async {
  //   var status = await permission_handler.Permission.location.status;
  //   String _permissionStatus = "Unknown";
  //
  //   if (status.isGranted) {
  //     _permissionStatus = "Permission granted";
  //     return;
  //   }
  //   if (status.isDenied) {
  //     // Request the permission
  //     if (await permission_handler.Permission.location.request().isDenied) {
  //       _permissionStatus = "Permission denied after request";
  //       return;
  //     }
  //   }
  //   if (status.isPermanentlyDenied) {
  //     permission_handler.openAppSettings();
  //     return;
  //   }
  //   LocationData locationData = await location.getLocation();
  // }

  //location
  // static Future<(LocationData? locationData, bool locationPermissionGranted)>
  //     kCheckPermission() async {
  //   var status = await permission_handler.Permission.location.status;
  //   bool permissionGranted = false;
  //
  //   if (status.isGranted) {
  //     //fetch location and send current location
  //     //"Permission granted";
  //     LocationData locationData = await location.getLocation();
  //     return (locationData, true);
  //   }
  //   if (status.isDenied) {
  //     // Request the permission
  //     if (await permission_handler.Permission.location.request().isDenied) {
  //       //"Permission denied after request";
  //       return (null, false);
  //     }
  //   }
  //   if (status.isPermanentlyDenied) {
  //     //permission denied and request from settings
  //     await permission_handler.openAppSettings();
  //     return (null, false);
  //   }
  //
  //   //fetch location and send location data along with permission status
  //   LocationData locationData = await location.getLocation();
  //   return (locationData, true);
  // }

  //check location status
  static Future<bool> checkLocationPermissionAccess() async {
    bool hasLocationAccess = false;
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      hasLocationAccess = false;
    } else {
      final locationStatus =
          await permission_handler.Permission.location.status;
      if (locationStatus.isGranted) {
        hasLocationAccess = true;
      }
    }
    return hasLocationAccess;
  }

  //location
  static Future<bool> kCheckLocationPermissionAndRequest() async {
    var status = await permission_handler.Permission.location.status;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return false;
      }
    }

    if (status.isGranted) {
      //"Permission granted"
      return true;
    }
    if (status.isDenied) {
      // Request the permission
      if (await permission_handler.Permission.location.request().isDenied) {
        // UtilWidgets.toastMessage("Please give location access");
        return false;
      }
    }
    if (status.isPermanentlyDenied) {
      //permission denied and request from settings
      await permission_handler.openAppSettings();
      return false;
    }
    //fetch location and send location data along with permission status
    return true;
  }

  //for getting current location like lat and long
  static Future<geo_locator.Position> getCurrentLocation() async {
    geo_locator.Position position =
        await geo_locator.Geolocator.getCurrentPosition();
    return position;
  }
}
