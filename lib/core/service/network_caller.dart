import 'dart:convert';

import 'package:craftybay_ecommerce/core/model/network_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkCaller {
  final String _defaultErrorMessage = 'Something went wrong';
  String Function() accessToken;
  NetworkCaller({required this.accessToken});

  Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url); // API Url convert to uri
    Map<String, String> headers = {'token': accessToken()};
    _logRequest(url, null, headers);
    Response response = await get(uri,headers: headers); //Uri invokes by get method
    _logResponse(url, response);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        body: data,
      );
    } else {
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: _defaultErrorMessage,
      );
    }
  }

  Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    Uri uri = Uri.parse(url);
    Map<String, String> headers = {
      'token': accessToken(),
      'Content-Type': 'application/json',
    };
    debugPrint('TOKEN FROM NETWORK CALLER: ${accessToken()}');
    debugPrint('HEADERS: $headers');
    _logRequest(url, null, headers);
    Response response = await post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    _logResponse(url, response);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        body: data,
      );
    } else {
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: _defaultErrorMessage,
      );
    }
  }

  static void _logRequest(
    String url,
    Map<String, String>? body,
    Map<String, String>? headers,
  ) {
    debugPrint(
      '================== REQUEST ========================\n'
      'URL: $url\n'
      'HEADERS: $headers\n'
      'BODY: $body\n'
      '=============================================',
    );
  }

  static void _logResponse(String url, Response response) {
    debugPrint(
      '=================== RESPONSE =======================\n'
      'URL: $url\n'
      'STATUS CODE: ${response.statusCode}\n'
      'BODY: ${response.body}\n'
      '=============================================',
    );
  }
}
