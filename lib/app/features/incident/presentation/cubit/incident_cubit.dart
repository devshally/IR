import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'incident_state.dart';

class IncidentCubit extends Cubit<IncidentState> {
  IncidentCubit() : super(IncidentInitial());
}
