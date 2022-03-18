// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  TextStyle cardStyle = const TextStyle(
    fontSize: 17,
  );
  ReportCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 0.5,
              offset: const Offset(3, 4),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nature of incident:  Fire',
                style: cardStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Description:  Description',
                style: cardStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Address:  Address',
                style: cardStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Date:  Date',
                style: cardStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
