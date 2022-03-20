// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'incident_cubit.dart';

abstract class IncidentState extends Equatable {
  const IncidentState();

  @override
  List<Object> get props => [];
}

class IncidentInitial extends IncidentState {}

class IncidentLoading extends IncidentState {}

class IncidentLoaded extends IncidentState {
  const IncidentLoaded({this.message, this.incidents});

  final String? message;
  final List<Incident>? incidents;
}

class ImageUploaded extends IncidentState {
  const ImageUploaded(this.url);

  final String url;
}

class Error extends IncidentState {
  final String message;

  const Error(this.message);
}
