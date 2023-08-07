import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'fi_a3_uzair_data_operations.dart';

class googleAuth {
  static signInWithGoogle() async {
    GoogleSignInAccount? gooleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await gooleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
    String? userEmail = userCredential.user?.email;
    DataOperations.addUser(userEmail!);
  }
}
