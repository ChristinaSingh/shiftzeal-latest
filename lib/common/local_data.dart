import 'dart:math';

import '../apis/api_constants/api_key_constants.dart';

class LocalData {
  // static LoginModel? loginModel;
  static String userType = ApiKeyConstants.user;
  static String lat = '51.1657';
  static String lon = '10.4515';

  static void setLatLon(String lat, String lon) {
    LocalData.lat = lat;
    LocalData.lon = lon;
    print('Successfully set current location lat lon...');
  }

  static String getDistanceBetween(String givenLat, String givenLon) {
    const double R = 6371; // Earth's radius in km
    double dLat =
        _toRadians(double.parse(givenLat) - double.parse(LocalData.lat));
    double dLon =
        _toRadians(double.parse(givenLon) - double.parse(LocalData.lon));

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(double.parse(givenLat))) *
            cos(_toRadians(double.parse(LocalData.lat))) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return '${(R * c).toStringAsFixed(2)} Km'; // Distance in km
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
