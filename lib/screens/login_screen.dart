import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Start or join a meeting',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 37),
          child: Image.asset('assets/images/onboarding.jpg'),
        ),
        CustomButton(
          text: 'Google Sign In',
          onPressed: () async {
            bool res = await _authMethods.signInWithGoogle(context);
            if (res) {
              Navigator.pushNamed(context, '/home');
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
          },
        )
      ]),
    );
  }
}
