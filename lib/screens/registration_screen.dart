import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/componenets/rounded_button.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegistrationScreen extends StatefulWidget {

  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String ?email;
  String? password;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: Get.height *0.098),
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
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email' ),
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.

                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                 RoundedButton(title: 'Register' , color: Colors.blueAccent , onPressed: () async {

                   setState(() {

                     showSpinner = true;
                   });
                   try {
                     final newUSer = await _auth.createUserWithEmailAndPassword(
                         email: email!, password: password!);
                     if(newUSer!=null){
                       Navigator.pushNamed(context,ChatScreen.id);
                     }
                     showSpinner = false;
                   }
                   catch (e){
                     print(e);
                     setState(() {
                       showSpinner = false;
                     });

                   }
                 },)
                ],
              ),
            ),
          ),
        ),inAsyncCall: showSpinner,
      ),
    );
  }
}
