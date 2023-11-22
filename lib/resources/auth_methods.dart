import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          //await _auth.signInWithCredential(credential);
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user; //can be null
      if (user != null) //here we are checking
      {
        if (userCredential.additionalUserInfo!
            .isNewUser) //if it is new user then store  following in firestore
        {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }
   void signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
// await GoogleSignIn().signOut();
// await FirebaseAuth.instance.signOut();
// print("signed out");
// // Trigger the authentication flow
// final GoogleSignInAccount? googleUser =
//     await GoogleSignIn().signIn();

// // Obtain the auth details from the request
// final GoogleSignInAuthentication? googleAuth =
//     await googleUser?.authentication;

// // Create a new credential
// final credential = GoogleAuthProvider.credential(
//   accessToken: googleAuth?.accessToken,
//   idToken: googleAuth?.idToken,
// );
// UserCredential userCredential =
//     await FirebaseAuth.instance.signInWithCredential(credential);
// print(userCredential.user?.email ?? "error");
