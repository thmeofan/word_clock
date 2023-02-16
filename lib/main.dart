import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/consts/screens.dart';
import 'package:word_clock/consts/ui_consts.dart';
import 'package:word_clock/screens/add_time_screen.dart';
import 'package:word_clock/screens/clock_screen.dart';
import 'package:word_clock/world_clock_repository/world_clock_repo.dart';

import 'bloc/world_clock_bloc.dart';
import 'models/world_clock_model.dart';

const String clocksKeeperKey = 'clock_info_keeper';
const String clocksModelKey = 'clock_model_key';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDir.path)
    ..registerAdapter(WorldClockModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => WorldClockBloc())],
      child: Builder(builder: (context) {
        WorldClockRepo().readFromHive().then((clockList) {
          if (clockList.isEmpty) {
            context.read<WorldClockBloc>().add(EmptyListEvent());
          } else {
            context.read<WorldClockBloc>().add(SaveAllClocksEvent(clockList));
          }
        });
        return MaterialApp(
          title: 'World_Clock',
          theme: ThemeData(
            backgroundColor: AppColors.backgroundColor,
          ),
          routes: {
            Screens.clockScreen: (context) => ClockScreen(),
            Screens.addTimeScreen: (context) => AddTimeScreen()
          },
        );
      }),
    );
  }
}
