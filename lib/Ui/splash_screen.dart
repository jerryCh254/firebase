import 'package:firebase_project/firebase%20services/splash_scervices.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashscreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreen.islogin(context);
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "SpleshScreen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
