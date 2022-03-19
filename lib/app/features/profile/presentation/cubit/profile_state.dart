// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserData user;

  const ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
