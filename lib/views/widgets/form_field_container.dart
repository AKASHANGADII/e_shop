import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final bool isObscure;

  const FormFieldContainer({super.key, required this.controller, required this.labelText, required this.isObscure,required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 5, horizontal: 10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
          ),
          obscureText: isObscure,
          validator: validator,
        ),
      ),
    );
  }
}
