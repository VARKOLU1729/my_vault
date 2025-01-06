import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_vault/Helpers/send_message.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  
  @override
  void initState()
  {
    super.initState();
  }
  
  @override
  void dispose()
  {
    phoneNumberController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment : MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          
          const Text(
            "Enter Your 10 digit Mobile Number",
            style: TextStyle(
              color: Colors.black12,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          
          TextField(
            controller: phoneNumberController,
            style: const TextStyle(color: Colors.black12, fontSize: 20, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              border: OutlineInputBorder()
            ),
          ),
          
          TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(
                  verificationId: "hi",
                )));
                // if(phoneNumberController.text.length==10) {
                //   auth.verifyPhoneNumber(
                //       phoneNumber: phoneNumberController.text,
                //       verificationCompleted: (phoneAuthCredential) {},
                //       verificationFailed: (authException) {},
                //       codeSent: (verificationId, forceResend) {
                //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(
                //           verificationId: verificationId,
                //         )));
                //       },
                //       codeAutoRetrievalTimeout: (code) {});
                // } else {
                //   SendMessage(context: context, message: "Please recheck your Number");
                // }
              },
              child: const Text(
                "Send Verification Code",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              )
          )
          
        ],
      ),
    );
  }
}
