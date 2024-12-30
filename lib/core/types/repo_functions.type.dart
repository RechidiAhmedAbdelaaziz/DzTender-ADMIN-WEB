import 'package:tender/core/extensions/list.extension.dart';
import 'package:tender/core/network/models/api_response.model.dart';

import 'api_result.type.dart';

typedef RepoResult<T> = Future<ApiResult<T>>;
typedef RepoListResult<T> = Future<ApiResult<PaginationResult<T>>>;

class PaginationResult<T> {
  final Pagination pagination;
  final List<T> data;

  PaginationResult({
    this.pagination = const Pagination(),
    List<T>? data,
  }) : data = data ?? [];

  PaginationResult<T> add(T item) =>
      copyWith(data: data.withUnique(item));

  PaginationResult<T> addAll(List<T> items) =>
      copyWith(data: data.withAllUnique(items));

  PaginationResult<T> remove(T item) =>
      copyWith(data: data.withRemove(item));

  PaginationResult<T> replace(T item) =>
      copyWith(data: data.withReplace(item));

  PaginationResult<T> copyWith({
    Pagination? pagination,
    List<T>? data,
  }) {
    return PaginationResult(
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  PaginationResult.fromResponse({
    required PaginatedDataResponse response,
    required T Function(Map<String, dynamic>) fromJson,
  })  : pagination = response.pagination!,
        data = response.data!.map((e) => fromJson(e)).toList();
}
