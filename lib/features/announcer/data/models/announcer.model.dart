import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announcer.model.g.dart';

@JsonSerializable(createToJson: false)
class AnnouncerModel extends Equatable {
  const AnnouncerModel({
    required this.id,
    required this.name,
    required this.about,
    required this.isStartup,
    required this.imageUrl,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? about;
  final bool? isStartup;
  final String? imageUrl;

  

  factory AnnouncerModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncerModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
