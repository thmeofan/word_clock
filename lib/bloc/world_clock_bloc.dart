import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/bloc/world_clock_state.dart';

class WorldClockBloc extends Bloc<WorldClockEvent, WorldClockState>{
  List<DateTime> _timeList=[];
  WorldClockBloc():super(LoadingState()){
    on<SaveClockEvent>(_onSaveClockEvent);
    on<DeleteClockEvent>(_onDeleteClockEvent);
    on<DeleteEveryClockEvent>(_onDeleteEveryClockEvent);

  }

  void _onSaveClockEvent(SaveClockEvent event, Emitter<WorldClockState> emit){
 _timeList.add(event.theTime);
 emit(WorldClockDataState(_timeList));
  }

  void _onDeleteClockEvent(DeleteClockEvent event, Emitter<WorldClockState> emit){
_timeList.remove(event.theTime);
emit(WorldClockDataState(_timeList));
  }
  void _onDeleteEveryClockEvent(DeleteEveryClockEvent, Emitter<WorldClockState> emit){
_timeList.clear();
emit(WorldClockDataState(_timeList));
  }




}

