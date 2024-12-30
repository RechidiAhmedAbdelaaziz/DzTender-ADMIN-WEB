import 'package:flutter/foundation.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/features/Auth/data/repositories/auth.repo.dart';
import 'package:tender/features/Auth/data/sources/auth.api.dart';
import 'package:tender/features/Auth/data/sources/auth.cache.dart';
import 'package:tender/features/Auth/logic/auth.cubit.dart';

class AuthDependency extends DependencyBase {
  @override
  void init() async {
    injector.registerLazySingleton(() => AuthApi(injector()));
    injector.registerLazySingleton(() => AuthRepo());
    injector.registerLazySingleton(
        () => kIsWeb ? WebAuthCache() : SecureAuthCache());
    injector.registerSingleton(AuthCubit());
  }
}
