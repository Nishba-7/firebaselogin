import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterlogin/features/global/common/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> SignUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential Credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Credential.user;
    }  on FirebaseAuthException catch (e) {
      if(e.code == 'email-already-in-use'){
      showToast(message: "The email address is already in use.");
    }else{
        showToast(message: "An error occured:${e.code}");
      }
    }
    return null;
  }
  Future<User?> SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential Credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Credential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'|| e.code == 'wrong-password'){
      showToast(message: "Invalid email or password");
    }else{
        showToast(message: "An error occured:${e.code}");
      }
    }
    return null;
  }

}