part of 'incident_cubit.dart';

abstract class IncidentState extends Equatable {
  const IncidentState();

  @override
  List<Object> get props => [];
}

class IncidentInitial extends IncidentState {}
