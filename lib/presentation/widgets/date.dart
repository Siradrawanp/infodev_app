import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'clock.dart';

class Date extends StatelessWidget {
  const Date({super.key});

  @override
  Widget build(BuildContext context) {
    String formater = DateFormat('yMMMd').format(DateTime.now());
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Clock(),
          Text(
            formater,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
              color: Colors.white
            ),
          ),
          const SizedBox(height: 8.0,)
        ],
      ),
    );
  }

}