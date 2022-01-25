import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;

  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const MyTextField({
    Key? key,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      key: key,
      validator: validator,
      initialValue: initialValue,
      style: kSFBodyBold,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        errorMaxLines: 2,
        hintText: hintText,
        hintStyle: kSFBodyBold2,
        fillColor: kBlueLight,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusColor: Colors.yellow,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
