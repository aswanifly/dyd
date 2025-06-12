import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/helper/error_helper.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/feature/cart/screen/cart_screen.dart';
import 'package:dyd/feature/landing/controller/landing_controller.dart';
import 'package:dyd/feature/landing/screen/landing_screen.dart';
import 'package:dyd/model/address-model/address_model.dart';
import 'package:dyd/repo/address-repo/address_repo.dart';
import 'package:dyd/repo/google-repo/google_repo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:logger/web.dart';

import '../../../core/location/perfect_location.dart';
import '../../../model/google-address-model/google_address_model.dart';

class AddressViewModel extends GetxController {
  RxBool kMapType = false.obs;

  Rx<Status> searchingAddressLoadingStatus = Status.initial.obs;
  Rx<Status> searchResultLoading = Status.initial.obs;
  Rx<Status> addingLoadingStatus = Status.initial.obs;
  Rx<Status> kGetLoadingStatus = Status.initial.obs;
  Rx<Status> kOverLayAddressLoadingStatus = Status.initial.obs;
  Rx<Status> editViewSearchingAddressLoadingStatus = Status.initial.obs;
  Rx<Status> updatingLoadingStatus = Status.initial.obs;
  Rx<Status> kAddressLoadingStatus = Status.initial.obs;
  Rx<AddressDetailModel?> kSelectedAddressModel = Rx(null);

  RxList<AddressDetailModel> kAllAddressList = <AddressDetailModel>[].obs;
  RxList<AddressDetailModel> kTempAllAddressList = <AddressDetailModel>[].obs;
  RxList<AddressDetailModel> kSearchedAddressList = <AddressDetailModel>[].obs;
  RxList<AddressDetailModel> kTotalAddressList = <AddressDetailModel>[].obs;

  RxBool isSearchedResultIsEmpty = false.obs;

  RxBool enabled = true.obs;

  RxBool isAddressSelected = false.obs;

  RxBool kSearchEnabled = false.obs;

  RxString selectedAddressTitleText = "".obs;
  RxString cityValue = "".obs;
  RxString selectedAddressSubTitleText = "".obs;
  RxString stateValue = "".obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxInt kCurrentLocationPincode = 0.obs;
  RxString kCurrentAddress = "Loading".obs;

  // RxList<AddAddressModel> addressList = <AddAddressModel>[].obs;

  Rx<LatLng> markerPosition = Rx(const LatLng(28.7041, 77.1025));
  Rx<LatLng> editMarkerPosition = Rx(const LatLng(28.7041, 77.1025));

  late GoogleMapController googleMapController;

  RxString selectedAddressType = "".obs;

  RxString kCurrentLocationAddressForAddress = "".obs;

  final kAddressSearchTxt = TextEditingController();

  final nameTxt = TextEditingController();
  final phoneTxt = TextEditingController();

  final newAddressTxt = TextEditingController();
  final floorTxt = TextEditingController();
  final landmarkTxt = TextEditingController();
  final searchController = TextEditingController();
  final editNewAddressTxt = TextEditingController();
  final editLandmarkTxt = TextEditingController();
  final editFloorTxt = TextEditingController();
  final editNameTxt = TextEditingController();
  final editPhoneTxt = TextEditingController();
  RxDouble editLatitude = 0.0.obs;
  RxDouble editLongitude = 0.0.obs;
  RxList<GoogleMapAddressModel> searchedAddressResultList =
      <GoogleMapAddressModel>[].obs;

  void disableFields(bool b) {
    enabled(b);
  }

  void onGoogleMapCreate(GoogleMapController controller) {
    googleMapController = controller;
  }

