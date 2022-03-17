// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> items;
  final String hint;
  final String value;
  final ValueChanged<String?>? onChanged;
  final Color? backgroundColor;

  const DropDownWidget({
    Key? key,
    required this.items,
    required this.hint,
    required this.value,
    this.onChanged,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              // color: Colors.black.withOpacity(0.4),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}
