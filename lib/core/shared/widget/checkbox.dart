import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckbox extends StatefulWidget {
  final String title;
  final void Function(bool) onChanged;
  const AppCheckbox(
      {super.key, required this.title, required this.onChanged});

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: value,
            onChanged: (value) {
              setState(() {
                this.value = value ?? false;
              });
              widget.onChanged(value ?? false);
            }),
        Text(
          widget.title,
          style: TextStyle(fontSize: 16.spMax),
        ),
      ],
    );
  }
}
