import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'fi_a3_uzair_login_screen.dart';
import 'fi_a3_uzair_show_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DisplayDataScreen()));
        },
        backgroundColor: const Color.fromARGB(255, 193, 110, 21),
        child: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset('assets/main-screen-image.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 193, 110, 21),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(blurRadius: 4)]),
                child: const Center(
                  child: Text(
                    "Welcome!",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 12, 8, 1)),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 500,
                height: 170,
                color: Colors.transparent,
                child: const Center(
                  child: Text(
                    "The humblest tasks get beautified if loving hands do them",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () async {
                await GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text(
                "Log Out",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 13),
            Container(
              margin: const EdgeInsets.only(top: 85, left: 120),
              width: 120,
              height: 50,
              color: Colors.transparent,
              child: const Center(
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
