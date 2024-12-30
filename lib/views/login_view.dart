//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "dart:developer" as devtools show log;

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/main.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/loading_dialog.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundException) {
            await showErrorDialog(
                context, "cannot find a user with the entered credentials");
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, "wrong credentials");
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "authentication error");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("LogIn View")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  "Please log in to your account in order to interact with and create notes!"),
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
                    devtools.log("login button pressed");
                    final email = _email.text;
                    final password = _password.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventLogIn(email, password));
                  },
                  child: const Text("LogIn")),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventForgotPassword());
                  },
                  child: const Text("I forgot my password")),
              TextButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEventShouldRegister());
                  },
                  child: const Text("Register here")),
            ],
          ),
        ),
      ),
    );
  }
}
