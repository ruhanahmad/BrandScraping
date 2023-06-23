import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrapingdart/screens/login.dart';
import 'package:scrapingdart/screens/loginSigns.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Color dark = Color(0xFF395B64);
  Color light = Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginSigns())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: extralight,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/logo.jpeg'))),
              ),
              Padding(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      "Dis Nav",
                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
