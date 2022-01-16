import 'package:cop_belgium/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCheckBox extends StatefulWidget {
  final String label;
  final dynamic value;
  final dynamic groupsValue;
  final Function(dynamic) onChanged;
  const MyCheckBox({
    Key? key,
    required this.value,
    required this.label,
    required this.groupsValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          padding: const EdgeInsets.all(1),
          child: TextButton(
            style: kTextButtonStyle,
            onPressed: () {
              widget.onChanged(widget.value);
            },
            child: widget.groupsValue != null
                ? Icon(
                    widget.value == widget.groupsValue
                        ? FontAwesomeIcons.check
                        : null,
                    size: 15,
                    color: kBlueDark,
                  )
                : Container(),
          ),
          decoration: const BoxDecoration(
            color: kGrey,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(widget.label, style: kSFBody),
      ],
    );
  }
}
