part of '../screen/tender.screen.dart';

class _AddDocs extends StatefulWidget {
  final SourceDTO? initialSource;
  const _AddDocs([this.initialSource]);

  @override
  State<_AddDocs> createState() => _AddDocsState(initialSource);
}

class _AddDocsState extends State<_AddDocs> {
  final List<ImageDTO> _imageDTO;

  NewsPaperModel? _newspaperDTO;

  _AddDocsState([SourceDTO? source])
      : _imageDTO = source?.images ?? [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsPaperCubit()..getNewsPapers(),
      child: Container(
        height: 750,
        constraints: BoxConstraints(maxWidth: 800.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                children: [
                  MultiImageField(
                    height: 650,
                    width: 350,
                    initialValues: _imageDTO,
                    onAdd: (dto) {
                      setState(() => _imageDTO.addUnique(dto!));
                    },
                    onRemove: (dto) {
                      setState(() => _imageDTO.remove(dto));
                    },
                  ),
                  widthSpace(8),
                  Expanded(
                    child: NewsPapers(
                      initialNewsPaper:
                          widget.initialSource?.newsPaper,
                      onNewsPaperSelected: (paper) {
                        setState(() => _newspaperDTO = paper);
                      },
                    ),
                  ),
                ],
              ),
            ),
            heightSpace(16),
            SubmitButton(
              onSubmit: () {
                return context.back(SourceDTO(
                  newsPaper: _newspaperDTO!,
                  images: _imageDTO,
                ));
              },
              title: 'Sauvegarder',
              isActivated:
                  _imageDTO.isNotEmpty && _newspaperDTO != null,
            ),
          ],
        ),
      ),
    );
  }
}
