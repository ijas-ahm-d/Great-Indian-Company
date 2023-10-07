import 'package:great_gpt/models/chat_model.dart';
import 'package:great_gpt/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
class ApiService {
  

  // Send Message using ChatGPT API
  static Future<List<ChatModel>> sendMessageGPT(
      {required String message}) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/chat/completions"),
        headers: {
          'Authorization': 'Bearer $apikey',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model":  "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": message,
              }
            ]
          },
        ),
      );

      // Map jsonResponse = jsonDecode(response.body);
      Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  // Send Message fct
  // static Future<List<ChatModel>> sendMessage(
  //     {required String message, required String modelId }) async {
  //   try {
  //     var response = await http.post(
  //       Uri.parse("$baseUrl/completions"),
  //       headers: {
  //         'Authorization': 'Bearer $apikey',
  //         "Content-Type": "application/json"
  //       },
  //       body: jsonEncode(
  //         {
  //           "model":modelId,
  //           "prompt": message,
  //           "max_tokens": 300,
  //         },
  //       ),
  //     );

  //     // Map jsonResponse = jsonDecode(response.body);

  //     Map jsonResponse = json.decode(utf8.decode(response.bodyBytes));
  //     if (jsonResponse['error'] != null) {
  //       // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
  //       throw HttpException(jsonResponse['error']["message"]);
  //     }
  //     List<ChatModel> chatList = [];
  //     if (jsonResponse["choices"].length > 0) {
  //       // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
  //       chatList = List.generate(
  //         jsonResponse["choices"].length,
  //         (index) => ChatModel(
  //           msg: jsonResponse["choices"][index]["text"],
  //           chatIndex: 1,
  //         ),
  //       );
  //     }
  //     return chatList;
  //   } catch (error) {
  //     log("error $error");
  //     rethrow;
  //   }
  // }
}