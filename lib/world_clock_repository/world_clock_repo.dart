import 'package:hive/hive.dart';

import '../bloc/world_clock_bloc.dart';
import '../main.dart';
import '../models/world_clock_model.dart';

class WorldClockRepo {
  static final WorldClockRepo _worldClockRepo =
      WorldClockRepo._internal();

  WorldClockRepo._internal();

  factory WorldClockRepo() {
    return _worldClockRepo;
  }

  Future<List <WorldClockModel>>readFromHive() async {
    var box = await Hive.openBox(clocksKeeperKey);
     List<WorldClockModel> clockList =
    box.get(clocksModelKey, defaultValue: []).cast<WorldClockModel>();

    await box.close();
    return clockList;
  }
  Future<void> saveToHive(List<WorldClockModel> clocks) async {
    var box = await Hive.openBox(clocksKeeperKey);
    List<WorldClockModel> clocksList =
        box.get(clocksKeeperKey, defaultValue: []).cast<WorldClockModel>();
    clocksList.addAll(clocks);

    await box.put(clocksKeeperKey, clocksList);
    await box.close();
  }


  Future<void> deleteFromHive(WorldClockModel theClock) async {
    var box = await Hive.openBox(clocksKeeperKey);
    List<WorldClockModel> clocksList =
        box.get(clocksKeeperKey).cast<WorldClockModel>();
    clocksList.remove(theClock);

    await box.put(clocksKeeperKey, clocksList);
    await box.close();
  }

  Future<void> deleteAllFromHive() async {
    var box = await Hive.openBox(clocksKeeperKey);
    List<WorldClockModel> clockList =
        box.get(clocksKeeperKey).cast<WorldClockModel>();
    clockList.clear();

    await box.put(clocksKeeperKey, clockList);
    await box.close();
  }
}
