import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:powerpay/firebase_options.dart';
import 'package:powerpay/screens/logins/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:powerpay/util/assetdata.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((value) => runApp( const MyApp()));
  
}


class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      navigatorKey: hud.navigatorKey,
      title: 'PowerPay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const AuthPage(),  
    );
  }
}