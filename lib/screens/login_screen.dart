import 'package:flutter/material.dart';
import 'package:food_xyz_project/custom_widget.dart';
import 'package:food_xyz_project/screens/daftar_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _submitForm() {

  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Image.asset(
            'assets/images/fast_food.png',
            width: 125,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                filled: true,
                fillColor: Color.fromARGB(199, 221, 221, 221),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Username Harus Diisi';
                }
                return null;
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: PasswordTextFormField(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  //lakukan sesuatu
                }
              },
              child: const Text('Login'),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DaftarScreen()));
            },
            child: const Text('Daftar'),
          ),
        ],
      ),
    );
  }
}