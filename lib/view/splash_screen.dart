import 'package:firebase_demo/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService=SplashService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashService.islogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text("Firebase tutorial"),)
          ],
        ),
      ),
    );
  }
}