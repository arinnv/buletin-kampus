import 'package:buletin_kampus/screen/SplashScreen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'utils/app_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: AppConstant.firebaseName,
    options: const FirebaseOptions(
      apiKey: AppConstant.firebaseApiKey,
      appId: AppConstant.firebaseAppId,
      messagingSenderId: AppConstant.messagingSenderId,
      projectId: AppConstant.projectId,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buletin Kampus',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SplashScreen(),
    );
  }
}
