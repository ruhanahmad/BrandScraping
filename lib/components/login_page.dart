import 'package:flutter/material.dart';
import 'package:scrapingdart/AuthFirebase/auth.dart';
import 'package:scrapingdart/components/common/custom_input_field.dart';
import 'package:scrapingdart/components/common/page_header.dart';
import 'package:scrapingdart/components/forget_password_page.dart';
import 'package:scrapingdart/components/signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:scrapingdart/components/common/page_heading.dart';

import 'package:scrapingdart/components/common/custom_form_button.dart';


class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  bool _isLoginForm = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
 AuthService authService = AuthService();
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _email, _password;
   String? emailText,passwordText;
  //
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
          backgroundColor: const Color(0xffEEF1F3),
          body: Form(
                   key: _formKey,
            child: Column(
              children: [
                const PageHeader(),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            const PageHeading(title: 'Log-in',),
                            CustomInputField(
                              labelText: 'Email',
                              hintText: 'Your email id',
                              validator: (textValue) {
                                if(textValue == null || textValue.isEmpty) {
                                  return 'Email is required!';
                                }
                                if(!EmailValidator.validate(textValue)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              }
                            ),
                            const SizedBox(height: 16,),
                            CustomInputField(
                              labelText: 'Password',
                              hintText: 'Your password',
                              obscureText: true,
                              suffixIcon: true,
                              validator: (textValue) {
                                if(textValue == null || textValue.isEmpty) {
                                  return 'Password is required!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16,),
                            Container(
                              width: size.width * 0.80,
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()))
                                },
                                child: const Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    color: Color(0xff939393),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            CustomFormButton(innerText: 'Login', onPressed: _handleLoginUser,),
                            const SizedBox(height: 18,),
                            SizedBox(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                                  GestureDetector(
                                    onTap: () => {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()))
                                    },
                                    child: const Text('Sign-up', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  void _handleLoginUser() {
    // login user
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );
    }
  }
}
