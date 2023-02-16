import '../models/world_clock_model.dart';

abstract class WorldClockEvent {}

class SaveClockEvent extends WorldClockEvent {
  final WorldClockModel theTime;

  SaveClockEvent(this.theTime);
}

class SaveAllClocksEvent extends WorldClockEvent {
  final List<WorldClockModel> timeList;

  SaveAllClocksEvent(this.timeList);

}

class DeleteClockEvent extends WorldClockEvent {
  final WorldClockModel theTime;

  DeleteClockEvent(this.theTime);
}

class DeleteEveryClockEvent extends WorldClockEvent {
  DeleteEveryClockEvent();
}

class EmptyListEvent extends WorldClockEvent {}
