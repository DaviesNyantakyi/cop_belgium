import 'package:cop_belgium/utilities/constant.dart';
import 'package:cop_belgium/utilities/fonts.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool obscureText;
  const MyTextField({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.onChanged,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: kSFCaption,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: kSFBody,
        fillColor: kBlueLight,
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

  static Widget buildTF({
    required String label,
    required String hintText,
    required bool obscureText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            label,
            style: kSFBody,
          ),
        ),
        MyTextField(
          obscureText: obscureText,
          hintText: hintText,
          onChanged: onChanged,
          keyboardType: keyboardType,
        )
      ],
    );
  }
}
