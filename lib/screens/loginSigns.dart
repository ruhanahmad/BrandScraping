import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/screens/adminLogin.dart';
import 'package:scrapingdart/screens/login.dart';
import 'package:scrapingdart/screens/loginOnly.dart';
import 'package:scrapingdart/screens/signup.dart';

class LoginSigns extends StatefulWidget {
  const LoginSigns({super.key});

  @override
  State<LoginSigns> createState() => _LoginSignsState();
}

class _LoginSignsState extends State<LoginSigns> {
  @override
  Widget build(BuildContext context) {
    //colors added
    Color dark = Color(0xFF395B64);
    Color light = Color(0xFFA5C9CA);
    Color extralight = Color(0xFFE7F6F2);
    Color extradark = Color(0xFF2C3333);

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
              ),
              SizedBox(
                height: 80,
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: light,
                      onPrimary: dark,
                      minimumSize: Size(180, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Login'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(SignUp());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: light,
                      onPrimary: dark,
                      minimumSize: Size(180, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(AdminLoginScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      primary: light,
                      onPrimary: dark,
                      minimumSize: Size(180, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Admin Login'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
