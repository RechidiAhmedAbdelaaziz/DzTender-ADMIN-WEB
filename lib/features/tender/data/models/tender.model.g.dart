// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tender.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenderModel _$TenderModelFromJson(Map<String, dynamic> json) => TenderModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      announcer: json['announcer'] == null
          ? null
          : AnnouncerModel.fromJson(json['announcer'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : SubCategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      marketType: json['marketType'] == null
          ? null
          : MarketTypeModel.fromJson(
              json['marketType'] as Map<String, dynamic>),
      publicationDate: json['publicationDate'] == null
          ? null
          : DateTime.parse(json['publicationDate'] as String),
      deadline: json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
      region: json['region'] as String?,
      isStartup: json['isStartup'] as bool?,
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => SourceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
