import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/core/extensions/navigator.extension.dart';
import 'package:tender/core/shared/widget/textform_field.dart';
import 'package:tender/core/themes/spaces.dart';
import 'package:tender/core/utils/validators.dart';
import 'package:tender/features/Auth/logic/auth.cubit.dart';
import 'package:tender/features/Auth/module/login/logic/login.cubit.dart';
import 'package:tender/features/tender/configs/tender.navigator.dart';

part '../widget/submit_button.dart';
part '../widget/login_form.dart';
part '../widget/header.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.onLoginSuccess((tokens) async {
          await locator<AuthCubit>().authenticate(tokens);
          // ignore: use_build_context_synchronously
          context.to(TenderNavigator.tenders());
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff8f8f8),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 274.w, vertical: 110.h),
          padding:
              EdgeInsets.symmetric(horizontal: 56.w, vertical: 172.h),
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Header(),
              const Spacer(),
              const _LoginForm(),
              heightSpace(40),
              const _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
