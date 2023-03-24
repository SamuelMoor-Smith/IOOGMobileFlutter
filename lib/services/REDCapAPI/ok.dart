import 'dart:developer';
import 'package:flutter/material.dart';
import 'api_constants.dart';

Map<String, String> okBody() {
      return Map.of({
        "token": APIConstants.token!,
        "content": "version",
        "format": "json",
      });
    }

Future<bool> apiOK() async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var http;
      var response = await http.post(
        url, 
        body: okBody(), 
        headers: APIConstants.headers()
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }