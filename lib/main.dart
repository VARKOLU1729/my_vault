import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_vault/Screens/login_screen.dart';
import 'package:my_vault/Screens/MPinScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print(snapshot.data);

        Widget widget = LoginScreen();

        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Connection Waiting");
          widget = Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          print("Connection done");
          if (snapshot.hasData) {
            widget = MPinScreen();
          }
        }
        return widget;
      },
    ),
  ));
}
