import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/screens/home_screen.dart';
import 'package:zoom_clone/screens/login_screen.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
// Import the generated file
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
      home: StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: (context, Snapshot) {
            if (Snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (Snapshot.hasData) {
              return HomeScreen();
            }
            return const LoginScreen();
          }),
    );
  }
}
