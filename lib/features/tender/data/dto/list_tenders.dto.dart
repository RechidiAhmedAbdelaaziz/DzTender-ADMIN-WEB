import 'package:tender/core/extensions/map.extension.dart';
import 'package:tender/core/shared/dto/pagination.dto.dart';
import 'package:tender/features/announcer/data/models/announcer.model.dart';
import 'package:tender/features/category/data/models/category.model.dart';
import 'package:tender/features/markettype/data/models/market_type.model.dart';

class ListTendersDTO extends PaginationDTO {
  CategoryModel? category;
  MarketTypeModel? marketType;
  AnnouncerModel? announcer;
  DateTime? publishedAt;
  bool? isStartup;
  String? region;
  DateTime? deadline;

  ListTendersDTO({
    this.category,
    this.marketType,
    this.announcer,
    this.publishedAt,
    this.isStartup,
    this.region,
    this.deadline,
    super.fields,
    super.limit,
    super.page,
    super.sort,
    super.keyword,
  });

  bool get isFiltered =>
      category != null ||
      marketType != null ||
      announcer != null ||
      publishedAt != null ||
      isStartup != null ||
      region != null ||
      deadline != null ||
      isStartup == true;

  @override
  Map<String, dynamic> toMap() {
    return {
      'category': category?.id,
      'marketType': marketType?.id,
      'announcer': announcer?.id,
      'publishedAt': publishedAt,
      'deadline': deadline,
      'region': region,
      if (isStartup ?? false) 'startup': true,
      ...super.toMap(),
    }.removeNullValues();
  }

  @override
  void copyWith({
    CategoryModel? category,
    MarketTypeModel? marketType,
    AnnouncerModel? announcer,
    DateTime? publishedAt,
    DateTime? deadline,
    bool? isStartup,
    int? page,
    int? limit,
    String? sort,
    String? keyword,
    String? fields,
    String? region,
  }) {
    this.category = category ?? this.category;
    this.marketType = marketType ?? this.marketType;
    this.announcer = announcer ?? this.announcer;
    this.publishedAt = publishedAt ?? this.publishedAt;
    this.isStartup = isStartup ?? this.isStartup;
    this.region = region ?? this.region;
    this.deadline = deadline ?? this.deadline;
    super.copyWith(
      page: page,
      limit: limit,
      sort: sort,
      keyword: keyword,
      fields: fields,
    );
  }

  void replace(ListTendersDTO dto) {
    category = dto.category;
    marketType = dto.marketType;
    announcer = dto.announcer;
    publishedAt = dto.publishedAt;
    isStartup = dto.isStartup;
    region = dto.region;
    deadline = dto.deadline;
    super.copyWith(
      page: 1,
      limit: 10,
      sort: dto.sort,
      fields: dto.fields,
    );
  }
}
