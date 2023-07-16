import 'package:buletin_kampus/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  checkAuth() async {
    final auth = FirebaseAuth.instance.currentUser;
    //jika auth null dia kehalaman login
    if (auth == null) {
      Future.delayed(const Duration(seconds: 3)).then(
        // (value) => Navigator.push(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        ),
      );
    } else {
      Future.delayed(const Duration(seconds: 3)).then(
        // ini akan mengarahkan ke halaman homescreen
        // (value) => Navigator.push(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[700],
        child: Center(
          child: Column(
            children: <Widget>[
              new Padding(
                  padding: new EdgeInsets.only(
                bottom: 80.0,
                top: 100,
              )),
              new Image.asset(
                "assets/buletin.png",
                width: 200.0,
              ),
              new Padding(padding: new EdgeInsets.all(10.0)),
              new Image.asset(
                "assets/1.png",
                width: 300.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
