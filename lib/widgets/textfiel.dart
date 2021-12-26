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

  const MyTextField({
    Key? key,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      validator: validator,
      initialValue: initialValue,
      style: kSFCaptionBold,
      keyboardType: keyboardType,
      obscureText: obscureText!,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        errorMaxLines: 2,
        hintText: hintText,
        hintStyle: kSFBody,
        fillColor: kBlueLight2,
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
