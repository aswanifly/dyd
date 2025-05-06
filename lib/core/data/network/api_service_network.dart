import 'package:image_picker/image_picker.dart';

import 'dio_network_api_function.dart';
import 'network_call_method.dart';

class ApiService implements NetworkCallMethod {
  final DioNetworkCall _dioNetworkCall = DioNetworkCall();

  @override
  Future apiTypeGet({required String url, String? token}) async {
    try {
      Map<String, dynamic> header = {"authorization": "Bearer $token"};
      final response = await _dioNetworkCall.callApi(
          url: url, method: "GET", headers: token == null ? null : header);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future apiTypePost(
      {required String url,
        required String? token,
        required String body}) async {
    try {
      Map<String, dynamic> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "authorization": "Bearer $token",
      };
      final response = await _dioNetworkCall.callApi(
          url: url,
          method: "POST",
          headers: token == null ? null : header,
          data: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future apiTypePut(
      {required String url,
        required String? token,
        required String body}) async {
    try {
      Map<String, dynamic> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "authorization": "Bearer $token",
      };
      final response = await _dioNetworkCall.callApi(
          url: url,
          method: 'PUT',
          headers: token == null ? null : header,
          data: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future apiTypeDelete(
      {required String url,
        required String? token,
        required String body}) async {
    try {
      Map<String, dynamic> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "authorization": "Bearer $token",
      };
      final response = await _dioNetworkCall.callApi(
          url: url,
          method: "DELETE",
          headers: token == null ? null : header,
          data: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future apiTypeMultiPart(
      {required String url, required String token, required XFile file}) async {
    try {
      final response = await _dioNetworkCall.apiTypeMultiPart(
          url: url, token: token, file: file);
      return response;
    } catch (e) {
      rethrow;
    }
  }

// @override
// Future apiTypeMultiPart(
//     {required String url, required String token, required XFile file}) async {
//   FormData formData = FormData.fromMap({
//     'file':
//     await MultipartFile.fromFile(file.path, filename: "jpf/${file.name}"),
//   });
//   final response = await _dio.post(url,
//       data: formData,
//       options: Options(
//           headers: {
//             'Content-type': 'multipart/form-data',
//             "authorization": "Bearer $token",
//           },
//           receiveTimeout: const Duration(seconds: 90),
//           sendTimeout: const Duration(seconds: 90)));
//
//   return response;
// }
}
