import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _usernamePassword = TextEditingController();
  final TextEditingController _usernameConfirmPass = TextEditingController();

  final Box _boxAccounts = Hive.box('accounts');
  bool _obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 160,),
              Text(
                'Daftar',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16,),
              TextFormField()
            ],
          ),
        )
      ),
    );
  }
}