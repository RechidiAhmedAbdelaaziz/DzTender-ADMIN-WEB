import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/extensions/dialog.extension.dart';
import 'package:tender/core/extensions/list.extension.dart';
import 'package:tender/core/extensions/navigator.extension.dart';
import 'package:tender/core/shared/widget/image_field.dart';
import 'package:tender/core/shared/widget/textform_field.dart';
import 'package:tender/core/themes/colors.dart';
import 'package:tender/core/themes/spaces.dart';
import 'package:tender/core/utils/validators.dart';
import 'package:tender/features/newspaper/data/dto/create_newspaper.dto.dart';
import 'package:tender/features/newspaper/data/models/news_paper.model.dart';

import '../logic/newspaper.cubit.dart';

part 'form.dart';

class NewsPapers extends StatefulWidget {
  final void Function(NewsPaperModel newsPaper) onNewsPaperSelected;
  final NewsPaperModel? initialNewsPaper;
  const NewsPapers(
      {super.key,
      required this.onNewsPaperSelected,
      this.initialNewsPaper});

  @override
  State<NewsPapers> createState() => _NewsPapersState();
}

class _NewsPapersState extends State<NewsPapers> {
  NewsPaperModel? _selectedNewsPaper;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsPaperCubit, NewsPaperState>(
      buildWhen: (previous, current) {
        return (previous.isLoading || previous.isWaiting) &&
            !(current.isLoading || current.isWaiting);
      },
      builder: (context, state) {
        final cubit = context.read<NewsPaperCubit>();
        final newsPapers = state.newspapers;
        return Column(
          children: [
            Text('Journaux', style: TextStyle(fontSize: 20.sp)),
            heightSpace(20),
            SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: newsPapers
                        .map<Widget>(
                          (paper) => NewsPaper(
                            paper,
                            isSelected: (_selectedNewsPaper ??
                                    widget.initialNewsPaper) ==
                                paper,
                            onSelected: (paper) {
                              setState(
                                  () => _selectedNewsPaper = paper);
                              widget.onNewsPaperSelected(paper);
                            },
                            onEdit: (paper) async => await context
                                .dialogWith<UpdateNewsPaperDTO>(
                              child: _NewsPaperForm(paper),
                              onResult: (dto) =>
                                  cubit.updateNewsPaper(dto),
                            ),
                            onDelete: (paper) {
                              context.alertDialog(
                                title: 'Supprimer le journal',
                                content:
                                    'Voulez-vous vraiment supprimer ce journal?',
                                onOk: () =>
                                    cubit.deleteNewsPaper(paper),
                              );
                            },
                          ),
                        )
                        .toList()
                        .withUnique(
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: IconButton(
                              icon: const Icon(Icons.add,
                                  color: Colors.white),
                              onPressed: () async {
                                final dto = await showDialog<
                                    CreateNewsPaperDTO>(
                                  context: context,
                                  builder: (_) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: _NewsPaperForm(),
                                      ),
                                    ],
                                  ),
                                );

                                if (dto != null) {
                                  cubit.createNewsPaper(dto);
                                }
                              },
                            ),
                          ),
                        )),
              ],
            )),
          ],
        );
      },
    );
  }
}

class NewsPaper extends StatelessWidget {
  final NewsPaperModel newsPaper;
  final void Function(NewsPaperModel newsPaper)? onSelected;
  final void Function(NewsPaperModel newsPaper)? onEdit;
  final void Function(NewsPaperModel newsPaper)? onDelete;
  final bool isSelected;
  final bool withName;
  const NewsPaper(
    this.newsPaper, {
    super.key,
    this.onEdit,
    this.onDelete,
    this.isSelected = false,
    this.withName = true,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected?.call(newsPaper),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withAlpha(20)
              : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50.h,
              width: 55.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: NetworkImage(newsPaper.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (withName) ...[
              widthSpace(10),
              Text(newsPaper.name!,
                  style: TextStyle(fontSize: 14.spMax)),
            ],
            if (onEdit != null || onDelete != null)
              PopupMenuButton(itemBuilder: (_) {
                return [
                  if (onEdit != null)
                    PopupMenuItem(
                      onTap: () => onEdit!(newsPaper),
                      child: const Row(
                        children: [Icon(Icons.edit), Text('Edit')],
                      ),
                    ),
                  if (onDelete != null)
                    PopupMenuItem(
                        onTap: () => onDelete!(newsPaper),
                        child: const Row(
                          children: [
                            Icon(Icons.delete),
                            Text('Delete')
                          ],
                        )),
                ];
              }),
          ],
        ),
      ),
    );
  }
}
