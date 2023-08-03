import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'fi_a3_uzair_login_screen.dart';
import 'fi_a3_uzair_main_screen.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isSigningUp = false;

  SignUpScreen({super.key});

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
                    padding: const EdgeInsets.only(top: 70),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/signup_screen_image_updated.png'),
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
                const SizedBox(height: 40),
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
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: emailC.text, password: passC.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          _showEmailExistsPopup(context);
                        } else if (e.code == 'weak-password') {
                          _showweakPasswordPopup(context);
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 62, 159, 238))),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showweakPasswordPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Password too weak'),
        content: const Text('Please enter a strong password'),
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

void _showEmailExistsPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Email already exists'),
        content: const Text('The email already exists. Please Login'),
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
