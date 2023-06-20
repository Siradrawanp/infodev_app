import 'package:flutter/material.dart';

import '../widgets/date.dart';

class PageA extends StatefulWidget {
  const PageA({super.key});

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Date(),
        SizedBox(height: 8.0,),
      ],
    );
  }  
}