import '../models/world_clock_model.dart';

class WorldClockEvent {}

class SaveClockEvent extends WorldClockEvent {
  final WorldClockModel theTime;

  SaveClockEvent(this.theTime);
}

class DeleteClockEvent extends WorldClockEvent {
  final WorldClockModel theTime;

  DeleteClockEvent(this.theTime);
}

class DeleteEveryClockEvent extends WorldClockEvent {
  DeleteEveryClockEvent();
}

class EmptyListEvent extends WorldClockEvent {}
