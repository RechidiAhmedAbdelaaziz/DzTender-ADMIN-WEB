import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender/core/shared/widget/add_button.dart';
import 'package:tender/core/shared/widget/filter_button.dart';
import 'package:tender/core/themes/spaces.dart';

import 'search_bar.dart';

class PageField<T> {
  final String title;
  final int flex;
  final Widget Function(T item) builder;

  const PageField({
    required this.title,
    required this.builder,
    this.flex = 1,
  });

  factory PageField.actions({
    required void Function(T item) onEdit,
    required void Function(T item) onDelete,
  }) =>
      PageField(
        title: '',
        builder: (item) => Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit(item),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onDelete(item),
            ),
          ],
        ),
        flex: 1,
      );
}

class ItemsPage<T> extends StatelessWidget {
  final List<PageField<T>> fields;
  final List<T> items;
  final void Function(String keys) onSearch;
  final VoidCallback onAdd;
  final VoidCallback onFilter;
  final void Function(T item) onEdit;
  final void Function(T item) onDelete;
  final bool isFiltered;
  final VoidCallback onClearFilter;

  ItemsPage({
    super.key,
    required List<PageField<T>> fields,
    required this.items,
    required this.onSearch,
    required this.onAdd,
    required this.onFilter,
    required this.onEdit,
    required this.onDelete,
    required this.isFiltered,
    required this.onClearFilter,
  }) : fields = [
          ...fields,
          PageField.actions(onEdit: onEdit, onDelete: onDelete),
        ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          heightSpace(100),
          Row(
            children: [
              FilterButton(
                onFilter: onFilter,
                isFiltered: isFiltered,
                onClearFilter: onClearFilter,
              ),
              widthSpace(10),
              SubmitButton(onSubmit: onAdd),
              const Spacer(),
              AppSearchField(onSearch),
            ],
          ),
          heightSpace(45),
          Row(
            children: [
              for (var field in fields)
                Expanded(
                  flex: field.flex,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        field.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.spMax,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.32,
                        ),
                      ),
                      heightSpace(35),
                      for (var item in items) ...[
                        field.builder(item),
                        heightSpace(10),
                      ]
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
