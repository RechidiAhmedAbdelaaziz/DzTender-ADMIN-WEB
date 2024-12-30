import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tender/core/helper/file_pick.helper.dart';
import 'package:tender/core/shared/dto/image.dto.dart';
import 'package:tender/core/themes/icons.dart';

class ImageFormField extends StatefulWidget {
  final double height;
  final double width;
  final double radius;

  final ImageDTO? initialValue;
  final void Function(ImageDTO?)? onChanged;
  final void Function(ImageDTO?)? onRemove;

  const ImageFormField({
    super.key,
    this.height = 200,
    this.width = 200,
    this.radius = 20,
    this.initialValue,
    this.onChanged,
    this.onRemove,
  });

  @override
  State<ImageFormField> createState() =>
      // ignore: no_logic_in_create_state
      _ImageFormFieldState(initialValue);
}

class _ImageFormFieldState extends State<ImageFormField> {
  ImageDTO? imageDTO;

  _ImageFormFieldState([this.imageDTO]);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: const Color.fromARGB(255, 90, 149, 237),
      radius: Radius.circular(widget.radius.r),
      dashPattern: const [10, 5],
      borderType: BorderType.RRect,
      strokeCap: StrokeCap.round,
      child: Container(
        height: widget.height.h,
        width: widget.width.w,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.radius.r),
          image: imageDTO?.imageProvider != null
              ? DecorationImage(
                  image: imageDTO!.imageProvider,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageDTO != null
            ? Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    radius: 22.r,
                    child:
                        const Icon(Icons.delete, color: Colors.white),
                  ),
                  onPressed: () {
                    widget.onRemove?.call(imageDTO);
                    setState(() => imageDTO = null);
                  },
                ),
              )
            : Center(
                child: InkWell(
                  onTap: () async {
                    final image = await FilePickHelper.pickImage();

                    if (image != null) {
                      final imageDTO = LocalImageDTO(image: image);

                      setState(() => this.imageDTO = imageDTO);
                      widget.onChanged?.call(imageDTO);
                    }
                  },
                  child:
                      SvgPicture.asset(AppIcons.upload, height: 50.h),
                ),
              ),
      ),
    );
  }
}
