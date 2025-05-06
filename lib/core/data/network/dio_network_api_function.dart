import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../error/expection_c.dart';


class DioNetworkCall {
  final Dio _dio = Dio();
  final Map<String, CancelToken> _cancelTokens = {};
  CancelToken? _cancelToken;

  /// Singleton pattern for ApiService
  static final DioNetworkCall _instance = DioNetworkCall._internal();

  factory DioNetworkCall() => _instance;

  DioNetworkCall._internal();

  Future<Response?> callApi(
      {required String url,
        required String method,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        dynamic data,
        String? cancelRequestTag}) async {
    // Cancel any ongoing request
    // _cancelOngoingRequest();

    // Create a new CancelToken for the current request
    // _cancelToken = CancelToken();

    try {
      final options = Options(
        method: method,
        headers: headers,
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      );

      // Make the API call
      final response = await _dio.request(
        url,
        options: options,
        queryParameters: queryParameters,
        data: data,
        cancelToken: _cancelToken,
      );

      return response;
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw "Request to $url was cancelled.";
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Cancel the ongoing API request
  void _cancelOngoingRequest() {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel("Cancelled to make a new request.");
    }
  }

  //file upload
  Future apiTypeMultiPart(
      {required String url, required String token, required XFile file}) async {
    String fileExtension = file.path.split('.').last.toLowerCase();

    // check MIME type dynamically
    String mimeType;
    if (['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(fileExtension)) {
      mimeType = 'image/$fileExtension';
    } else if (['mp4', 'mov', 'avi', 'mkv', 'flv'].contains(fileExtension)) {
      mimeType = 'video/$fileExtension';
    } else {
      throw ServerException('Unsupported file type');
    }
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.name,
        contentType: MediaType(mimeType.split('/')[0], mimeType.split('/')[1]),
      ),
    });
    final response = await _dio.post(url,
        data: formData,
        options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
              "authorization": "Bearer $token",
            },
            receiveTimeout: const Duration(seconds: 90),
            sendTimeout: const Duration(seconds: 90)));

    return response;
  }
}
