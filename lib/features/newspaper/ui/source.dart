import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/shared/dto/sources.dto.dart';
import 'package:tender/core/themes/spaces.dart';
import 'package:tender/features/newspaper/ui/news_papers.dart';

class SourceWidget extends StatefulWidget {
  final SourceDTO source;

  const SourceWidget({super.key, required this.source});

  @override
  State<SourceWidget> createState() => _SourceWidgetState();
}

class _SourceWidgetState extends State<SourceWidget> {
  PageController? _controller;

  int _currentPage = 0;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.9);
    _controller!.addListener(() {
      setState(() {
        _currentPage = _controller!.page!.round();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.h,
      width: double.infinity,
      child: Column(
        children: [
          heightSpace(5),
          NewsPaper(widget.source.newsPaper, withName: false),
          heightSpace(5),
          // build indicator
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 0; i < widget.source.images.length; i++)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                width: 10.w,
                height: 10.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      i == _currentPage ? Colors.black : Colors.grey,
                ),
              ),
          ]),
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              children: widget.source.images
                  .map((e) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: e.imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
