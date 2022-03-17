// ignore_for_file: sort_constructors_first, public_member_api_docs

import 'package:flutter/material.dart';

///
class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String label;
  final bool? obscured;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.validator,
    this.obscured,
    required this.label,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
        keyboardType: keyboardType,
        obscureText: obscured ?? false,
        validator: validator,
      ),
    );
  }
}
