import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  void initState() {
    new Future.delayed(Duration(seconds: 3), () {
      User user = mAuth.currentUser;
      if (user.uid == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Image.asset('images/supermarket.png'),
        ),
      ),
    );
  }
}
