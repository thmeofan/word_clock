import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_clock/bloc/world_clock_event.dart';

import '../bloc/world_clock_bloc.dart';

class AddTimeScreen extends StatefulWidget {
  AddTimeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddTimeScreenState();
}

class _AddTimeScreenState extends State<AddTimeScreen> {
  final myController = TextEditingController();
  List<int> timeOptions = [
    -1,
    -2,
    -3,
    -4,
    -5,
    -6,
    -7,
    -8,
    -9,
    -10,
    -11,
    -12,
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12
  ];
  int selectedTimeOption = 0;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 230, 195, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(137, 152, 120, 1),
          title: const Text("Create"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Color.fromRGBO(137, 152, 120, 1),
              ),
              width: double.maxFinite,
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                cursorColor: Colors.white,
                controller: myController,
              ),
            ),
            Spacer(),
            DropdownButton<int>(
              value: selectedTimeOption,
              items: timeOptions
                  .map((timeOption) => DropdownMenuItem<int>(
                      value: timeOption, child: Text('$timeOption')))
                  .toList(),
              onChanged: (timeOption) =>
                  setState(() => selectedTimeOption = timeOption!),
            ),
            Spacer(),
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                DateTime theTime =
                    (DateTime.now().add(Duration(hours: selectedTimeOption)));
                context.read<WorldClockBloc>().add(SaveClockEvent(theTime));
                myController.clear();
                Navigator.of(context).pop();
              },
              backgroundColor: Color.fromRGBO(137, 152, 120, 1),
              child: const Icon(Icons.add_alarm_outlined),
            ),
          ],
        ));
  }
}
