import 'package:flutter/material.dart';

import '../color.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final FocusNode focusNode;
  final FormFieldValidator validator;
  final FormFieldSetter onFieldSubmitted;
  final TextInputType keyboardType;
  final IconData icon;


  const TextFormFieldComponent({
    Key? key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    required this.focusNode,
    required this.validator,
    required this.onFieldSubmitted,
    required this.keyboardType,
    required this.icon,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20 ),
      child: TextFormField(
        focusNode: focusNode,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 19),
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.alertColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
