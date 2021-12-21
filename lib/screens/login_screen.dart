import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/componenets/rounded_button.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: Get.height * 0.098),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        //Do something with the user input.

                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your Email'),
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) {
                        //Do something with the user input.
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Your password'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                      title: 'Login',
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email!, password: password!);

                            if (user != null) {
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                            showSpinner = false;
                          } catch (e) {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              dialogType: DialogType.ERROR,
                              title: 'error',
                              desc: 'invalid emai or password',
                              btnOkOnPress: () {},
                            )..show();
                            //print(e);
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          inAsyncCall: showSpinner,
        ),
      ),
    );
  }
}
