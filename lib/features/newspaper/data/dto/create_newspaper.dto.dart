import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tender/core/extensions/map.extension.dart';
import 'package:tender/core/shared/dto/image.dto.dart';
import 'package:tender/features/newspaper/data/models/news_paper.model.dart';

abstract class NewspaperDTO extends Equatable {
  final TextEditingController name;
  final ImageDTO? image;

  NewspaperDTO({
    String? name,
    this.image,
  }) : name = TextEditingController(text: name);

  NewspaperDTO copyWith({
    String? name,
    ImageDTO? image,
  });

  Future<Map<String, dynamic>> toMap();

  @override
  List<Object?> get props => [name, image];
}

class CreateNewsPaperDTO extends NewspaperDTO {
  CreateNewsPaperDTO({
    super.name,
    super.image,
  });

  @override
  CreateNewsPaperDTO copyWith({
    String? name,
    ImageDTO? image,
  }) {
    return CreateNewsPaperDTO(
      name: name ?? this.name.text,
      image: image ?? this.image,
    );
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{
      'name': name.text,
      'image': await image?.toMultipartFile(),
    }.removeNullValues();

    return map;
  }
}

class UpdateNewsPaperDTO extends NewspaperDTO {
  final NewsPaperModel model;
  UpdateNewsPaperDTO({
    required this.model,
    String? name,
    ImageDTO? image,
  }) : super(
            image: image ?? NetworkImageDTO(url: model.imageUrl!),
            name: name ?? model.name);

  @override
  UpdateNewsPaperDTO copyWith({
    String? name,
    ImageDTO? image,
  }) {
    return UpdateNewsPaperDTO(
      model: model,
      name: name ?? this.name.text,
      image: image ?? this.image,
    );
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      if (name.text != model.name) 'name': name.text,
      if (image?.isModified(model.imageUrl!) ?? false)
        'image': await image?.toMultipartFile(),
    }.removeNullValues();
  }
}
