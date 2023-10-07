import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:great_gpt/data/app_exceptions.dart';
import 'package:great_gpt/data/network/http_api_services.dart';
import 'package:great_gpt/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiServices extends HttpApiServices {
  @override
  Future httpPostMethod({required String message}) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/chat/completions"),
        headers: {
          'Authorization': 'Bearer $apikey',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      final successResponse = returnResponse(response);
      return successResponse;
    } on SocketException {
      throw "No Internet connection";
    }
  }

  returnResponse(Response response) {
    final jsonBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        log("1");
        return response.body;
      case 201:
        log("2");
        return response.body;
      case 400:
        log("3");
        throw BadRequestException(jsonBody["error"]);
      case 401:
        log("4");
        throw UnAuthorizedException(jsonBody["message"]);
      case 409:
        log("5");
        throw UnAuthorizedException(jsonBody["message"]);
      default:
        log("default");
        throw FetchDataException("Unknown error ${response.statusCode}");
    }
  }
}
