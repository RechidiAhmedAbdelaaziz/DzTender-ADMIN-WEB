import 'package:json_annotation/json_annotation.dart';
import 'package:tender/core/shared/models/named.model.dart';

part 'category.model.g.dart';

@JsonSerializable(createToJson: false)
class CategoryModel extends NamedModel {
  const CategoryModel({
    required this.id,
    super.name,
  });

  @JsonKey(name: '_id')
  final String? id;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
