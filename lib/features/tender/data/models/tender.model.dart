import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tender/core/shared/models/source.model.dart';
import 'package:tender/features/announcer/data/models/announcer.model.dart';
import 'package:tender/features/category/data/models/sub_category.model.dart';
import 'package:tender/features/markettype/data/models/market_type.model.dart';

part 'tender.model.g.dart';

@JsonSerializable(createToJson: false)
class TenderModel extends Equatable {
  const TenderModel({
    required this.id,
    required this.title,
    required this.announcer,
    required this.category,
    required this.marketType,
    required this.publicationDate,
    required this.deadline,
    required this.region,
    required this.isStartup,
    required this.sources,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final AnnouncerModel? announcer;
  final SubCategoryModel? category;
  final MarketTypeModel? marketType;
  final DateTime? publicationDate;
  final DateTime? deadline;
  final String? region;
  final bool? isStartup;
  final List<SourceModel>? sources;

  factory TenderModel.fromJson(Map<String, dynamic> json) =>
      _$TenderModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
