import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/bloc/world_clock_state.dart';
import 'package:word_clock/world_clock_repository/hive_repository.dart';

import '../models/world_clock_model.dart';

class WorldClockBloc extends Bloc<WorldClockEvent, WorldClockState> {
  List<WorldClockModel> _timeList = [];

  WorldClockBloc() : super(LoadingState()) {
    on<SaveClockEvent>(_onSaveClockEvent);
    on<DeleteClockEvent>(_onDeleteClockEvent);
    on<DeleteEveryClockEvent>(_onDeleteEveryClockEvent);
    on<EmptyListEvent>(_onEmptyList);
  }

  void _onSaveClockEvent(SaveClockEvent event, Emitter<WorldClockState> emit) {
    _timeList.add(event.theTime);

    WorldClockRepositoryForHive().saveToHive(_timeList);
    emit(WorldClockDataState(_timeList));
  }

  void _onDeleteClockEvent(
      DeleteClockEvent event, Emitter<WorldClockState> emit) {
    _timeList.remove(event.theTime);
    WorldClockRepositoryForHive().deleteFromHive(event.theTime);
    emit(WorldClockDataState(_timeList));
  }

  void _onDeleteEveryClockEvent(
      DeleteEveryClockEvent, Emitter<WorldClockState> emit) {
    _timeList.clear();
    WorldClockRepositoryForHive().deleteAllFromHive();
    emit(WorldClockDataState(_timeList));
  }

  void _onEmptyList(EmptyListEvent event, Emitter<WorldClockState> emit) {
    emit(EmptyState());
  }
}
