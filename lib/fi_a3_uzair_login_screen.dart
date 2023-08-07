import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_list_app/fi_a3_uzair_data_operations.dart';
import 'package:to_do_list_app/fi_a3_uzair_google_auth.dart';
import 'package:to_do_list_app/fi_a3_uzair_sign_up_screen.dart';

import 'fi_a3_uzair_main_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/login_screen_image_updated.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                    controller: emailC,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return ("Please enter email");
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Enter email",
                      labelStyle: const TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passC,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return ("Please enter password");
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Enter password",
                    labelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        // ignore: unused_local_variable
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: emailC.text, password: passC.text);
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          _showUserNotFoundPopup(context);
                        } else if (e.code == 'wrong-password') {
                          _showWrongPasswordPopup(context);
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.black),
                  label: Text("Login with Google"),
                  onPressed: () {
                    googleAuth.signInWithGoogle();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showUserNotFoundPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('User Not Found!'),
        content: const Text('User not found. Please Sign Up'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      );
    },
  );
}

void _showWrongPasswordPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Wrong Password!'),
        content: const Text('Please enter correct password to Log In'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      );
    },
  );
}
