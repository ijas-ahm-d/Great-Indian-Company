import 'package:flutter/material.dart';
import 'package:great_gpt/data/response/api_response.dart';
import 'package:great_gpt/models/chat_model.dart';
import 'package:great_gpt/repository/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final _myrepo = ChatRepository();
  ApiResponse<List<ChatModel>> chatList = ApiResponse.loading();
  ApiResponse<List<ChatModel>> get getChatList {
    return chatList;
  }

  setChat(ApiResponse<List<ChatModel>> data) {
    chatList = data;
  }

  void addUserMessage({required String msg}) {
    chatList.data?.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({required String msg}) async {
    try {
      final response = await _myrepo.sendMessage(message: msg);
      chatList = ApiResponse.completed(response);
    } catch (error) {
      chatList = ApiResponse.error(error.toString());
    }
    notifyListeners();
  }
}
