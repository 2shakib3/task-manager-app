import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_management_app/app.dart';
import 'package:task_management_app/data/models/network_response.dart';
import 'package:task_management_app/ui/controller/auth_controller.dart';
import 'package:task_management_app/ui/screens/signin_screen.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken.toString(),
      };

      debugPrint(url);
      final Response response = await get(uri,headers: headers);
      debugPrintRequest(url, null, headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            errorMessage: 'Unauthenticated');
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      debugPrintRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      printResponse(url, response);
      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodeData['data'],
          );
        }
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        _moveToLogin();
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            errorMessage: 'Unauthenticated');
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBody: ${response.body}',
    );
  }

  static void debugPrintRequest(
      String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? headers,
      ) {
    debugPrint('Request\nURL : $url\nBODY : $body\nHEADERS : $headers');
  }

  static void _moveToLogin() async{
    await AuthController.clearUserToken();
    Navigator.pushAndRemoveUntil(TaskManagerApp.navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => const SigninScreen()), (_) => false);
  }

}