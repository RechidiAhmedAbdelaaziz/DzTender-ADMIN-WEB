import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/core/helper/dio.helper.dart';
import 'package:tender/core/network/models/api_response.model.dart';
import 'package:tender/core/router/router.dart';
import 'package:tender/features/Auth/configs/auth.navigator.dart';
import 'package:tender/features/Auth/data/repositories/auth.repo.dart';
import 'package:tender/features/Auth/data/sources/auth.cache.dart';

part 'auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _authCache = locator<AuthCache>();
  final _router = locator<AppRouter>();
  final _authRepo = locator<AuthRepo>();
  AuthCubit() : super(AuthState()) {
    checkAuthentication();
  }

  bool get isAuthenticated => state.isAuthenticated;

  void checkAuthentication() async {
    final tokens = [
      await _authCache.accessToken,
      await _authCache.refreshToken,
    ];

    if (tokens.any((element) => element == null)) {
      emit(state.copyWith(isAuthenticated: false));
      return;
    }

    DioHelper.addTokenInterceptor();
    emit(state.copyWith(isAuthenticated: true));
  }

  Future<void> authenticate(AuthTokens tokens) async {
    await _authCache.setTokens(tokens);
    DioHelper.addTokenInterceptor();
    emit(state.copyWith(isAuthenticated: true));
  }

  void logout() async {
    await _authCache.clearTokens();
    DioHelper.removeTokenInterceptor();
    emit(state.copyWith(isAuthenticated: false));
    _router.offAll(AuthNavigator.login());
  }

  Future<void> refreshToken(String refreshToken) async {
    final result = await _authRepo.refreshToken(refreshToken);
    result.when(
      success: (tokens) => authenticate(tokens),
      error: (error) => logout(),
    );
  }
}
