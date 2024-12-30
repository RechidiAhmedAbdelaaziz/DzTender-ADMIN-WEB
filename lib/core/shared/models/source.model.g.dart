// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) => SourceModel(
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      newsPaper: json['newsPaper'] == null
          ? null
          : NewsPaperModel.fromJson(json['newsPaper'] as Map<String, dynamic>),
    );
