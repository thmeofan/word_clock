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
        floatingActionButton: FloatingActionButton(
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
          foregroundColor: AppColors.theLightestClockColor,
          child: const Icon(Icons.add_alarm_outlined),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.darkerClockColor,
          title: const Text(
            "Create",
            style: TextStyle(color: AppColors.theLightestClockColor),
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
                    borderSide:
                        BorderSide(color: AppColors.theLightestClockColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.theLightestClockColor),
                  ),
                ),
                style: const TextStyle(color: AppColors.theLightestClockColor),
                cursorColor: AppColors.mainClockColor,
                controller: myController,
              ),
            ),
            Spacer(),
            const Text(
              'Choose your GMT sector:',
              style: TextStyle(color: AppColors.mainClockColor, fontSize: 20),
            ),
            const SizedBox(height: 25),
            DropdownButton<int>(
              dropdownColor: AppColors.darkerClockColor,
              focusColor: AppColors.mainClockColor,
              menuMaxHeight: 152,
              value: selectedTimeOption,
              items: timeOptions
                  .map((timeOption) => DropdownMenuItem<int>(
                      value: timeOption,
                      child: Text(
                        '$timeOption',
                        style:
                            TextStyle(color: AppColors.theLightestClockColor),
                      )))
                  .toList(),
              onChanged: (timeOption) =>
                  setState(() => selectedTimeOption = timeOption!),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            Spacer(),
          ],
        ));
  }
}
