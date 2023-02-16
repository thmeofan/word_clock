import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/bloc/world_clock_state.dart';
import 'package:word_clock/world_clock_repository/world_clock_repo.dart';

import '../models/world_clock_model.dart';

class WorldClockBloc extends Bloc<WorldClockEvent, WorldClockState> {
  final List<WorldClockModel> _timeList = [];

  WorldClockBloc() : super(LoadingState()) {
    on<SaveClockEvent>(_onSaveClockEvent);
    on<SaveAllClocksEvent>(_onSaveAllClocksEvent);
    on<DeleteClockEvent>(_onDeleteClockEvent);
    on<DeleteEveryClockEvent>(_onDeleteEveryClockEvent);
    on<EmptyListEvent>(_onEmptyList);
  }

  void _onSaveClockEvent(SaveClockEvent event, Emitter<WorldClockState> emit) {
    _timeList.add(event.theTime);

    WorldClockRepo().saveToHive(_timeList);
    emit(WorldClockDataState(_timeList));
  }

  void _onSaveAllClocksEvent(
      SaveAllClocksEvent event, Emitter<WorldClockState> emit) {
    _timeList.addAll(event.timeList);

    WorldClockRepo().saveToHive(_timeList);
    emit(WorldClockDataState(_timeList));
  }

  void _onDeleteClockEvent(
      DeleteClockEvent event, Emitter<WorldClockState> emit) {
    _timeList.remove(event.theTime);
    WorldClockRepo().deleteFromHive(event.theTime);
    emit(WorldClockDataState(_timeList));
  }

  void _onDeleteEveryClockEvent(
      DeleteEveryClockEvent, Emitter<WorldClockState> emit) {
    _timeList.clear();
    WorldClockRepo().deleteAllFromHive();
    emit(WorldClockDataState(_timeList));
  }

  void _onEmptyList(EmptyListEvent event, Emitter<WorldClockState> emit) {
    emit(EmptyState());
  }
}
