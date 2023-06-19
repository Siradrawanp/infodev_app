import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/login_page.dart';

void main() async {
  await _initHive();
  runApp(const MyApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  await Hive.openBox("login");
  await Hive.openBox("accounts");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/loginPage',
      routes: {
        '/loginPage':(context) => LoginPage(),
        '/homePage':(context) => HomePage(),
        '/signupPage':(context) => SignupPage(),
      },
    );
  }
}
