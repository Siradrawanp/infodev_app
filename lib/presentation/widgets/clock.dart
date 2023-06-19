import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class Clock extends StatelessWidget {
  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat('HH:mm:ss').format(now);
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TimerBuilder.periodic(
          Duration(seconds: 1), 
          builder: (context) {
            return Text(
              '${getSystemTime()}',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.displayMedium?.fontSize,
              ),
            );
          }
        ),
      ),
    );
  }
}