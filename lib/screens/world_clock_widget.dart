import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_clock/one_clock.dart';
import 'package:word_clock/models/world_clock_model.dart';

import '../bloc/world_clock_bloc.dart';
import '../bloc/world_clock_event.dart';

class WorldClockWidget extends StatefulWidget {
  final WorldClockModel yourWorldClock;

  const WorldClockWidget({super.key, required this.yourWorldClock});

  @override
  State<WorldClockWidget> createState() => _WorldClockWidgetState();
}

class _WorldClockWidgetState extends State<WorldClockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Dismissible(
            key: Key(widget.yourWorldClock.toString()),
            onDismissed: (direction) {
              setState(() {
                context
                    .read<WorldClockBloc>()
                    .add(DeleteClockEvent(widget.yourWorldClock));
              });
            },
            child: GestureDetector(
              child: Container(
                width: 120,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Color.fromRGBO(196, 146, 177, 1),
                  border: Border.all(
                    color: Color.fromRGBO(186, 103, 144, 1),
                    width: 3.0,
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(175, 59, 110, 1),
                        spreadRadius: 5,
                        blurRadius: 15)
                  ],
                ),
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DigitalClock(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      datetime: widget.yourWorldClock.time,
                      digitalClockTextColor: const Color.fromRGBO(175, 59, 110, 1),
                      textScaleFactor: 1.18,
                    ),
                    Text(
                      widget.yourWorldClock.location,
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(175, 59, 110, 1)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