  void onMapPressed(LatLng position) async {
    try {
      searchingAddressLoadingStatus(Status.loading);
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 20)));
      markerPosition(position);
      await getAddressFromLatAndLongFromSelectedAddress(
          position.latitude, position.longitude);
      isAddressSelected(true);
      searchingAddressLoadingStatus(Status.success);
    } catch (e) {
      searchingAddressLoadingStatus(Status.error);
    }
  }

  Future<void> fDeleteAddress(BuildContext context, String addressId) async {
    try {
      kOverLayAddressLoadingStatus(Status.loading);
      final response = await AddressRepo.fDeleteAddress(addressId);
      Logger().i(response.response);
      kOverLayAddressLoadingStatus(Status.success);
      fGetAddedAddress();
      if (context.mounted) {
        showCustomSnackBar(
          context,
          "Address deleted",
        );
      }
    } catch (e) {
      kOverLayAddressLoadingStatus(Status.error);
      if (context.mounted) {
        ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> editLocationAccessAndCurrentLocation(
      AddressDetailModel editAddressModel) async {
    try {
      editViewSearchingAddressLoadingStatus(Status.loading);
      isAddressSelected(true);
      // bool hasLocationAccess =
      //     await PerfectLocation.kCheckLocationPermissionAndRequest();

      // if (hasLocationAccess) {
      //   Position position = await Geolocator.getCurrentPosition();
      longitude(editAddressModel.location!.coordinates.isEmpty
          ? 0.0
          : editAddressModel.location!.coordinates[0]);
      latitude(editAddressModel.location!.coordinates.isEmpty
          ? 0.0
          : editAddressModel.location!.coordinates[1]);
      //if the location is not null then assign new camera position
      //and new marker position
      //future.delay - waiting for googleMapController to be initialised
      Future.delayed(const Duration(seconds: 2), () async {
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    editAddressModel.location!.coordinates.isEmpty
                        ? 0.0
                        : editAddressModel.location!.coordinates[1],
                    editAddressModel.location!.coordinates.isEmpty
                        ? 0.0
                        : editAddressModel.location!.coordinates[0]),
                zoom: 20)));
        //new marker position
        markerPosition(LatLng(
            editAddressModel.location!.coordinates.isEmpty
                ? 0.0
                : editAddressModel.location!.coordinates[1],
            editAddressModel.location!.coordinates.isEmpty
                ? 0.0
                : editAddressModel.location!.coordinates[0]));
        //fetch address from latitude and longitude

        await getAddressFromLatAndLongFromSelectedAddress(
            editAddressModel.location!.coordinates.isEmpty
                ? 0.0
                : editAddressModel.location!.coordinates[1],
            editAddressModel.location!.coordinates.isEmpty
                ? 0.0
                : editAddressModel.location!.coordinates[0]);
        //showing bottom card if the value is not null
        editViewSearchingAddressLoadingStatus(Status.success);
      });
    } catch (e) {
      Logger().e(e);
      editViewSearchingAddressLoadingStatus(Status.initial);
    }
  }

