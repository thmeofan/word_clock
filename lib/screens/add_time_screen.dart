import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/consts/ui_consts.dart';

import '../bloc/world_clock_bloc.dart';
import '../models/world_clock_model.dart';

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
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.darkerClockColor,
          title: const Text(
            "Create",
            style: TextStyle(color: AppColors.mainClockColor),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: AppColors.darkerClockColor,
              ),
              width: double.maxFinite,
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.mainClockColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.mainClockColor),
                  ),
                ),
                style: const TextStyle(color: AppColors.mainClockColor),
                cursorColor: AppColors.mainClockColor,
                controller: myController,
              ),
            ),
            Spacer(),
            const Text(
              'choose your location',
              style: TextStyle(color: AppColors.mainClockColor),
            ),
            DropdownButton<int>(
              dropdownColor: AppColors.darkerClockColor,
              focusColor: AppColors.mainClockColor,
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
                WorldClockModel theTime = WorldClockModel(
                    DateTime.now().add(Duration(hours: selectedTimeOption)),
                    myController.text);
                context.read<WorldClockBloc>().add(SaveClockEvent(theTime));
                myController.clear();
                Navigator.of(context).pop();
              },
              backgroundColor: AppColors.darkerClockColor,
              child: const Icon(Icons.add_alarm_outlined),
            ),
          ],
        ));
  }
}
