// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Incident extends Equatable {
  final String? natureOfIncident;
  final String? description;
  final GeoPoint? location;
  final Timestamp? date;

  const Incident({
    this.natureOfIncident,
    this.description,
    this.location,
    this.date,
  });

  @override
  List<Object?> get props => [date, description, location, natureOfIncident];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'natureOfIncident': natureOfIncident,
      'description': description,
      'location': location,
      'date': date,
    };
  }

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      natureOfIncident: map['natureOfIncident'].toString(),
      description: map['description'].toString(),
      location: map['location'] as GeoPoint,
      date: map['date'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());
}
