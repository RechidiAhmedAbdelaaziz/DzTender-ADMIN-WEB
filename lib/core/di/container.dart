import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tender/core/helper/dio.helper.dart';
import 'package:tender/core/router/router.dart';
import 'package:tender/features/Auth/configs/auth.dependency.dart';
import 'package:tender/features/newspaper/configs/newspaper.dependency.dart';
import 'package:tender/features/tender/configs/tender.dependency.dart';

import '../helper/cache.helper.dart';

part 'dependecy_base.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPref);

  locator.registerLazySingleton(() => const FlutterSecureStorage());

  locator.registerLazySingleton(() => DioHelper.getDio());
  locator.registerLazySingleton(() => CacheHelper());

  locator.registerSingleton(AppRouter());

  await DependencyBase._init();

  locator.allowReassignment = true;
}
