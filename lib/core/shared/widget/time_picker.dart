import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/themes/spaces.dart';

class AppDatePicker extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final String title;
  final DateTime? firstDate;
  final DateTime? lastDate;
  const AppDatePicker({
    super.key,
    required this.onChanged,
    required this.title,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.spMax,
            fontWeight: FontWeight.w600,
          ),
        ),
        heightSpace(10),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: widget.firstDate ?? DateTime.now(),
              lastDate: widget.lastDate ??
                  DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              setState(() => _selectedDate = date);
              widget.onChanged(date);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black,
                  size: 20.spMax,
                ),
                widthSpace(12),
                Text(
                  _selectedDate == null
                      ? 'Choisir une date'
                      : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                  style: TextStyle(
                    color: _selectedDate == null
                        ? Colors.grey
                        : Colors.black,
                    fontSize: 14.spMax,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
