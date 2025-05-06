//api response
class ApiResponse {
  final int? statusCode;
  final dynamic response;

  ApiResponse({this.statusCode, required this.response});
}