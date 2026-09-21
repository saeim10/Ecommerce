
class NetworkResponse{
  final bool isSuccess;
  final int statusCode;
  Map<String, dynamic>? body;
  String? errorMessage;

  NetworkResponse({required this.isSuccess, required this.statusCode, this.body, this.errorMessage});
}