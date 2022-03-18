// ignore_for_file: public_member_api_docs

part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoaded extends AuthenticationState {}

class Error extends AuthenticationState {
  const Error(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class UserProfile extends AuthenticationState {
  const UserProfile(this.user);

  final UserData user;

  @override
  List<Object> get props => [user];
}

class EmailVerified extends AuthenticationState {}
