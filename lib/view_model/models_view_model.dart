import 'package:flutter/material.dart';
import 'package:great_gpt/models/models_model.dart';
import 'package:great_gpt/service/api_service.dart';

class ModelsViewModel extends ChangeNotifier{
  String currentModel = "gpt-3.5-turbo-0301";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}