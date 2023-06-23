import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/screens/login.dart';
import 'package:scrapingdart/screens/loginOnly.dart';
import 'signup.dart';

import 'package:get/get.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  Color dark = Color(0xFF395B64);
  Color light = const Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);
  final TextEditingController _emailController = TextEditingController();
  void _sendResetEmail() async {
    String email = _emailController.text.trim();

    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        print('Password reset email sent to $email');
        Get.snackbar("Sent", "Forget Password sent ,Please check your email");
      } catch (error) {
        Get.snackbar("Error", "Email not found");
        print('Error sending password reset email: $error');
      }
    } else {
      // Handle empty email field
      print('Please enter an email address');
    }
  }

  bool _isLoginForm = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _name;
  String? _email, _password;
  String? emailText, passwordText, nameText;
  bool _isAdmin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: extralight,
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.jpeg'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Dis Nav",
                      style: TextStyle(
                        color: extradark,fontSize: 15, fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 80,
              ),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: light,
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        emailText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (input) => !input!.contains("@")
                        ? "Please enter a valid email"
                        : null,
                    onSaved: (input) => _email = input!,
                  ),
                ),
              ),
              // SizedBox(height: 20.0),

              SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      //  authService.checksIFLogin(emailText!, passwordText!);

                      _sendResetEmail();
                    } catch (e) {
                      Get.snackbar("Error", "Error Forget password");
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                  //  Get.to(SignUp());
                },
                style: ElevatedButton.styleFrom(
                    primary: dark,
                    onPrimary: Colors.white,
                    minimumSize: Size(150, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: Text('Send'),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(LoginScreen());
                  },
                  child: Text(
                    "Want to Login ? ",
                    style: TextStyle(color: extradark),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {}
}
