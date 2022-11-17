class WorldClockState{}

class WorldClockDataState extends WorldClockState{
   final List<DateTime> timeData;

  WorldClockDataState(this.timeData);

}
class EmptyState extends WorldClockState {

}

class LoadingState extends WorldClockState {}