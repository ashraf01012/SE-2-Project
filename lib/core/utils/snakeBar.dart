import 'package:flutter/material.dart'
    show BuildContext, ScaffoldMessenger, SnackBar, Text;

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}