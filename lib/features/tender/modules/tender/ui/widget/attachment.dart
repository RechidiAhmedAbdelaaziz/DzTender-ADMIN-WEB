part of '../screen/tender.screen.dart';

class _Attachment extends StatelessWidget {
  const _Attachment();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TenderCubit>();

    void updateTender(TenderDTO dto) => cubit.updateTender(dto);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.spMax,
            fontWeight: FontWeight.w700,
          ),
        ),
        heightSpace(20),
        _buildField(
          title: 'Select announcer',
          icon: AppIcons.announcer,
          onTap: () {},
        ),
        heightSpace(20),
        _buildField(
          title: 'Attach document',
          icon: AppIcons.news,
          onTap: () {
            context.dialogWith<SourceDTO>(
              onResult: (dto) {
                updateTender(
                    cubit.state.tenderDTO.copyWith(addedSource: dto));
              },
              child: const _AddDocs(),
            );
          },
        ),
        if (cubit.state.tenderDTO.sources.isNotEmpty) ...[
          heightSpace(12),
          Container(
            height: 450.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: PageView(
              controller: PageController(viewportFraction: 0.8),
              children: [
                ...cubit.state.tenderDTO.sources.map(
                  (e) => Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 4.w, vertical: 10.h),
                    child: InkWell(
                        onDoubleTap: () {
                          context.dialogWith<SourceDTO>(
                            onResult: (dto) {
                              updateTender(cubit.state.tenderDTO
                                  .copyWith(addedSource: dto));
                            },
                            child: _AddDocs(e),
                          );
                        },
                        child: SourceWidget(source: e)),
                  ),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }

  InkWell _buildField({
    required String title,
    required String icon,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 30.w,
              height: 30.h,
              fit: BoxFit.contain,
            ),
            widthSpace(10),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.spMax,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
