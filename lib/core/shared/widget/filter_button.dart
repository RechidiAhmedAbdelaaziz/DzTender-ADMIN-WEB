import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/themes/colors.dart';
import 'package:tender/core/themes/spaces.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onFilter;
  final bool isFiltered;
  final VoidCallback onClearFilter;

  const FilterButton({
    super.key,
    required this.onFilter,
    this.isFiltered = true,
    required this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onFilter,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isFiltered ? Colors.blueGrey : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.grey,
            width: (0.5).r,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.filter_list,
              color: isFiltered ? Colors.white : Colors.black,
              size: 20.spMax,
            ),
            widthSpace(12),
            Text(
              'Filters',
              style: TextStyle(
                color: isFiltered ? Colors.white : Colors.black,
                fontSize: 14.spMax,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isFiltered)
              InkWell(
                onTap: onClearFilter,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20.spMax,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
