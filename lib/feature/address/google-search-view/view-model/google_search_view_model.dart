import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/location/google_address_location.dart';
import 'package:dyd/model/google-address-model/google_address_model.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class GoogleSearchViewModel extends GetxController {
  Rx<Status> kSearchResultLoading = Status.initial.obs;
  Rx<Status> kSearchAddressLatAndLongLoading = Status.initial.obs;
  RxBool isSearchedResultIsEmpty = false.obs;

  RxBool enabled = true.obs;

  RxList<GoogleMapAddressModel> kSearchedAddressResultList =
      <GoogleMapAddressModel>[].obs;

  //search result from text field
  Future<List<GoogleMapAddressModel>> fObservableSearchAddress(
      String input) async {
    kSearchResultLoading(Status.loading);
    if (input.isNotEmpty) {
      List<GoogleMapAddressModel> placesList =
          await GoogleAddressLocationRepo.searchLocation(input);
      kSearchedAddressResultList.clear();
      kSearchedAddressResultList.addAll(placesList);
      if (placesList.isEmpty) {
        isSearchedResultIsEmpty(true);
      } else {
        isSearchedResultIsEmpty(false);
      }
      kSearchResultLoading(Status.success);
      return placesList;
    } else {
      disableFields(true);
    }
    kSearchedAddressResultList.clear();
    kSearchResultLoading(Status.success);
    return [];
  }

  Future<(double, double)> fGetLatAndLongFromSearchBarAddress(
      String address) async {
    double latitude = 0.0;
    double longitude = 0.0;
    try {
      kSearchAddressLatAndLongLoading(Status.loading);
      geocoding.Location? location =
          await _getLatitudeAndLongitudeFromAddress(address);
      if (location != null) {
        latitude = location.latitude;
        longitude = location.longitude;
      }
      kSearchAddressLatAndLongLoading(Status.success);
      return (latitude, longitude);
    } catch (e) {
      kSearchAddressLatAndLongLoading(Status.initial);
      rethrow;
    }
  }

  //get lat and long from address
  Future<geocoding.Location?> _getLatitudeAndLongitudeFromAddress(
      String address) async {
    try {
      List<geocoding.Location> location =
          await geocoding.locationFromAddress(address);
      if (location.isNotEmpty) {
        return location.first;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  void disableFields(bool b) {
    enabled(b);
  }
}
