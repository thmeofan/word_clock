class WorldClockEvent{}

class SaveClockEvent extends WorldClockEvent{
final DateTime theTime;
SaveClockEvent(this.theTime);
}


class DeleteClockEvent extends WorldClockEvent{
final DateTime theTime;
DeleteClockEvent(this.theTime);
}

class DeleteEveryClockEvent extends WorldClockEvent{
DeleteEveryClockEvent();
}