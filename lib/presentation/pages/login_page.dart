import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infodev_app/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePass = true;
  final Box _boxLogin = Hive.box("login");
  final Box _boxAccounts = Hive.box("accounts");

  @override
  Widget build(BuildContext context) {

    if (_boxLogin.get("loginStatus") ?? false) {
      return HomePage();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 160,),
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
                  } else if (!_boxAccounts.containsKey(value)) {
                    return 'Pengguna belum terdaftar';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePass = !_obscurePass;
                      });
                    }, 
                    icon: Icon(Icons.visibility)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  } else if (value != _boxAccounts.get(_usernameController.text)) {
                    return 'Password salah';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 32.0,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _boxLogin.put('loginstatus', true);
                    _boxLogin.put('userName', _usernameController.text);

                    Navigator.of(context).pushReplacementNamed('./homePage');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  )
                ), 
                child: const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Tidak punya akun?'),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('./signupPage');
                    }, 
                    child: const Text('Daftar')
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
    super.dispose();
  }
}