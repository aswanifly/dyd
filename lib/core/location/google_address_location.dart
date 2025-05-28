import 'package:dio/dio.dart';
import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:logger/logger.dart';

// import '../../common/constants/app_urls/appUrls.dart';
import '../../model/google-address-model/google_address_model.dart';

class GoogleAddressLocationRepo {
  static String apiKey = "AIzaSyD0pb4Bwj8KYUWRimZfmNuZQ9BOotkezF4";
  static String sessionToken = "1234567890";

  static Future<List<GoogleMapAddressModel>> searchLocation(
      String input) async {
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
}
