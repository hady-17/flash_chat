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
      style: Theme.of(context).textTheme.bodyMedium,
      obscureText: _obscureText,
      onChanged: (value) {
        widget.onChanged(value);
      },
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
