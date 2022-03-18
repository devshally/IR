// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:geocoder/geocoder.dart';

///A utitlity class for special helpers.
class Util {
  ///Static method to convert GeoPoint to an actual address.
  static Future<String> convertToAddress({
    required double lat,
    required double lng,
  }) async {
    final coordinates = Coordinates(lat, lng);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    return addresses[0].addressLine;
  }
}
