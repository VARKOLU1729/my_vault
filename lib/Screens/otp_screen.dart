import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_vault/Helpers/send_message.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  final firestore = FirebaseFirestore.instance;

  String getOtpValue() =>
      _controllers.map((controller) => controller.text).join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Enter Your 6 digit OTP",
            style: TextStyle(
              color: Colors.black12,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          buildOtpFields(context),
          TextButton(
            onPressed: () async {
              AuthCredential authCredential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: getOtpValue(),
              );

              try {
                await auth.signInWithCredential(authCredential);

                SendMessage(context: context, message: "Auth Success");
                // Navigate to the next screen upon successful verification
              } catch (e) {
                print(e.toString());
                SendMessage(context: context, message: "Auth Failed");
                // Display error message to the user
              }
            },
            child: const Text(
              "Verify",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOtpFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 50,
          height: 50,
          child: TextField(
            controller: _controllers[index],
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }
            },
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        );
      }),
    );
  }
}
