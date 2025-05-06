import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../error/expection_c.dart';
import '../error/failure_c.dart';
import '../network/api_service_network.dart';
import 'api_response.dart';

class ApiCallType {
  // Singleton instance
  static final ApiCallType _instance = ApiCallType._internal();

  // API service instance
  final ApiService _apiService = ApiService();

  // Private constructor
  ApiCallType._internal();

  // Factory constructor to return the singleton instance
  factory ApiCallType() => _instance;

  final String _baseUrl = "http://3.109.206.246/dev/";

  Future<ApiResponse> getRequest({required String url, String? token}) async {
    try {
      final fullUrl = "$_baseUrl$url";
      final Response response =
      await _apiService.apiTypeGet(url: fullUrl, token: token);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data["message"]);
      }
      if (response.data["responseCode"] == 200) {
        return ApiResponse(
            statusCode: response.data["responseCode"], response: response.data);
      } else {
        throw ServerException(response.data["message"]);
      }
    } on SocketException {
      throw "No Internet Connection";
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ApiResponse> postRequest(
      {required String url,
        String? token,
        required Map<String, dynamic> data}) async {
    try {
      final fullUrl = "$_baseUrl$url";
      final Response response = await _apiService.apiTypePost(
        url: fullUrl,
        token: token ?? "",
        body: json.encode(data),
      );
      Logger().i(response.data);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data["message"]);
      }

      if (response.data["responseCode"] == 200 ||
          response.data["responseCode"] == 201) {
        return ApiResponse(
            statusCode: response.data["responseCode"], response: response.data);
      } else {
        throw ServerException(response.data["message"]);
      }
    } on SocketException {
      throw "No Internet Connection";
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ApiResponse> putRequest({
    required String url,
    String? token,
    required Map<String, dynamic> data,
  }) async {
    try {
      final fullUrl = "$_baseUrl$url";
      final Response response = await _apiService.apiTypePut(
        url: fullUrl,
        token: token,
        body: jsonEncode(data),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data["message"]);
      }
      if (response.data["responseCode"] == 200) {
        return ApiResponse(
            statusCode: response.data["responseCode"], response: response.data);
      } else {
        throw ServerException(response.data["message"]);
      }
    } on SocketException {
      throw "No Internet Connection";
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<ApiResponse> deleteRequest({
    required String url,
    required String token,
    required Map<String, dynamic> data,
  }) async {
    try {
      final fullUrl = "$_baseUrl$url";
      final Response response = await _apiService.apiTypeDelete(
        url: fullUrl,
        token: token,
        body: jsonEncode(data),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data["message"]);
      }
      if (response.data["responseCode"] == 200) {
        return ApiResponse(
            statusCode: response.data["responseCode"], response: response.data);
      } else {
        throw ServerException(response.data["message"]);
      }
    } on SocketException {
      throw "No Internet Connection";
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> uploadMediaFile(
      {required String url, required String token, required XFile file}) async {
    try {
      final fullUrl = "$_baseUrl$url";
      final Response response = await _apiService.apiTypeMultiPart(
          url: fullUrl, token: token, file: file);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data["message"]);
      }
      if (response.data["responseCode"] == 200) {
        return response.data;
      } else {
        throw ServerException(response.data["message"]);
      }
    } on SocketException {
      throw "No Internet Connection";
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  //handle error
  ServerFailure _handleError(DioException error) {
    String errorMessage;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timeout. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive timeout. Please try again.";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Send timeout. Please try again.";
        break;
      case DioExceptionType.badResponse:
      // Handle network errors
        if (error.response != null) {
          errorMessage =
          "Error: ${error.response?.statusCode} - ${error.response?.data}";
        } else {
          errorMessage = "An unexpected error occurred.";
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request cancelled.";
        break;
      default:
        errorMessage = "Something went wrong. Please try again.";
    }
    return ServerFailure(errorMessage); // Return an error object
  }

  Future<dynamic> uploadImageFile(
      {required String url, required String token, required XFile file}) async {
    try {
      final fullUrl = "$_baseUrl$url";
      final Response response = await _apiService.apiTypeMultiPart(
          url: fullUrl, token: token, file: file);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(response.data["message"]);
      }
      if (response.data["responseCode"] == 200) {
        return response.data;
      } else {
        throw ServerException(response.data["message"]);
      }
    } on SocketException {
      throw "No Internet Connection";
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }
}
