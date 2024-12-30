part of '../screen/tender.screen.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final dto =
        context.select((TenderCubit cubit) => cubit.state.tenderDTO);

    final cubit = context.read<TenderCubit>();

    void updateTender(TenderDTO dto) => cubit.updateTender(dto);

    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          children: [
            Text(
              'Informations de l\'appel d\'offre',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            AppTextFormField(
              title: 'Titre',
              hintText: 'Entrer le titre de l\'appel d\'offre',
              controller: dto.title,
              keyboardType: TextInputType.multiline,
              validator: (value) => value!.isNotEmpty
                  ? null
                  : 'Le titre est obligatoire',
            ),
            NamedDropDown<SubCategoryModel>(
                title: 'Catégorie',
                itemsBuilder: (context) => [],
                onChanged: (value) =>
                    updateTender(dto.copyWith(category: value))),
            NamedDropDown<MarketTypeModel>(
              title: 'Type de marché',
              itemsBuilder: (context) => [],
              onChanged: (value) =>
                  updateTender(dto.copyWith(marketType: value)),
            ),
            NamedDropDown<NamedModel>(
              title: 'Region',
              itemsBuilder: (context) => NamedModel.willayas,
              onChanged: (value) =>
                  updateTender(dto.copyWith(region: value)),
            ),
            Row(
              spacing: 25.w,
              children: [
                Expanded(
                  child: AppDatePicker(
                    title: 'Date de publication',
                    onChanged: (date) =>
                        updateTender(dto.copyWith(publishedAt: date)),
                    firstDate: DateTime(2025, 1, 1),
                    lastDate: DateTime.now(),
                  ),
                ),
                Expanded(
                  child: AppDatePicker(
                    title: 'Date de Echéance',
                    onChanged: (date) =>
                        updateTender(dto.copyWith(deadline: date)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025, 1, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
