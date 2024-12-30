import 'package:json_annotation/json_annotation.dart';
import 'package:tender/core/shared/models/named.model.dart';

import 'category.model.dart';
part 'sub_category.model.g.dart';

@JsonSerializable(createToJson: false)
class SubCategoryModel extends NamedModel {
  const SubCategoryModel({
    required this.id,
    required super.name,
    required this.category,
  });

  @JsonKey(name: '_id')
  final String? id;
  final CategoryModel? category;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
