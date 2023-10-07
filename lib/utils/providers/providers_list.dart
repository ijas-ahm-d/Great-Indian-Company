import 'package:great_gpt/view_model/auth_view_model.dart';
import 'package:great_gpt/view_model/chat_view_model.dart';
import 'package:great_gpt/view_model/login_view_model.dart';
import 'package:great_gpt/view_model/models_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class ProvidersList {
  static List<SingleChildWidget> provider = [
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
    ),
     ChangeNotifierProvider(
      create: (context) => ModelsViewModel(),
    ),
ChangeNotifierProvider(
      create: (context) => ChatViewModel(),
    ),
    
  ];
}
