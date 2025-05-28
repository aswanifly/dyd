import 'package:dio/dio.dart';
import 'package:dyd/core/constant/app-url/app_url.dart';

import 'package:logger/logger.dart';

import '../../model/google-address-model/google_address_model.dart';

class GoogleAddressRepository {
  String apiKey = "AIzaSyD0pb4Bwj8KYUWRimZfmNuZQ9BOotkezF4";
  String sessionToken = "1234567890";

  Future<List<GoogleMapAddressModel>> searchLocation(String input) async {
    // String apiKey = "AIzaSyAOMji3n-B_sxi5JQeamCkHEF-aCDy6eiY";
    String request =
        "${AppUrl.googleApi}?input=$input&components=country:IND&key=$apiKey&sessiontoken=$sessionToken";

    try {
      var response = await Dio().get(request);
      var data = response.data;
      List tempList = data['predictions'];
      Logger().f(tempList[0]);
      List<GoogleMapAddressModel> resList =
          tempList.map((e) => GoogleMapAddressModel.fromJson(e)).toList();

      return resList;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  Future<List> getPlaceById(String placeId) async {
    List tempList = [];
    String mapApiWithPlaceId =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await Dio().get(mapApiWithPlaceId);
    final data = response.data;
    List extData = data["result"]["address_components"];
    if (extData.isNotEmpty) {
      tempList.addAll(extData);
    }
    return tempList;
  }
}

// https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=AIzaSyD0pb4Bwj8KYUWRimZfmNuZQ9BOotkezF4&sessiontoken=1234567890
