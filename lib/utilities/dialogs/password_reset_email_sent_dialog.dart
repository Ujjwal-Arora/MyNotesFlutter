import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
      context: context,
      title: "Password reset",
      content:
          "we have sent you a password reset link. PLease check your email for more information",
      optionsBuilder: () => {"OK": null});
}
