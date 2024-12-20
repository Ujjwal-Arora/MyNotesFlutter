//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email view"),
      ),
      body: Column(
        children: [
          const Text("We have sent you an email. Pls verify it"),
          const Text(
              "If you havent recieved your email yet then press the button"),
          TextButton(
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                await AuthService.firebase().sendEmailVerification;
                print("email sent");
              },
              child: const Text("Send email verification")),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
