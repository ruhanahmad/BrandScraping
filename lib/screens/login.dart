import 'package:flutter/material.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:get/get.dart';

import '../components/common/page_header.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //colors added
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
      backgroundColor: light,
      key: _scaffoldKey,
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/lo.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(height: 80.0),
            Image.asset(
              "assets/logo.jpeg",
              height: 150.0,
              width: 150.0,
              fit: BoxFit.contain,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: true,
                  groupValue: _isAdmin,
                  onChanged: (value) {
                    setState(() {
                      _isAdmin = value!;
                    });
                  },
                ),
                Text('Admin'),
                Radio(
                  value: false,
                  groupValue: _isAdmin,
                  onChanged: (value) {
                    setState(() {
                      _isAdmin = value!;
                    });
                  },
                ),
                Text('Worker'),
              ],
            ),
            SizedBox(height: 40.0),
            _isLoginForm
                ? Text("")
                : TextFormField(
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
            TextFormField(
              onChanged: (value) {
                setState(() {
                  emailText = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
              validator: (input) =>
                  !input!.contains("@") ? "Please enter a valid email" : null,
              onSaved: (input) => _email = input!,
            ),
            SizedBox(height: 20.0),
            TextFormField(
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
            SizedBox(height: 20.0),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLoginForm ? "Login" : "Sign up",
                        style: TextStyle(fontSize: 20.0)),
                  ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoginForm = !_isLoginForm;
                });
              },
              child: Text(
                  _isLoginForm
                      ? "Don't have an account? Sign up"
                      : "Already have an account? Login",
                  style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                authService.forgetPassword(emailText!);
              },
              child: Text("Forgot password?",
                  style: TextStyle(color: Colors.white)),
            ),
          ]

              //  PageHeader(),

              ),
        ),
      ),
    );
  }

  void _submit() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
        _isLoading = true;
      });
      try {
        if (_isLoginForm && _isAdmin) {
          authService.login(emailText!, passwordText!);
        }
        if (_isLoginForm && _isAdmin) {
          authService.checksIFSignUp(emailText!, passwordText!);
        }

        if (!_isLoginForm && _isAdmin) {
          Get.snackbar("Error", "You cant sign up as admin ");
        } else {
          authService.signUp(emailText!, passwordText!, nameText!);
        }
      } catch (e) {
        _showSnackBar("Error: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    // _scaffoldKey.currentState!.showSnackBar(SnackBar(
    //         content: Text("The current state is: ${DateTime.now()}"),
    //         duration: Duration(seconds: 3),
    //       ));
  }
}
