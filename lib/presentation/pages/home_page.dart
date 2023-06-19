import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final Box _boxLogin = Hive.box('login');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Device Info'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0)
          )
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                _boxLogin.clear();
                _boxLogin.put('loginStatus', false);
                Navigator.of(context).pushReplacementNamed('/loginPage');
              }, 
              icon: const Icon(Icons.logout_outlined)
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16,),
            Text('Homepage')
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0)
        ),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'SoC'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Chart'
            ),
          ]
        ),
      ),
    );
  }
}