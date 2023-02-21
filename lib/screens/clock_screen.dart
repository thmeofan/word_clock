import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_clock/one_clock.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/bloc/world_clock_state.dart';
import 'package:word_clock/consts/ui_consts.dart';

import '../bloc/world_clock_bloc.dart';
import '../consts/screens.dart';
import 'world_clock_widget.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({
    super.key,
  });

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

enum Menu { delete }

class _ClockScreenState extends State<ClockScreen> {
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkerClockColor,
        foregroundColor: AppColors.theLightestClockColor,
        heroTag: "btn1",
        onPressed: () {
          Navigator.pushNamed(context, Screens.addTimeScreen);
        },
        child: const Icon(
          Icons.more_time,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.darkerClockColor,
        title: const Text("World Clock"),
        actions: [
          PopupMenuButton(
              onSelected: (Menu item) {
                setState(() {
                  _selectedMenu = item.name;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                    PopupMenuItem(
                        value: Menu.delete,
                        child: const Text('Delete all'),
                        onTap: () {
                          context
                              .read<WorldClockBloc>()
                              .add(DeleteEveryClockEvent());
                        }),
                  ]),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: AppColors.darkerClockColor,
                    spreadRadius: 5,
                    blurRadius: 15)
              ],
              // border: Border.all(
              //   color: AppColors.darkerClockColor,
              //   width: 5.0,
              // ),
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            width: 220.0,
            height: 120.0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: AppColors.mainClockColor,
              ),
              width: 200.0,
              height: 100.0,
              child: DigitalClock(
                datetime: DateTime.now(),
                digitalClockTextColor: AppColors.darkerClockColor,
                isLive: true,
                textScaleFactor: 2.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    shape: BoxShape.rectangle),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<WorldClockBloc, WorldClockState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is EmptyState) {
                return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      //   color: const Color.fromRGBO(137, 152, 120, 1),
                    ),
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.fromLTRB(50, 55, 50, 70),
                    child: const Center(child: Text('Empty')));
              } else if (state is WorldClockDataState) {
                List<Widget> dateTimeWidgets = [];
                for (int index = 0; index < state.timeData.length; index++) {
                  dateTimeWidgets.add(WorldClockWidget(
                    yourWorldClock: state.timeData[index],
                  ));
                }
                return GridView.count(
                  crossAxisCount: 2,
                  children: dateTimeWidgets,
                );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}
