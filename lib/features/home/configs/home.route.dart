import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tender/core/router/router.dart';
import 'package:tender/core/router/routes.dart';
import 'package:tender/features/home/ui/screen/home.screen.dart';
import 'package:tender/features/tender/configs/tender.route.dart';

class HomeRoute extends AppRouteBase {
  HomeRoute()
      : super(
          path: HomeScreen.route,
          name: AppRoutes.home,
        );

  Widget _homePageBuilder(
      BuildContext context, GoRouterState state, Widget child) {
    return HomeScreen(child);
  }

  @override
  RouteBase get route => ShellRoute(
        builder: _homePageBuilder,
        routes: [
          ...TenderRoute.routes,
        ].map((e) => e.route).toList(),
      );
}
