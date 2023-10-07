import 'package:great_gpt/data/network/http_api_services.dart';
import 'package:great_gpt/data/network/network_api_service.dart';
import 'package:great_gpt/models/chat_model.dart';

class ChatRepository {
  HttpApiServices apiServices = NetworkApiServices();
  Future sendMessage({required String message}) async {
    try {
      final response = await apiServices.httpPostMethod(message: message);
      return ChatModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
