import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/core/extensions/navigator.extension.dart';
import 'package:tender/core/router/routes.dart';
import 'package:tender/core/themes/colors.dart';
import 'package:tender/core/themes/icons.dart';
import 'package:tender/core/themes/spaces.dart';
import 'package:tender/features/Auth/logic/auth.cubit.dart';
import 'package:tender/features/tender/configs/tender.navigator.dart';

part '../widget/drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';
  const HomeScreen(this._child, {super.key});

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [const _Drawer(), Expanded(child: _child)],
      ),
    );
  }
}
