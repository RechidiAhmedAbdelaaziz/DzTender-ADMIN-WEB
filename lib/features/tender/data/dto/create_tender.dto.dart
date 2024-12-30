part of 'tender.dto.dart';

class CreateTenderDTO extends TenderDTO {
  CreateTenderDTO({
    super.title,
    super.category,
    super.announcer,
    super.marketType,
    super.region,
    super.publishedAt,
    super.deadline,
    super.isStartup,
    super.sources,
  });

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'title': title.text,
      'category': category?.id,
      'marketType': marketType?.id,
      'announcer': announcer?.id,
      'publishedAt': publishedAt?.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
      'region': region?.name,
      'startup': isStartup,
      ...await sources.toMap(),
    }.removeNullValues();
  }

  @override
  CreateTenderDTO copyWith({
    String? title,
    SubCategoryModel? category,
    AnnouncerModel? announcer,
    MarketTypeModel? marketType,
    NamedModel? region,
    DateTime? publishedAt,
    DateTime? deadline,
    bool? isStartup,
    SourceDTO? addedSource,
    SourceDTO? removedSource,
  }) {
    setSources(
        addedSource: addedSource, removedSource: removedSource);
    return CreateTenderDTO(
      title: title ?? this.title.text,
      category: category ?? this.category,
      announcer: announcer ?? this.announcer,
      marketType: marketType ?? this.marketType,
      region: region ?? this.region,
      publishedAt: publishedAt ?? this.publishedAt,
      deadline: deadline ?? this.deadline,
      isStartup: isStartup ?? this.isStartup,
      sources: sources,
    );
  }
}
