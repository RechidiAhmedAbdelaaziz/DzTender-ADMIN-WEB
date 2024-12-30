import 'package:tender/core/extensions/list.extension.dart';
import 'package:tender/core/extensions/map.extension.dart';
import 'package:tender/core/shared/dto/sources.dto.dart';
import 'package:tender/core/shared/models/named.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tender/features/announcer/data/models/announcer.model.dart';
import 'package:tender/features/category/data/models/sub_category.model.dart';
import 'package:tender/features/markettype/data/models/market_type.model.dart';

import '../models/tender.model.dart';

part 'create_tender.dto.dart';
part 'update_tender.dto.dart';

abstract class TenderDTO extends Equatable {
  TenderDTO({
    String? title,
    this.category,
    this.announcer,
    this.marketType,
    this.region,
    this.publishedAt,
    this.deadline,
    this.isStartup = false,
    List<SourceDTO>? sources,
  })  : sources = sources ?? [],
        title = TextEditingController(text: title);

  final TextEditingController title;
  final SubCategoryModel? category;
  final AnnouncerModel? announcer;
  final MarketTypeModel? marketType;
  final NamedModel? region;
  final DateTime? publishedAt;
  final DateTime? deadline;
  final bool isStartup;
  final List<SourceDTO> sources;

  TenderDTO copyWith({
    String? title,
    SubCategoryModel? category,
    AnnouncerModel? announcer,
    MarketTypeModel? marketType,
    NamedModel? region,
    DateTime? publishedAt,
    DateTime? deadline,
    bool? isStartup,
    SourceDTO? addedSource,
    SourceDTO? removedSource,
  });

  Future<Map<String, dynamic>> toMap();

  void setSources({
    SourceDTO? addedSource,
    SourceDTO? removedSource,
  }) {
    if (addedSource != null) {
      sources.any((element) =>
              element.newsPaper.id == addedSource.newsPaper.id)
          ? sources
              .firstWhere((element) =>
                  element.newsPaper.id == addedSource.newsPaper.id)
              .images
              .addAllUnique(addedSource.images)
          : sources.add(addedSource);
    }

    if (removedSource != null) {
      sources.removeWhere((element) =>
          element.newsPaper.id == removedSource.newsPaper.id);
    }
  }

  @override
  List<Object?> get props => [
        title,
        category,
        announcer,
        marketType,
        region,
        publishedAt,
        deadline,
        isStartup,
        sources
      ];
}
