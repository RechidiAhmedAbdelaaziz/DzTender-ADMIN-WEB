import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tender/core/extensions/dialog.extension.dart';
import 'package:tender/core/extensions/list.extension.dart';
import 'package:tender/core/extensions/navigator.extension.dart';
import 'package:tender/core/shared/dto/image.dto.dart';
import 'package:tender/core/shared/dto/sources.dto.dart';
import 'package:tender/core/shared/models/named.model.dart';
import 'package:tender/core/shared/widget/add_button.dart';
import 'package:tender/core/shared/widget/form_builder.dart';
import 'package:tender/core/shared/widget/image_field.dart';
import 'package:tender/core/shared/widget/loading.dart';
import 'package:tender/core/shared/widget/multi_image_field.dart';
import 'package:tender/core/shared/widget/named_dropdown.dart';
import 'package:tender/core/shared/widget/textform_field.dart';
import 'package:tender/core/shared/widget/time_picker.dart';
import 'package:tender/core/themes/icons.dart';
import 'package:tender/core/themes/spaces.dart';
import 'package:tender/features/category/data/models/sub_category.model.dart';
import 'package:tender/features/markettype/data/models/market_type.model.dart';
import 'package:tender/features/newspaper/data/models/news_paper.model.dart';
import 'package:tender/features/newspaper/logic/newspaper.cubit.dart';
import 'package:tender/features/newspaper/ui/news_papers.dart';
import 'package:tender/features/newspaper/ui/source.dart';
import 'package:tender/features/tender/data/dto/tender.dto.dart';
import 'package:tender/features/tender/modules/tender/logic/tender.cubit.dart';

part '../widget/form.dart';
part '../widget/attachment.dart';
part '../widget/add_docs.dart';

class TenderScreen extends StatelessWidget {
  static const createTender = '/tenders/create';
  static const updateTender = '/tenders/update/:id';

  const TenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingStack(
      isLoading: context
          .select((TenderCubit cubit) => cubit.state.isLoading),
      child: FormBuilder(
        title: 'Tender',
        onSaved: () => context.read<TenderCubit>().saveTender(),
        isUpdating: context
            .select((TenderCubit cubit) => cubit.state.isUpdating),
        form: const _Form(),
        attachment: const _Attachment(),
      ),
    );
  }
}
