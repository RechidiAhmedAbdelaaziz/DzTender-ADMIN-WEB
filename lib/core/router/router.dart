// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/features/Auth/configs/auth.route.dart';
import 'package:tender/features/Auth/logic/auth.cubit.dart';
import 'package:tender/features/home/configs/home.route.dart';
import 'package:tender/features/tender/modules/tenders/ui/screen/tenders.screen.dart';

part 'route_base.dart';
part 'navigator_base.dart';

class AppRouter {
  final routerConfig = GoRouter(
    initialLocation: TendersScreen.route,
    routes: [
      AuthRoute.login(),
      HomeRoute(),
    ].map((e) => e.route).toList(),
    debugLogDiagnostics: true,
    redirect: _handelRedirect,
  );

  void to(AppNavigatorBase navigator) => navigator._to();
  void off(AppNavigatorBase navigator) => navigator._off();
  void offAll(AppNavigatorBase navigator) => navigator._offAll();

  static FutureOr<String?> _handelRedirect(context, state) {
    final isAuthenticated =
        locator<AuthCubit>().state.isAuthenticated;

    if (!isAuthenticated) {
      return '/login';
    }
    return null;
  }
}
