import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:my_vault/Screens/login_screen.dart';

import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MaterialApp(
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot)
            {
              Widget widget = LoginScreen();
              final ConnectionState connectionState = snapshot.connectionState;
              if(connectionState == ConnectionState.waiting)
                {
                  widget =  const Center(child: CircularProgressIndicator());
                }
              else if(connectionState == ConnectionState.done)
                {
                  // if(snapshot.hasData) widget = MPinScreen();
                }
              return widget;
            }
        ),
      )
  );
}

