// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthenticationCubit() : super(AuthenticationInitial());

  void signup(
    String email,
    String password,
    String username,
    String phone,
    String fullName,
  ) async {
    emit(AuthenticationLoading());
    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = res.user;

      await _firestore.collection('users').doc(user!.uid).set(<String, dynamic>{
        'uid': user.uid,
        'fullName': fullName,
        'username': username,
        'email': email,
        'phone': phone,
        'userProfile':
            'https://firebasestorage.googleapis.com/v0/b/incident-report-933ea.appspot.com/o/userProfile%2FUcFiBbTQEPX4IpBwMhT5VKN2l3j2?alt=media&token=6154cba6-76c7-4fd3-89ce-c6a14b6db7ee',
      }).whenComplete(() {
        login(email, password);
        emit(AuthenticationLoaded());
      });
    } on FirebaseAuthException catch (e) {
      emit(Error(e.message.toString()));
    }
  }

  void login(String email, String password) async {
    emit(AuthenticationLoading());
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user!.emailVerified == false) {
        await user.user!.sendEmailVerification().whenComplete(() {
          emit(AuthenticationLoaded());
        });
      } else {
        emit(AuthenticationLoaded());
      }
    } on FirebaseAuthException catch (e) {
      emit(Error(e.message.toString()));
    }
  }

  void logout() async {
    emit(AuthenticationLoading());
    await _auth.signOut().whenComplete(() => emit(AuthenticationInitial()));
  }

  void resetPassword() {}

  void verifyEmail() async {
    await _auth.currentUser!.reload();
    final isEmailVerified = _auth.currentUser!.emailVerified;
    if (isEmailVerified == true) {
      emit(EmailVerified());
    } else {
      emit(AuthenticationLoading());
    }
  }
}
