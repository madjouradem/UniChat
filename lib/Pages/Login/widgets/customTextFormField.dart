import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          label: Container(
            margin: const EdgeInsets.only(left: 13),
            child: Text(labelText!),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
