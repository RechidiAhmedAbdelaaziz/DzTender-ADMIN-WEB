import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tender/features/newspaper/data/models/news_paper.model.dart';

part 'source.model.g.dart';

@JsonSerializable(createToJson: false)
class SourceModel extends Equatable {
  const SourceModel({
    required this.imageUrls,
    required this.newsPaper,
  });

  final List<String>? imageUrls;
  final NewsPaperModel? newsPaper;

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);

  @override
  List<Object?> get props => [imageUrls, newsPaper];
}
