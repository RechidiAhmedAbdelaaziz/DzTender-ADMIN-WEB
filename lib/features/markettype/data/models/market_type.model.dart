import 'package:json_annotation/json_annotation.dart';
import 'package:tender/core/shared/models/named.model.dart';

part 'market_type.model.g.dart';

@JsonSerializable(createToJson: false)
class MarketTypeModel extends NamedModel {
  const MarketTypeModel({
    required this.id,
    required super.name,
  });

  @JsonKey(name: '_id')
  final String? id;


  factory MarketTypeModel.fromJson(Map<String, dynamic> json) =>
      _$MarketTypeModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        name,
        
        
      ];
}
