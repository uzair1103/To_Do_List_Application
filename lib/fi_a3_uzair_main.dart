import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:to_do_list_app/firebase_options.dart';

import 'fi_a3_uzair_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: LoginScreen(),
      //home: DisplayData(),
    );
  }
}
