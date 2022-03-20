// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:incident_report/app/core/util/util.dart';

class ReportCard extends StatefulWidget {
  final String natureOfIncident;
  final String description;
  final GeoPoint address;
  final String date;

  const ReportCard({
    Key? key,
    required this.natureOfIncident,
    required this.description,
    required this.address,
    required this.date,
  }) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  TextStyle cardStyle = const TextStyle(
    fontSize: 17,
  );

  @override
  void initState() {
    super.initState();
    getAdd();
  }

  String userLocation = '';
  Future<String> getAdd() async {
    userLocation = await Util.convertToAddress(
      lat: widget.address.latitude,
      lng: widget.address.longitude,
    );
    setState(() {});
    return userLocation;
  }

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
                'Nature of incident:  ${widget.natureOfIncident}',
                style: cardStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Description:  ${widget.description}',
                style: cardStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Address:  $userLocation',
                style: cardStyle,
              ),
              const SizedBox(height: 10),
              Text(
                'Date:  ${widget.date}',
                style: cardStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
