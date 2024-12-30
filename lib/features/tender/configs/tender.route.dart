import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tender/core/router/router.dart';
import 'package:tender/core/router/routes.dart';
import 'package:tender/features/tender/modules/tender/logic/tender.cubit.dart';
import 'package:tender/features/tender/modules/tender/ui/screen/tender.screen.dart';
import 'package:tender/features/tender/modules/tenders/logic/tenders.cubit.dart';
import 'package:tender/features/tender/modules/tenders/ui/screen/tenders.screen.dart';

class TenderRoute extends AppRouteBase {
  static final routes = [
    TenderRoute.tenders(),
    TenderRoute.createTender(),
    TenderRoute.updateTender(),
  ];

  TenderRoute.tenders()
      : super(
          path: TendersScreen.route,
          name: AppRoutes.tender,
          builder: _tendersBuilder,
        );

  TenderRoute.createTender()
      : super(
          path: TenderScreen.createTender,
          name: AppRoutes.createTender,
          builder: _createTenderBuilder,
        );

  TenderRoute.updateTender()
      : super(
          path: TenderScreen.updateTender,
          name: AppRoutes.updateTender,
          builder: _updateTenderBuilder,
        );

  static Widget _tendersBuilder(
      BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => TendersCubit()..fetchTenders(),
      child: TendersScreen(),
    );
  }

  static Widget _createTenderBuilder(
      BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (_) => TenderCubit(),
      child: const TenderScreen(),
    );
  }

  static Widget _updateTenderBuilder(
      BuildContext context, GoRouterState state) {
    final tenderId = state.pathParameters['id'];
    return BlocProvider(
      create: (_) => TenderCubit(tenderId),
      child: const TenderScreen(),
    );
  }
}
