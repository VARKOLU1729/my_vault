import "package:firebase_auth/firebase_auth.dart";

final authInstance = FirebaseAuth.instance;

Future<void> VerifyPhoneNumber({required String phoneNumber}) async
{
  ConfirmationResult confirmationResult = await authInstance.signInWithPhoneNumber(phoneNumber);
}