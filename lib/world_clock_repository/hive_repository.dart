import 'package:hive/hive.dart';

import '../main.dart';
import '../models/world_clock_model.dart';

class WorldClockRepositoryForHive {
  static final WorldClockRepositoryForHive _worldClockRepositoryForHive =
      WorldClockRepositoryForHive._internal();

  WorldClockRepositoryForHive._internal();

  factory WorldClockRepositoryForHive() {
    return _worldClockRepositoryForHive;
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
