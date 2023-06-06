import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    this.controller,
    this.passwordToCheck,
    this.displayText = 'Password',
    this.errorMessage = 'Password harus diisi',
  });

  final CustomPasswordFormField? passwordToCheck;
  final String? errorMessage;
  final String? displayText;
  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() => _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isPasswordHidden,
      controller: widget.controller,
      decoration: _passwordFormFieldDecoration(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.errorMessage;
        }

        if (widget.passwordToCheck != null &&
            widget.passwordToCheck!.controller?.text != value) {
          return 'Password Tidak Sama!!';
        }
        return null;
      },
    );
  }

  InputDecoration _passwordFormFieldDecoration() {
    return InputDecoration(
      labelText: widget.displayText,
      filled: true,
      fillColor: const Color.fromARGB(200, 221, 221, 221),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      suffixIcon: IconButton(
        icon: Icon(_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() {
          _isPasswordHidden = !_isPasswordHidden;
        }),
      ),
    );
  }
}
