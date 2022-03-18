// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class MultiLineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const MultiLineTextField({Key? key, required this.controller, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Please explain in detail the nature of your emergency.',
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
