import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_clock/screens.dart';
import 'package:word_clock/screens/add_time_screen.dart';
import 'package:word_clock/screens/clock_screen.dart';

import 'bloc/world_clock_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => WorldClockBloc())],
     child:
        MaterialApp(
            title: 'World_Clock',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              Screens.clockScreen: (context) => ClockScreen(),
              Screens.addTimeScreen: (context) => AddTimeScreen()
            })

    );
  }
}
