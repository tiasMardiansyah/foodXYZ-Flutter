import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.displayText = 'Form',
    this.errorMessage = 'Form harus diisi',
  });

  final String? errorMessage;
  final String? displayText;
  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        decoration: _textFormFieldDecoration(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errorMessage;
          }
          return null;
        });
  }

  InputDecoration _textFormFieldDecoration() {
    return InputDecoration(
      labelText: widget.displayText,
      filled: true,
      fillColor: const Color.fromARGB(199, 221, 221, 221),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
