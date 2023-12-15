import 'package:aplikasi_stress_detection/authentication.dart';
import 'package:aplikasi_stress_detection/constants/user_schema.dart';
import 'package:aplikasi_stress_detection/loginpage.dart';
import 'package:aplikasi_stress_detection/screens/home_page.dart';
import 'package:flutter/material.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  // final Function(User)? setCurrentUser;
  final User? user;
  const NavigationExample({super.key, this.user});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

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
  Widget build(BuildContext context) {
    final User? _user = widget.user;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) async {
          setState(() {
            currentPageIndex = index;
          });
          if (index == 2) {
            await Authentication.signOut(context: context);
            Navigator.of(context).pushReplacement(_routeToSignInScreen());
          }
        },
        indicatorColor: Colors.pink[800],
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.white,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.history),
            selectedIcon: Icon(
              Icons.history,
              color: Colors.white,
            ),
            label: 'History',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.logout),
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: RecordScreen(user: _user),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}
