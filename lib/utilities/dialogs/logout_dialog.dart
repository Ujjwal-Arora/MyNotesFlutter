import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialogue(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log Out',
    content: 'are you sure you want to log out?',
    optionsBuilder: () => {
      'cancel': false,
      'log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
