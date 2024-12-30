import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender/core/router/router.dart';
import 'package:tender/core/router/routes.dart';
import 'package:tender/features/Auth/module/login/logic/login.cubit.dart';

import '../module/login/ui/screen/login.screen.dart';

class AuthRoute extends AppRouteBase {
  AuthRoute.login()
      : super(
          builder: _loginPageBuilder,
          path: LoginScreen.route,
          name: AppRoutes.login,
        );

  AuthRoute.test()
      : super(
          builder: _loginPageBuilder,
          path: '/test',
          name: 'test',
        );
  static Widget _loginPageBuilder(context, state) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginScreen(),
    );
  }
}
