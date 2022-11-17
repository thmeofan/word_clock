import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_clock/one_clock.dart';
import 'package:word_clock/screens/add_time_screen.dart';

import 'bloc/world_clock_bloc.dart';

Icon checkMark = Icon(Icons.square_outlined);

class WorldClockWidget extends StatefulWidget {
 final  DateTime yourTime;
  const WorldClockWidget({
    super.key, required this.yourTime
  });

  @override
  State<WorldClockWidget> createState() => _WorldClockWidgetState();
}

class _WorldClockWidgetState extends State<WorldClockWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Dismissible(
            key: Key(widget.yourTime.toString()),
            child: Container(
              // color: const Color.fromRGBO(228, 230, 195, 1),

              width: double.maxFinite,
              margin: const EdgeInsets.all(15),
              child: GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Color.fromRGBO(228, 230, 195, 1),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DigitalClock(
                          datetime: widget.yourTime,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
