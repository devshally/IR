// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    this.fullName,
    this.username,
    this.email,
    this.phone,
    this.userProfile,
  });

  final String? fullName;
  final String? username;
  final String? email;
  final String? phone;
  final String? userProfile;

  @override
  List<Object?> get props => [fullName, username, email, phone, userProfile];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'userProfile': userProfile,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      fullName: map['fullName'].toString(),
      username: map['username'].toString(),
      email: map['email'].toString(),
      phone: map['phone'].toString(),
      userProfile: map['userProfile'].toString(),
    );
  }

  String toJson() => json.encode(toMap());
}
