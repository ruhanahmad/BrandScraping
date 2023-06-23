import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/screens/forget.dart';
import 'package:scrapingdart/screens/login.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color dark = Color(0xFF395B64);
  Color light = const Color(0xFFA5C9CA);
  Color extralight = Color(0xFFE7F6F2);
  Color extradark = Color(0xFF2C3333);

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
                    decoration: const BoxDecoration(
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
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: light),
                  child: TextFormField(
                    controller: authService.emailvv,
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
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: light,
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        passwordText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (input) => input!.length < 6
                        ? "Password must be at least 6 characters"
                        : null,
                    onSaved: (input) => _password = input!,
                    obscureText: true,
                  ),
                ),
              ),
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
                      authService.checksIFLogin(emailText!, passwordText!);
                    } catch (e) {
                      Get.snackbar("Error", "Error signing up");
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: dark,
                    onPrimary: Colors.white,
                    minimumSize: Size(150, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: Text('Login'),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(ForgetScreen());
                  },
                  child: Text(
                    "Forget Password ?",
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(SignUp());
                  },
                  child: Text(
                    "Want to Sign up ? ",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {}
}
