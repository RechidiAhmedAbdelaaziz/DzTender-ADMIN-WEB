import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tender/core/di/container.dart';
import 'package:tender/features/Auth/data/sources/auth.cache.dart';
import 'package:tender/features/Auth/logic/auth.cubit.dart';

class DioHelper {
  static Dio? _dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (_dio == null) {
      _dio = Dio();

      _dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.baseUrl =
            FlavorConfig.instance.variables["baseUrl"] ?? ''
        ..options.headers = {'Accept': 'application/json'};

      _dio!.interceptors.add(_prettyDioLogger);

      return _dio!;
    } else {
      return _dio!;
    }
  }

  static void addTokenInterceptor() {
    _dio!.interceptors.add(_tokensInterceptor);
  }

  static void removeTokenInterceptor() {
    _dio!.interceptors.remove(_tokensInterceptor);
  }

  static PrettyDioLogger get _prettyDioLogger => PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
      );

  static InterceptorsWrapper get _tokensInterceptor {
    final authCacheHelper = locator<AuthCache>();

    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await authCacheHelper.accessToken;
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },

      // refresh token logic
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshToken = await authCacheHelper.refreshToken;

          if (refreshToken != null) {
            final authCubit = locator<AuthCubit>();
            await authCubit.refreshToken(refreshToken);

            return handler
                .resolve(await _dio!.fetch(error.requestOptions));
          }
        }

        return handler.next(error);
      },
    );
  }
}
