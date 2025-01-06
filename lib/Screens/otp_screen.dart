import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {

  final String verificationId;
  
  OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final auth = FirebaseAuth.instance;
  String otp = "";

  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _getOTPValue() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment : MainAxisAlignment.center,
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

          buildOtpFields(
              context: context,
              otp: otp
          ),

          TextButton(
              onPressed: () async{
                // AuthCredential authCredential = PhoneAuthProvider.credential(
                //     verificationId: widget.verificationId,
                //     smsCode: otp
                // );
                //
                // try{
                //   await auth.signInWithCredential(authCredential);
                // }
                // catch(e)
                // {
                //   print(e.toString());
                // }

                print("++++++++++++++++++++++++ $otp");
                
              },
              child: const Text(
                "Verify",
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


Widget buildOtpFields({required BuildContext context, required String otp})
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(6, (index) {
      return SizedBox(
        width: 50,
        height: 50,
        child: TextField(
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