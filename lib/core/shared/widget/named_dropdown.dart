import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/shared/models/named.model.dart';
import 'package:tender/core/themes/spaces.dart';

class NamedDropDown<T extends NamedModel> extends StatelessWidget {
  final String title;
  final List<T> Function(BuildContext) itemsBuilder;
  final void Function(T)? onChanged;
  final bool isObligatory;
  const NamedDropDown({
    super.key,
    required this.title,
    required this.itemsBuilder,
    required this.onChanged,
    this.isObligatory = true,
  });

  @override
  Widget build(BuildContext context) {
    final items = itemsBuilder(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.spMax,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isObligatory)
              Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.spMax,
                ),
              ),
          ],
        ),
        heightSpace(10),
        Row(
          children: [
            Expanded(
              child: CustomDropdown<T>.search(
                validateOnChange: true,
                validator: (value) => isObligatory &&
                        (value == null || value.name?.isEmpty == true)
                    ? 'Ce champ est obligatoire'
                    : null,
                decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(12.r),
                  closedBorder: Border.all(
                    color: Colors.grey,
                  ),
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
                items: items,
                hintText: 'Select $title',
                onChanged: (value) => onChanged?.call(value!),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
