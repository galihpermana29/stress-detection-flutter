import "package:aplikasi_stress_detection/authentication.dart";
import "package:aplikasi_stress_detection/screens/user_info_screen.dart";
import "package:aplikasi_stress_detection/widget/google_button.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _handleLogin() {
    final email = emailController.text;
    final password = passwordController.text;

    // Perform your login logic here, e.g., by sending data to an API
    print('Email: $email');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Welcome to",
                        style: TextStyle(
                          color: Colors.pink[800],
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 16),
                      SizedBox(width: 40),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "Stress Emotion Detection Apps",
                    style: TextStyle(
                      color: Colors.pink[800],
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 177, 22, 89),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 177, 22, 89),
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        ),
                      ),
                      Text(
                        "Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 177, 22, 89),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: const Color.fromARGB(255, 177, 22, 89),
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 177, 22,
                                    89)), // Change to the desired color
                          ),
                          onPressed: _handleLogin,
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: const Color.fromARGB(255, 177, 22, 89),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "OR",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 177, 22, 89)),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: const Color.fromARGB(255, 177, 22, 89),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
