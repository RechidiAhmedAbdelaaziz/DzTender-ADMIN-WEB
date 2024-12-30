import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/extensions/list.extension.dart';
import 'package:tender/core/shared/dto/image.dto.dart';
import 'package:tender/core/shared/widget/image_field.dart';

class MultiImageField extends StatefulWidget {
  final double height;
  final double width;
  final double radius;

  final List<ImageDTO>? initialValues;

  final void Function(ImageDTO?)? onAdd;
  final void Function(ImageDTO?)? onRemove;

  MultiImageField({
    super.key,
    this.height = 200,
    this.width = 200,
    this.radius = 20,
    this.initialValues,
    this.onAdd,
    this.onRemove,
  });

  @override
  State<MultiImageField> createState() =>
      _MultiImageFieldState(initialValues);
}

class _MultiImageFieldState extends State<MultiImageField> {
  List<ImageDTO>? imageDTOs;
  int currentPage = 0;
  PageController? controller;
  // add listener to page controller

  @override
  void initState() {
    controller ??= PageController();
    controller!.addListener(() {
      if (controller!.page!.round() == currentPage) return;
      setState(() {
        currentPage = controller!.page!.round();
      });
    });
    super.initState();
  }

  _MultiImageFieldState([this.imageDTOs]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height.h + 20.h,
      width: widget.width.w + 20,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < (imageDTOs?.length ?? 0); i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 15.h,
                    width: i == currentPage ? 25.w : 15.w,
                    decoration: BoxDecoration(
                      color: i == currentPage
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 15.h,
                  width: (imageDTOs?.length ?? 0) == currentPage
                      ? 30.w
                      : 15.w,
                  decoration: BoxDecoration(
                    color: (imageDTOs?.length ?? 0) == currentPage
                        ? Colors.red
                        : Colors.red.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: [
                for (final imageDTO in imageDTOs ?? [])
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ImageFormField(
                        height: widget.height,
                        width: widget.width,
                        radius: widget.radius,
                        initialValue: imageDTO,
                        onChanged: (imageDTO) {
                          widget.onAdd?.call(imageDTO);
                          setState(
                              () => imageDTOs?.addUnique(imageDTO!));
                        },
                        onRemove: (imageDTO) {
                          widget.onRemove?.call(imageDTO);
                          setState(() => imageDTOs?.remove(imageDTO));
                        },
                      ),
                    ],
                  ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ImageFormField(
                      height: widget.height,
                      width: widget.width,
                      radius: widget.radius,
                      onChanged: (imageDTO) {
                        widget.onAdd?.call(imageDTO);
                        setState(() {
                          imageDTOs ??= [];
                          imageDTOs!.addUnique(imageDTO!);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
