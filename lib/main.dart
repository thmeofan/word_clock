import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/consts/screens.dart';
import 'package:word_clock/screens/add_time_screen.dart';
import 'package:word_clock/screens/clock_screen.dart';

import 'bloc/world_clock_bloc.dart';
import 'models/world_clock_model.dart';

const String clocksKeeperKey = 'notes_keeper';
const String clocksModelKey = 'notes_List_key';

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
        Hive.openBox(clocksKeeperKey).then((box) {
          if (box.isNotEmpty) {
            List<WorldClockModel> clockList =
                box.get(clocksModelKey).cast<WorldClockBloc>();
            if (clockList.isEmpty) {
              context.read<WorldClockBloc>().add(EmptyListEvent());
            } else {
              for (int index = 0; index < clockList.length; index++) {
                context
                    .read<WorldClockBloc>()
                    .add(SaveClockEvent(clockList[index]));
              }
            }
            box.close();
          } else {
            context.read<WorldClockBloc>().add(EmptyListEvent());
          }
        });
        return MaterialApp(
          title: 'World_Clock',
          theme: ThemeData(
            backgroundColor: Color.fromRGBO(188, 231, 253, 1),
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
