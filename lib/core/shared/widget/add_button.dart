import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/themes/colors.dart';
import 'package:tender/core/themes/spaces.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final String title;
  final IconData? icon;
  final bool isActivated;

  const SubmitButton({
    required this.onSubmit,
    this.title = 'Ajouter',
    this.isActivated = true,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isActivated) onSubmit();
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: Colors.white,
                size: 20.spMax,
              ),
              widthSpace(10),
            ],
            Text(
              title,
              style: TextStyle(
                color: isActivated ? Colors.white : Colors.grey,
                fontSize: 14.spMax,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
