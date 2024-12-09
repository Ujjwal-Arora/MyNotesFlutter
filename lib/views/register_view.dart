import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import "dart:developer" as devtools show log;

import 'package:mynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Enter your email"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(hintText: "Enter your password"),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on FirebaseAuthException catch (e) {
                  devtools.log(e.code);
                  if (e.code == "weak-password") {
                    await showErrorDialog(context, "Weak password");
                    devtools.log("make it stronger my boayyy");
                  } else if (e.code == "email-already-in-use") {
                    await showErrorDialog(context, "email-already-in-use");
                    devtools.log("change your email my buayyy");
                  } else if (e.code == "invalid-email") {
                    await showErrorDialog(context, "invalid-email");

                    devtools.log("invalid email h bete");
                  } else {
                    await showErrorDialog(context, "error ${e.code} ");
                    devtools.log(e.code.toString());
                  }
                } catch (e) {
                  await showErrorDialog(context, "error ${e.toString()} ");
                }
                // Navigator.of(context)
                //     .pushNamedAndRemoveUntil(notesRoute, (route) => false);
              },
              child: const Text("Register")),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Already registered? LogIn here"))
        ],
      ),
    );
  }
}
