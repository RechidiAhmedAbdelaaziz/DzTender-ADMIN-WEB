part of 'news_papers.dart';

// ignore: must_be_immutable
class _NewsPaperForm extends StatefulWidget {
  NewspaperDTO newsPaperDTO;
  _NewsPaperForm([NewsPaperModel? paper])
      : newsPaperDTO = paper == null
            ? CreateNewsPaperDTO()
            : UpdateNewsPaperDTO(model: paper);

  @override
  State<_NewsPaperForm> createState() => _NewsPaperFormState();
}

class _NewsPaperFormState extends State<_NewsPaperForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.w,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20.h,
        children: [
          ImageFormField(
            height: 100,
            width: 100,
            radius: 40,
            initialValue: widget.newsPaperDTO.image,
            onChanged: (image) {
              setState(() {
                widget.newsPaperDTO =
                    widget.newsPaperDTO.copyWith(image: image);
              });
            },
          ),
          AppTextFormField(
            controller: widget.newsPaperDTO.name,
            title: 'Le nom du journal',
            hintText: 'Entrez le nom du journal',
            validator: (value) =>
                value.isEmpty ? 'Le nom du journal est requis' : null,
          ),
          InkWell(
            onTap: () {
              if (widget.newsPaperDTO.image != null) {
                context.back(widget.newsPaperDTO);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  'Enregistrer',
                  style: TextStyle(
                      color: widget.newsPaperDTO.image != null
                          ? Colors.white
                          : Colors.grey),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
