import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_paper.model.g.dart';

@JsonSerializable(createToJson: false)
class NewsPaperModel extends Equatable {
  const NewsPaperModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? name;

  final String? imageUrl;

  factory NewsPaperModel.fromJson(Map<String, dynamic> json) =>
      _$NewsPaperModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
