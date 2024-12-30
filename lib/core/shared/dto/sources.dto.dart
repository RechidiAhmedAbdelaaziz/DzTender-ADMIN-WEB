import 'package:equatable/equatable.dart';
import 'package:tender/core/shared/dto/image.dto.dart';
import 'package:tender/core/shared/models/source.model.dart';
import 'package:tender/features/newspaper/data/models/news_paper.model.dart';

class SourceDTO extends Equatable {
  final NewsPaperModel newsPaper;
  final List<ImageDTO> images;

  const SourceDTO({
    required this.newsPaper,
    required this.images,
  });

  factory SourceDTO.fromModel(SourceModel model) {
    return SourceDTO(
      newsPaper: model.newsPaper!,
      images: model.imageUrls
              ?.map((url) => NetworkImageDTO(url: url))
              .toList() ??
          [],
    );
  }

  bool isModified(SourceModel? model) {
    return model == null || model.imageUrls?.length != images.length;
  }

  @override
  List<Object?> get props => [newsPaper, images];
}

extension SourcesMapper on List<SourceDTO> {
  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{
      'newsPapers': this.map((e) => e.newsPaper.id).toList(),
    };

    for (var i = 0; i < length; i++) {
      map['sources[$i][images]'] = await Future.wait(
          this[i].images.map((e) => e.toMultipartFile()));
    }

    return map;
  }
}
