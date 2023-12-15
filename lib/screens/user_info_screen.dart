import 'package:aplikasi_stress_detection/authentication.dart';
import 'package:aplikasi_stress_detection/constants/user_schema.dart';
import 'package:aplikasi_stress_detection/loginpage.dart';
import 'package:aplikasi_stress_detection/widget/bottom_nav.dart';
import 'package:aplikasi_stress_detection/widget/logout_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  final User? dataUser;

  UserInfoScreen({super.key, this.dataUser});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  // User? _user;
  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginForm(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  // void initState() {
  //   _user = widget._user;

  //   super.initState();
  // }

  // void setCurrentUser(User userPayload) {
  //   setState(() {
  //     _user = userPayload;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    User? user = widget.dataUser;
    print('$user :userrrr');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recording Voice'),
        elevation: 0,
      ),
      body: SafeArea(
        child: NavigationExample(user: user),
      ),
    );
  }
}
