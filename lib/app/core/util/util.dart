// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:geocoding/geocoding.dart';

///A utitlity class for special helpers.
class Util {
  ///Static method to convert GeoPoint to an actual address.
  static Future<String> convertToAddress({
    required double lat,
    required double lng,
  }) async {
    final address = await placemarkFromCoordinates(lat, lng);
    return address[0].street!;
  }
}
