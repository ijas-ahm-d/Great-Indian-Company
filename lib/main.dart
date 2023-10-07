import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:great_gpt/utils/colors.dart';
import 'package:great_gpt/utils/constants.dart';
import 'package:great_gpt/utils/providers/providers_list.dart';
import 'package:great_gpt/utils/routes/navigations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constants.apikey,
          appId: Constants.appId,
          messagingSenderId: Constants.messagingSenderId,
          projectId: Constants.projectId),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList.provider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Gpt',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          useMaterial3: true,
          // primarySwatch: Colors.green,
        ),
        routes: Navigations.routes(),
        initialRoute: Navigations.loginScreen,
        navigatorKey: Navigations.navigatorKey,
      ),
    );
  }
}
