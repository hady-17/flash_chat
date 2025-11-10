import 'package:flutter/material.dart';
import '../constants.dart';

class PassField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const PassField({super.key, required this.onChanged});

  @override
  State<PassField> createState() => _PassFieldState();
}

class _PassFieldState extends State<PassField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
      obscureText: _obscureText,
      onChanged: (value) {
        widget.onChanged(value);
      },
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
