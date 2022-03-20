// ignore_for_file: public_member_api_docs, avoid_void_async, sort_constructors_first
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:incident_report/app/core/location/location_services.dart';
import 'package:incident_report/app/features/incident/domain/entities/incident.dart';

part 'incident_state.dart';

class IncidentCubit extends Cubit<IncidentState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  IncidentCubit() : super(IncidentInitial());

  void reportIncident(
    String nature,
    String description,
    String imageUrl,
  ) async {
    emit(IncidentLoading());
    final position = await LocationServices.determinePosition();
    final geopoint = GeoPoint(position.latitude, position.longitude);
    final time = position.timestamp;
    try {
      await _firestore.collection('incidents').add(<String, dynamic>{
        'uid': uid,
        'natureOfIncident': nature,
        'description': description,
        'location': geopoint,
        'date': time,
        'imageUrl': imageUrl,
      }).whenComplete(
        () => emit(
          const IncidentLoaded(message: 'Successfully uploaded'),
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

  void uploadMedia(File filePath, String imageName) async {
    emit(IncidentLoading());
    String uploadedFileUrl;
    try {
      final reference = _storage.ref().child('incidents/$imageName');
      final uploadTask = reference.putFile(
        filePath,
        SettableMetadata(
          customMetadata: {
            'uploaded_by': uid,
          },
        ),
      );
      await uploadTask.whenComplete(() {
        reference.getDownloadURL().then((fileUrl) {
          uploadedFileUrl = fileUrl;
          emit(ImageUploaded(uploadedFileUrl));
        });
      });
    } on FirebaseException catch (e) {
      emit(Error(e.message.toString()));
    }
  }
}
