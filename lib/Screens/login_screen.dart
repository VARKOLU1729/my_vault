import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_vault/Helpers/send_message.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNumberController = TextEditingController();

  final auth = FirebaseAuth.instance;

  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  void handleVerification() async {
    if (phoneNumberController.text.length == 10) {
      String number = "+91${phoneNumberController.text}";

      final usersCollection = await fireStoreInstance.collection("Users").get();
      final existingUser = usersCollection.docs.any((doc) => doc.id == number);

      if (!existingUser)
        auth.verifyPhoneNumber(
          phoneNumber: "+91${phoneNumberController.text}",
          verificationCompleted: (phoneAuthCredential) {},
          verificationFailed: (authException) {
            print(authException);
            SendMessage(context: context, message: "Verification Failed");
          },
          codeSent: (verificationId, forceResend) {
            SendMessage(context: context, message: "Code Sent");
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OtpScreen(verificationId: verificationId),
            ));
          },
          codeAutoRetrievalTimeout: (code) {},
        );
    } else {
      SendMessage(context: context, message: "Please recheck your Number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enter Your 10 digit Mobile Number",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: phoneNumberController,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green)),
                onPressed: handleVerification,
                child: const Text(
                  "Send Verification Code",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
