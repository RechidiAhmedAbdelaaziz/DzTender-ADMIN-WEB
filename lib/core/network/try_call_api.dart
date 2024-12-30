import 'package:flutter/material.dart';
import 'package:tender/core/types/api_result.type.dart';

import 'api_error.handler.dart';

class TryCallApi {
  static Future<ApiResult<T>> call<T>(
      Future<T> Function() apiCall) async {
    try {
      return ApiResult.success(await apiCall());
    } catch (error) {
      debugPrint(
          '\n\n!!!\n TryCallApi error: ${error.toString()} \n!!!\n\n');
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}
