import 'package:freezed_annotation/freezed_annotation.dart';

import '../network/models/api_error.model.dart';

part 'api_result.type.freezed.dart';

@Freezed()
abstract class ApiResult<T>
    with _$ApiResult<T> {
  const factory ApiResult.success(T data) = _Success<T>;
  const factory ApiResult.error(ApiErrorModel errorHandler) =
      _Failure<T>;
}
