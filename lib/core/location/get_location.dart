import 'package:geolocator/geolocator.dart' as geo_locator;
import 'package:location/location.dart';
import 'package:logger/logger.dart';

enum LocationServiceEnum { SERVICEDISABLED, DISABLED, GRANTED }

class GetLocation {
  static Location location = Location();

  static bool? _serviceEnabled;
  static PermissionStatus? _permissionGranted;

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

      //using geoLocator to get current location
      geo_locator.Position? lastKnownPosition =
          await geo_locator.Geolocator.getLastKnownPosition();

      if (lastKnownPosition != null) {
        return (lastKnownPosition, LocationServiceEnum.GRANTED.name);
      }

      geo_locator.Position position =
          await geo_locator.Geolocator.getCurrentPosition();
      Logger().i(position);
      return (position, LocationServiceEnum.GRANTED.name);
    } catch (e) {
      rethrow;
    }
  }
}
