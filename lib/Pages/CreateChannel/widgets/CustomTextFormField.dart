import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.lableText,
    required this.hintText,
    required this.tec,
    this.validator,
  });

  final String lableText;
  final String hintText;
  final TextEditingController tec;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: TextFormField(
        controller: tec,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: lableText,
          hintText: hintText,
        ),
      ),
    );
  }
}
