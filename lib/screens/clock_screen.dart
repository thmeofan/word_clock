import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_clock/one_clock.dart';
import 'package:word_clock/bloc/world_clock_event.dart';
import 'package:word_clock/bloc/world_clock_state.dart';

import '../bloc/world_clock_bloc.dart';
import '../chosen_time_widget.dart';
import '../screens.dart';

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
      backgroundColor: const Color.fromRGBO(228, 230, 195, 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(137, 152, 120, 1),
        heroTag: "btn1",
        onPressed: () {
          Navigator.pushNamed(context, Screens.addTimeScreen);
        },
        child: const Icon(Icons.create_outlined),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(137, 152, 120, 1),
        title: const Text("To Do List"),
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
                        child: Text('Delete all'),
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
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<WorldClockBloc, WorldClockState>(
                  builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EmptyState) {
                  return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: const Color.fromRGBO(137, 152, 120, 1),
                      ),
                      padding: const EdgeInsets.all(25),
                      margin: const EdgeInsets.fromLTRB(50, 55, 50, 70),
                      child: const Center(child: Text('Empty')));
                } else if (state is WorldClockDataState) {
                  List<Widget> dateTimeWidgets = [];

                  for (int index = 0; index < state.timeData.length; index++) {
                    dateTimeWidgets.add(WorldClockWidget(

                      yourTime: state.timeData[index],
                    ));
                  }
                  return Container(
                    color: const Color.fromRGBO(137, 152, 120, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: dateTimeWidgets,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
