import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  // Suggested code may be subject to a license. Learn more: ~LicenseLog:1818224279.
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;

  const MyTextfield({
    super.key, 
    required this.hintText,
    required this.obscureText,
    required this.controller,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          // Suggested code may be subject to a license. Learn more: ~LicenseLog:3756747878.
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary,),
        ),
      ),
    );
  }
}
