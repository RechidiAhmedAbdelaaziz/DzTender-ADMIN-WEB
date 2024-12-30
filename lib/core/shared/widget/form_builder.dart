import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/extensions/navigator.extension.dart';
import 'package:tender/core/themes/colors.dart';
import 'package:tender/core/themes/spaces.dart';

class FormBuilder extends StatelessWidget {
  final String title;
  final VoidCallback onSaved;
  final bool isUpdating;
  final Widget form;
  final Widget? attachment;

  const FormBuilder({
    super.key,
    required this.title,
    required this.onSaved,
    required this.isUpdating,
    required this.form,
    this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 70.h, color: Colors.white),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            color: const Color(0xffF3F4F6),
            child: Column(
              children: [
                heightSpace(20),
                Row(
                  children: [
                    _buildTitle(),
                    const Spacer(),
                    _buildButton(
                      text: isUpdating ? 'Update' : 'Create',
                      textColor: Colors.white,
                      color: AppColors.primary,
                      onPressed: onSaved,
                    ),
                    widthSpace(12),
                    _buildButton(
                      text: 'Cancel',
                      textColor: Colors.black,
                      color: Colors.white,
                      borderColor: const Color(0xffd0d5dd),
                      onPressed: () => context.back(),
                    ),
                    widthSpace(24),
                  ],
                ),
                heightSpace(20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        _buildBorderdConatiner(form, 7),
                        if (attachment != null) ...[
                          widthSpace(20),
                          _buildBorderdConatiner(attachment!, 3),
                        ]
                      ],
                    ),
                  ),
                ),
                heightSpace(60),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Expanded _buildBorderdConatiner(Widget child, [int flex = 1]) {
    return Expanded(
      flex: flex,
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: child,
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color textColor,
    required Color color,
    Color? borderColor,
    required void Function() onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: color,
          border: borderColor != null
              ? Border.all(color: borderColor)
              : null,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14.spMax,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      '${isUpdating ? 'Update' : 'Create'} $title',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.spMax,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
