import 'package:hive/hive.dart';

part 'world_clock_model.g.dart';

@HiveType(typeId: 0)
class WorldClockModel extends HiveObject {
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  String location;

  WorldClockModel(this.time, this.location);
}
