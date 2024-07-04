import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  const AuthField({Key? key, required this.hintText, required this.controller, this.isObscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
