part of '../screen/tenders.screen.dart';

class _TenderFiltter extends StatelessWidget {
  const _TenderFiltter();

  @override
  Widget build(BuildContext context) {
    final filter = ListTendersDTO();
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 684.w,
        padding:
            EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            heightSpace(32),
            NamedDropDown<CategoryModel>(
              title: 'Category',
              itemsBuilder: (_) => [],
              onChanged: (item) => filter.copyWith(category: item),
            ),
            heightSpace(25),
            NamedDropDown(
              title: 'Region',
              itemsBuilder: (_) => NamedModel.willayas,
              onChanged: (item) => filter.copyWith(region: item.name),
            ),
            heightSpace(25),
            NamedDropDown<MarketTypeModel>(
              title: 'Type de marché',
              itemsBuilder: (_) => [],
              onChanged: (item) => filter.copyWith(marketType: item),
            ),
            heightSpace(40),
            AppCheckbox(
              title: 'Startup',
              onChanged: (value) => filter.copyWith(isStartup: value),
            ),
            heightSpace(20),
            Row(
              children: [
                Expanded(
                  child: AppDatePicker(
                    title: 'Date de publication',
                    onChanged: (date) =>
                        filter.copyWith(publishedAt: date),
                    firstDate: DateTime(2025, 1, 1),
                    lastDate: DateTime.now(),
                  ),
                ),
                widthSpace(20),
                Expanded(
                  child: AppDatePicker(
                    title: 'Date de clôture',
                    onChanged: (date) =>
                        filter.copyWith(deadline: date),
                  ),
                ),
              ],
            ),
            heightSpace(40),
            _buildButton(
              onTap: () {
                context.back(filter);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required VoidCallback onTap}) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
            vertical: 20.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Appliquer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.spMax,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Text _buildTitle() {
    return Text(
      'Filtres',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.spMax,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
