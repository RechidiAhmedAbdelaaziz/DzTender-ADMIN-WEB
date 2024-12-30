import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/extensions/navigator.extension.dart';
import 'package:tender/core/shared/models/named.model.dart';
import 'package:tender/core/shared/widget/checkbox.dart';
import 'package:tender/core/shared/widget/named_dropdown.dart';
import 'package:tender/core/shared/widget/page_builder.dart';
import 'package:tender/core/shared/widget/time_picker.dart';
import 'package:tender/core/themes/colors.dart';
import 'package:tender/core/themes/spaces.dart';
import 'package:tender/features/category/data/models/category.model.dart';
import 'package:tender/features/markettype/data/models/market_type.model.dart';
import 'package:tender/features/tender/configs/tender.navigator.dart';
import 'package:tender/features/tender/data/dto/list_tenders.dto.dart';
import 'package:tender/features/tender/data/models/tender.model.dart';
import 'package:tender/features/tender/modules/tenders/logic/tenders.cubit.dart';

part '../widgets/filters.dart';
part '../widgets/tender_title.dart';

class TendersScreen extends StatelessWidget {
  static const String route = '/tenders';
  TendersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TendersCubit>();
    final tenders = cubit.state.tenders;
    return ItemsPage(
      fields: fields,
      items: tenders,
      onSearch: cubit.search,
      onAdd: () => context.to(TenderNavigator.createTender()),
      onFilter: () async {
        final newFilter = await showDialog<ListTendersDTO>(
          context: context,
          builder: (context) {
            return const Stack(
              alignment: Alignment.center,
              children: [_TenderFiltter()],
            );
          },
        );
        if (newFilter != null) cubit.filter(newFilter);
      },
      onEdit: (tender) =>
          context.to(TenderNavigator.updateTender(tender.id!)),
      onDelete: (tender) {},
      isFiltered: cubit.dto.isFiltered,
      onClearFilter: () => cubit.filter(ListTendersDTO()),
    );
  }

  final List<PageField<TenderModel>> fields = [
    PageField(
      title: 'Titre',
      flex: 4,
      builder: (item) => _TenderTitle(item),
    ),
    PageField(
      title: 'Region',
      flex: 2,
      builder: (item) => Text(
        item.region!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.spMax,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    PageField(
      title: 'Catégorie',
      flex: 2,
      builder: (item) => Text(
        item.category!.name!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.spMax,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    PageField(
      title: 'Échéance',
      flex: 2,
      builder: (item) => Text(
        item.deadline!.toString(),
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.spMax,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    PageField(
      title: 'Type de marché',
      flex: 2,
      builder: (item) => Text(
        item.marketType!.name!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14.spMax,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ];
}
