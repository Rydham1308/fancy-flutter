import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> signUpWithEmailPass(String email, String pass) async {
    UserCredential credential =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);
    return credential.user;
  }

  static Future<User?> signInWithEmailPass(String email, String pass) async {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: pass);
    return credential.user;
  }
}
