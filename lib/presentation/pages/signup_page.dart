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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

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
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  } else if (_boxAccounts.containsKey(value)) {
                    return 'Username telah terdaftar';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0,),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePass = !_obscurePass;
                      });
                    },
                    icon: Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  } else if (value.length < 8) {
                    return 'Password setidaknya 8 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0,),
              TextFormField(
                controller: _confirmPassController,
                obscureText: _obscurePass,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePass = !_obscurePass;
                      });
                    },
                    icon: Icon(Icons.visibility),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  } else if (value != _passwordController.text) {
                    return 'Password harus sama';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _boxAccounts.put(
                      _usernameController.text, 
                      _confirmPassController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: const Text('Akun sukses terdaftar')
                      ),
                    );
                  }

                  _formKey.currentState?.reset();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  )
                ), 
                child: const Text('Daftar'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Tidak punya akun?'),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: const Text('Login')
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }
}