//edit address
  //add address
  Future<void> checkLocationAccessAndCurrentLocation() async {
    try {
      searchingAddressLoadingStatus(Status.loading);
      bool hasLocationAccess =
          await PerfectLocation.kCheckLocationPermissionAndRequest();

      if (hasLocationAccess) {
        Position position = await Geolocator.getCurrentPosition();
        // Position position = await _fetchCurrentLocation();
        longitude(position.longitude);
        latitude(position.latitude);
        //if the location is not null then assign new camera position
        //and new marker position
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 20)));
        //new marker position
        markerPosition(LatLng(position.latitude, position.longitude));
        //fetch address from latitude and longitude
        getAddressFromLatAndLongFromSelectedAddress(
            position.latitude, position.longitude);
        //showing bottom card if the value is not null
        isAddressSelected(true);
      }
      searchingAddressLoadingStatus(Status.success);
    } catch (e) {
      searchingAddressLoadingStatus(Status.initial);
    }
  }

  Future<Position> _fetchCurrentLocation() async {
    Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
    if (lastKnownPosition != null) {
      return lastKnownPosition;
    } else {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    }
  }

  //get address from lat and long
  Future<void> getAddressFromLatAndLongFromSelectedAddress(
      double lat, double long) async {
    try {
      geocoding.Placemark? placemark =
          await _getAddressFromLatAndLong(lat, long);

      if (placemark != null) {
        selectedAddressTitleText(placemark.street);
        selectedAddressSubTitleText(
            "${placemark.locality}, ${placemark.administrativeArea}");
        cityValue(placemark.locality);
        stateValue(placemark.administrativeArea);
        kCurrentLocationPincode(int.parse(placemark.postalCode ?? "0"));
      }
    } catch (e) {
      // UtilWidgets.toastMessage("Location error");
    }
  }

  //get address from latitude and longitude
  Future<geocoding.Placemark?> _getAddressFromLatAndLong(
      double lat, double long) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        lat,
        long,
      );
      //if not empty then pass the first item
      //else null
      if (placemarks.isNotEmpty) {
        return placemarks.first;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GoogleMapAddressModel>> observableSearchAddress(
      String input) async {
    searchResultLoading(Status.loading);
    if (input.isNotEmpty) {
      List<GoogleMapAddressModel> placesList =
          await GoogleAddressRepository().searchLocation(input);
      searchedAddressResultList.clear();
      searchedAddressResultList.addAll(placesList);
      if (placesList.isEmpty) {
        isSearchedResultIsEmpty(true);
      } else {
        isSearchedResultIsEmpty(false);
      }
      searchResultLoading(Status.success);
      return placesList;
    } else {
      disableFields(true);
    }
    searchedAddressResultList.clear();
    searchResultLoading(Status.success);
    return [];
  }

  Future<void> getCurrentLocationWithAddressDetails() async {
    try {
      bool hasLocationAccess =
          await PerfectLocation.kCheckLocationPermissionAndRequest();
      if (!hasLocationAccess) {
        // searchingAddressLoadingStatus(Status.initial);
        // UtilWidgets.toastMessage("Please give location access");
        return;
      } else {
        searchingAddressLoadingStatus(Status.loading);
        Get.back();
        Position position = await Geolocator.getCurrentPosition();
        longitude(position.longitude);
        latitude(position.latitude);
        //if the location is not null then assign new camera position
        //and new marker position
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 20)));
        //new marker position
        markerPosition(LatLng(position.latitude, position.longitude));
        //fetch address from latitude and longitude
        getAddressFromLatAndLongFromSelectedAddress(
            position.latitude, position.longitude);
        //showing bottom card if the value is not null
        isAddressSelected(true);
      }
      searchingAddressLoadingStatus(Status.success);
    } catch (e) {
      searchingAddressLoadingStatus(Status.initial);
    }
  }

  Future<void> getCurrentLocationWithAddressDetailsForAddingAddress(
      BuildContext context) async {
    try {
      bool hasLocationAccess =
          await PerfectLocation.kCheckLocationPermissionAndRequest();
      if (!hasLocationAccess) {
        // searchingAddressLoadingStatus(Status.initial);
        // UtilWidgets.toastMessage("Please give location access");
        return;
      } else {
        kOverLayAddressLoadingStatus(Status.loading);
        Position position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.bestForNavigation));
        Logger().i("${position.longitude} ${position.latitude}");
        longitude(position.longitude);
        latitude(position.latitude);
        //if the location is not null then assign new camera position
        //and new marker position
        geocoding.Placemark? placemark = await _getAddressFromLatAndLong(
            position.latitude, position.longitude);
        if (placemark != null) {
          selectedAddressTitleText(placemark.street);
          selectedAddressSubTitleText(
              "${placemark.locality}, ${placemark.administrativeArea}");
          cityValue(placemark.locality);
          stateValue(placemark.administrativeArea);
          kCurrentLocationPincode(int.parse(placemark.postalCode ?? "0"));
        }
        await fAddAddressWithOutDetail(context);
      }
      kOverLayAddressLoadingStatus(Status.success);
    } catch (e) {
      kOverLayAddressLoadingStatus(Status.initial);
    }
  }

  Future<void> fGetCurrentAddress() async {
    try {
      if (kSelectedAddressModel.value != null) {
        String address = kSelectedAddressModel.value!.city;
        kCurrentAddress(address);
        // Get.find<LabourViewModel>().kSelectedAddress(address);
        // Get.find<MachineryViewModel>().kCurrentAddress(address);
        // Get.find<LandServiceViewModel>().kCurrentAddress(address);
        // Get.find<LiveStockViewController>().kSelectedAddress(address);

        return;
      }
      kAddressLoadingStatus(Status.loading);
      bool hasLocationAccess =
          await PerfectLocation.kCheckLocationPermissionAndRequest();
      if (hasLocationAccess) {
        Position position = await Geolocator.getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.reduced));
        await getAddressFromLatAndLongFromSelectedAddress(
            position.latitude, position.longitude);
      } else {
        kCurrentAddress("Add address");
      }
      kAddressLoadingStatus(Status.success);
    } catch (e) {
      kCurrentAddress("");
      kAddressLoadingStatus(Status.error);
    }
  }

  //get current location address
  Future<void> fGetCurrentLocationAddress() async {
    try {
      kCurrentLocationAddressForAddress("Loading...");
      bool hasLocationAccess =
          await PerfectLocation.kCheckLocationPermissionAndRequest();
      if (!hasLocationAccess) {
        searchingAddressLoadingStatus(Status.initial);
        kCurrentLocationAddressForAddress("");
        // UtilWidgets.toastMessage("Please give location access");
        return;
      } else {
        Position position = await Geolocator.getCurrentPosition();
        longitude(position.longitude);
        latitude(position.latitude);
        //if the location is not null then assign new camera position
        //and new marker position
        geocoding.Placemark? placemark = await _getAddressFromLatAndLong(
            position.latitude, position.longitude);
        if (placemark != null) {
          String address = "${placemark.street},${placemark.locality}";
          kCurrentLocationAddressForAddress(address);
        }
      }
    } catch (e) {
      kCurrentLocationAddressForAddress("");
    }
  }

  //get location from search bar
  Future<void> getLatAndLongFromSearchBar(String address) async {
    try {
      searchingAddressLoadingStatus(Status.loading);
      geocoding.Location? location =
          await _getLatitudeAndLongitudeFromAddress(address);
      if (location != null) {
        //if the location is not null then assign new camera position
        //and new marker position
        longitude(location.longitude);
        latitude(location.latitude);
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(location.latitude, location.longitude),
                zoom: 20)));
        //new marker position
        markerPosition(LatLng(location.latitude, location.longitude));
        //fetch address from latitude and longitude
        getAddressFromLatAndLongFromSelectedAddress(
            location.latitude, location.longitude);
        //showing bottom card if the value is not null
        isAddressSelected(true);
      }
      searchingAddressLoadingStatus(Status.success);
    } catch (e) {
      searchingAddressLoadingStatus(Status.initial);
      // UtilWidgets.toastMessage("Location not found.");
    }
  }

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

  Future<void> fAddAddress(BuildContext context, String functionType) async {
    try {
      addingLoadingStatus(Status.loading);

      Map<String, dynamic> body = {
        "area":
            "${selectedAddressTitleText.value},${selectedAddressSubTitleText.value}",
        "streetName": newAddressTxt.text.trim(),
        "landMark": landmarkTxt.text.trim(),
        "city": cityValue.value,
        "pincode": kCurrentLocationPincode.value.toString(),
        "state": stateValue.value,
        "country": "India",
        "name": nameTxt.text.trim(),
        "phone": phoneTxt.text.trim(),
        "isDefault": true, // for toggle
        "location": {
          "type": "Point",
          "coordinates": [longitude.value, latitude.value]
        }
      };

      Logger().i(body);
      final response = await AddressRepo.fAddNewAddress(body);
      cityValue("");
      newAddressTxt.clear();
      selectedAddressSubTitleText("");
      selectedAddressTitleText("");
      floorTxt.clear();
      stateValue("");
      nameTxt.clear();
      phoneTxt.clear();
      selectedAddressType("");
      landmarkTxt.clear();
      latitude(0.0);
      longitude(0.0);
      Get.back();
      if (functionType == "addMoreDetail") {
        Get.back();
      }
      fGetAddedAddress();
      addingLoadingStatus(Status.success);
      if (context.mounted) {
        // Get.back();
        // SnackBarUtil.showCustomSnackBar(
        //     context: context,
        //     message: response.response["message"],
        //     snackBarType: SnackBarType.success);
      }
    } catch (e) {
      Logger().e(e);
      addingLoadingStatus(Status.error);
      // if (context.mounted) {
      //   ErrorHelper.handleExceptions(context: context, exception: e);
      // }
    }
  }

  //add address without detail
  Future<void> fAddAddressWithOutDetail(BuildContext context) async {
    try {
      Map<String, dynamic> body = {
        "area":
            "${selectedAddressTitleText.value},${selectedAddressSubTitleText.value}",
        "streetName": newAddressTxt.text.trim(),
        "landMark": landmarkTxt.text.trim(),
        "city": cityValue.value,
        "pincode": kCurrentLocationPincode.value.toString(),
        "state": stateValue.value,
        "country": "India",
        "name": "",
        "phone": "",
        "isDefault": true, // for toggle
        "location": {
          "type": "Point",
          "coordinates": [longitude.value, latitude.value]
        }
      };
      Logger().i(body);
      final response = await AddressRepo.fAddNewAddress(body);
      Logger().f(response.response);
      cityValue("");
      newAddressTxt.clear();
      selectedAddressSubTitleText("");
      selectedAddressTitleText("");
      floorTxt.clear();
      stateValue("");
      nameTxt.clear();
      phoneTxt.clear();
      selectedAddressType("");
      landmarkTxt.clear();
      latitude(0.0);
      longitude(0.0);
      if (context.mounted) {
        fGetAddedAddress();
      }
    } catch (e) {
      Logger().e(e);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> fUpdateNewAddress(BuildContext context, String addressId) async {
    updatingLoadingStatus(Status.loading);

    try {
      Map<String, dynamic> body = {
        "addressId": addressId,
        "area":
            "${selectedAddressTitleText.value},${selectedAddressSubTitleText.value}",
        "streetName": editNewAddressTxt.text.trim(),
        "landMark": editLandmarkTxt.text.trim(),
        "city": cityValue.value,
        "pincode": kCurrentLocationPincode.value,
        "state": stateValue.value,
        "country": "India",
        "name": editNameTxt.text.trim(),
        "phone": editPhoneTxt.text.trim(),
        "location": {
          "type": "Point",
          "coordinates": [
            longitude.value,
            latitude.value,
          ]
        }
      };
      Logger().f(body);
      final response = await AddressRepo.fEditAddedAddress(body);
      Logger().i(response.response);
      if (context.mounted) {
        updatingLoadingStatus(Status.success);
        Get.back();
        Get.back();
        fGetAddedAddress();
        // SnackBarUtil.showCustomSnackBar(
        //     context: context,
        //     message: response.response["message"],
        //     snackBarType: SnackBarType.success);
      }
    } catch (e) {
      updatingLoadingStatus(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> fGetAddedAddress() async {
    try {
      kGetLoadingStatus(Status.loading);
      final res = await AddressRepo.fGetAddedAddress();
      kAllAddressList.clear();
      kTempAllAddressList.clear();
      kSearchedAddressList.clear();
      kTotalAddressList.clear();
      kAllAddressList.addAll(res);
      kTempAllAddressList.addAll(res);
      kSearchedAddressList.addAll(res);
      kGetLoadingStatus(Status.success);
    } catch (e) {
      kGetLoadingStatus(Status.error);
      // if (context.mounted) {
      //   ErrorHelper.handleExceptions(context: context, exception: e);
      // }
    }
  }

  void fSearchAddress(String value) {
    if (value.isEmpty) {
      kSearchEnabled(false);
      kAllAddressList.clear();
      kAllAddressList.addAll(kTempAllAddressList);
    }
    kSearchEnabled(true);
    List<AddressDetailModel> result = kTempAllAddressList
        .where((item) =>
            item.area.toLowerCase().contains(value.toLowerCase()) ||
            item.name.toLowerCase().contains(value.toLowerCase()) ||
            item.phone.toLowerCase().contains(value.toLowerCase()))
        .toList();
    kAllAddressList.clear();
    kAllAddressList.addAll(result);
  }

  void getAddressOnMapDrag(LatLng target) {}

  // Future<void> fDeleteAddress(BuildContext context, String addressId) async {
  //   try {
  //     kOverLayAddressLoadingStatus(Status.loading);
  //     final response = await AddressRepo.fDeleteAddress(addressId);
  //     Logger().i(response.response);
  //     kOverLayAddressLoadingStatus(Status.success);
  //     fGetAddedAddress();
  //     if (context.mounted) {
  //       // SnackBarUtil.showCustomSnackBar(
  //       //     context: context,
  //       //     message: "Address deleted",
  //       //     snackBarType: SnackBarType.success);
  //     }
  //   } catch (e) {
  //     kOverLayAddressLoadingStatus(Status.error);
  //     if (context.mounted) {
  //       // ErrorHelper.handleExceptions(context: context, exception: e);
  //     }
  //   }
  // }

  Future<void> fSetDefaultAddress(
      BuildContext context, String addressId) async {
    try {
      kOverLayAddressLoadingStatus(Status.loading);
      final response = await AddressRepo.fSetDefaultAddress(addressId);
      Logger().i(response.response);
      // Map<String, dynamic> extMappedData = response.response["data"];
      // Get.find<LandingViewModel>().kSelectedAddressModel(
      //   SelectedAddressModel(
      //       selectedAddressId: extMappedData["_id"],
      //       selectedAddressText: extMappedData["address"]["area"],
      //       selectedLatitude: extMappedData["location"]["coordinates"][1],
      //       selectedLongitude: extMappedData["location"]["coordinates"][0]),
      // );
      kOverLayAddressLoadingStatus(Status.success);
      fGetAddedAddress();

      if (context.mounted) {
        showCustomSnackBar(context, response.response["message"]);
        Get.offAll(() => NavigationScreen(
              showSplash: false,
            ));

        Get.find<LandingController>().kCurrentScreenIndex(2);

        // SnackBarUtil.showCustomSnackBar(
        //     context: context,
        //     message: response.response["message"],
        //     snackBarType: SnackBarType.success);
      }
    } catch (e) {
      kOverLayAddressLoadingStatus(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }
}
