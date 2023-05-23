import 'package:flutter/material.dart';
import 'package:food_xyz_project/custom_widget.dart';

class DaftarScreen extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Scaffold(
          body: FormHandler(),
        ),
      ),
    ) ;
  }
}

class FormHandler extends StatefulWidget {
  FormHandler({super.key});

  @override
  State<FormHandler> createState() => _FormHandlerState();
}

class _FormHandlerState extends State<FormHandler> {
  final GlobalKey<FormState> _daftarFormKey= GlobalKey<FormState>();
  @override
  Widget build(context) {
    return Form(
      key: _daftarFormKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Silahkan Isi data pribadi anda',
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
                labelText: 'Nama Lengkap',
                filled: true,
                fillColor: Color.fromARGB(199, 221, 221, 221),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Lengkap Harus Diisi';
                }
                return null;
              },
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Alamat',
                filled: true,
                fillColor: Color.fromARGB(199, 221, 221, 221),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Alamat Harus Diisi';
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
                if (_daftarFormKey.currentState!.validate()) {
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => DaftarScreen()))
            },
            child: const Text('Daftar'),
          ),
        ],
      ),
    );
  }
}