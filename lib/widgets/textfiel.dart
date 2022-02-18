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
  final int? maxLines;
  final Function(String)? onSubmitted;
  final Color? fillColor;
  final InputBorder? focusedBorder;
  final TextStyle? style;
  final TextEditingController? controller;

  const MyTextField({
    Key? key,
    this.hintText,
    this.initialValue,
    this.maxLines,
    this.keyboardType,
    this.controller,
    this.onSubmitted,
    this.style,
    this.focusedBorder,
    this.fillColor,
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
      style: style ?? kSFTextFieldStyle,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      textInputAction: textInputAction,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        errorMaxLines: 2,
        hintText: hintText,
        hintStyle: style?.copyWith(color: Colors.black54) ??
            kSFTextFieldStyle.copyWith(color: Colors.black54),
        fillColor: fillColor ?? kBlueLight,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: focusedBorder,
      ),
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }
}
