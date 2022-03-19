// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_void_async

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incident_report/app/features/authentication/domain/entities/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  ProfileCubit() : super(ProfileInitial());

  void getUserProfile() async {
    emit(ProfileLoading());
    final collection = _firestore.collection('users').doc(uid);
    await collection.get().then(
      (value) {
        emit(
          ProfileLoaded(
            UserData.fromMap(value.data()!),
          ),
        );
      },
    );
  }

  void updateProfilePicture() async {
    emit(ProfileLoading());
    final picker = await _picker.pickImage(source: ImageSource.gallery);
    String userProfileUrl;
    final reference = _storage.ref('userProfile/$uid');
    final uploadeTask = reference.putFile(
      File(picker!.path),
      SettableMetadata(
        customMetadata: {
          'uploaded_by': uid,
        },
      ),
    );
    try {
      await uploadeTask.whenComplete(
        () {
          reference.getDownloadURL().then((fileUrl) {
            userProfileUrl = fileUrl;
            _firestore.collection('users').doc(uid).update(
              <String, String>{'userProfile': userProfileUrl},
            );
          });
        },
      );
    } on FirebaseException catch (e) {
      emit(
        ProfileError(
          e.message.toString(),
        ),
      );
    }
  }
}
