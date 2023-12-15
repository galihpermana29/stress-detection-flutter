import 'package:aplikasi_stress_detection/authentication.dart';
import 'package:aplikasi_stress_detection/constants/user_schema.dart'
    as UserSchema;
import 'package:aplikasi_stress_detection/screens/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromARGB(255, 78, 136, 245)),
        ),
        onPressed: () async {
          setState(() {
            _isSigningIn = true;
          });
          UserSchema.User? dataUser =
              await Authentication.signInWithGoogle(context: context);
          setState(() {
            _isSigningIn = false;
          });

          print("$dataUser DATA USER LOGIN BUTTON");

          if (dataUser != null) {
            print("$dataUser DATA USER LOGIN BUTTON gak null");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => UserInfoScreen(
                  dataUser: dataUser,
                ),
              ),
            );
          }
        },
        child: Text(
          "Login with Google",
        ),
      ),
    );
  }
}
