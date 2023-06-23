import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/screens/login.dart';
import 'package:scrapingdart/screens/loginOnly.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color dark = Color(0xFF395B64);
  Color light = Color(0xFFA5C9CA);
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
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.jpeg'))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Dis Nav",
                      style: TextStyle(color: dark,fontSize: 15, fontWeight: FontWeight.w600),
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
                    borderRadius: BorderRadius.circular(18),
                    color: light,
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        nameText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (input) => !input!.contains("")
                        ? "Please enter a valid Name"
                        : null,
                    onSaved: (input) => _name = input!,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: light),
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
                height: 10,
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
                      authService.signUp(emailText!, passwordText!, nameText!);
                    } catch (e) {
                      Get.snackbar("Error", "Error signing up");
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                  //  Get.to(SignUp());
                },
                style: ElevatedButton.styleFrom(
                  primary: extradark,
                  onPrimary: Colors.white,
                  minimumSize: const Size(150, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('SIGN UP'),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(LoginScreen());
                  },
                  child: Text("Already have account ? Login in",
                      style: TextStyle(
                        color: Colors.black,
                      )))
            ],
          ),
        ),
      ),
    );
  }
  //   void _submit() async {

  // }
}
