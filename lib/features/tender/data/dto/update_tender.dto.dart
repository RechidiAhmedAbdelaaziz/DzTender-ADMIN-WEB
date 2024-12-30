part of 'tender.dto.dart';

class UpdateTenderDTO extends TenderDTO {
  final TenderModel model;

  UpdateTenderDTO({
    required this.model,
    super.title,
    super.category,
    super.announcer,
    super.marketType,
    super.region,
    super.publishedAt,
    super.deadline,
    super.sources,
    super.isStartup,
  });

  UpdateTenderDTO.fromModel(this.model)
      : super(
          title: model.title,
          category: model.category,
          announcer: model.announcer,
          marketType: model.marketType,
          region: NamedModel(name: model.region),
          publishedAt: model.publicationDate,
          deadline: model.deadline,
          isStartup: model.isStartup ?? false,
          sources: model.sources
              ?.map((e) => SourceDTO.fromModel(e))
              .toList(),
        );

  // toMap only the changed fields
  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      if (title.text != model.title) 'title': title.text,
      if (category != model.category) 'category': category?.id,
      if (marketType != model.marketType)
        'marketType': marketType?.id,
      if (announcer != model.announcer) 'announcer': announcer?.id,
      if (publishedAt != model.publicationDate)
        'publishedAt': publishedAt?.toIso8601String(),
      if (deadline != model.deadline)
        'deadline': deadline?.toIso8601String(),
      if (region?.name != model.region) 'region': region?.name,
      if (isStartup != model.isStartup) 'startup': isStartup,
      if (sources.any(
        (e) => e.isModified(
          model.sources?.firstWhere(
              (element) => element.newsPaper!.id == e.newsPaper.id),
        ),
      ))
        ...await sources.toMap(),
    }.removeNullValues();
  }

  @override
  TenderDTO copyWith({
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
    return UpdateTenderDTO(
      model: model,
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
