// ignore_for_file: public_member_api_docs, avoid_void_async, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:incident_report/app/core/location/location_services.dart';

part 'incident_state.dart';

class IncidentCubit extends Cubit<IncidentState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  IncidentCubit() : super(IncidentInitial());

  void reportIncident(
    String nature,
    String description,
    //Media,
  ) async {
    emit(IncidentLoading());
    final position = await LocationServices.determinePosition();
    final geopoint = GeoPoint(position.latitude, position.longitude);
    final time = position.timestamp;
    final uid = _auth.currentUser!.uid;
    try {
      await _firestore.collection('incidents').doc(uid).set(<String, dynamic>{
        'natureOfIncident': nature,
        'description': description,
        'location': geopoint,
        'date': time,
      }).whenComplete(
        () => emit(
          const IncidentLoaded('Successfully uploaded'),
        ),
      );
    } on FirebaseException catch (e) {
      emit(
        Error(
          e.message.toString(),
        ),
      );
    }
  }
}
