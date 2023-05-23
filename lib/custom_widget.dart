import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  
  final String displayText;
  const PasswordTextFormField({super.key, this.displayText = 'password'});
  
  @override
  State<StatefulWidget> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isPasswordHidden,
      decoration: InputDecoration(
        labelText : 'Password',
        filled: true,
        fillColor: const Color.fromARGB(199, 221, 221, 221),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: IconButton(
          icon:
              Icon(_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
          onPressed: () => setState(() {
            _isPasswordHidden = !_isPasswordHidden;
          })          
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password Harus diisi';
        }
        return null;
      },
    );
  }
}
