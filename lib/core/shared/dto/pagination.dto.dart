import 'package:tender/core/extensions/map.extension.dart';

class PaginationDTO {
  int page;
  int limit;
  String? sort;
  String? keyword;
  String? fields;

  PaginationDTO({
    this.page = 1,
    this.limit = 10,
    this.sort,
    this.keyword,
    this.fields,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'limit': limit,
      'sort': sort,
      'keyword': keyword,
      'fields': fields,
    }.removeNullValues();
  }

  void copyWith({
    int? page,
    int? limit,
    String? sort,
    String? keyword,
    String? fields,
  }) {
    this.page = page ?? this.page;
    this.limit = limit ?? this.limit;
    this.sort = sort ?? this.sort;
    this.keyword = keyword ?? this.keyword;
    this.fields = fields ?? this.fields;
  }
}
