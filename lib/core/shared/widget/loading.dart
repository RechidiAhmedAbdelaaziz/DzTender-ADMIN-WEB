import 'package:flutter/material.dart';
import 'package:tender/core/themes/colors.dart';

class LoadingStack extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingStack(
      {super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.2),
            child: const Center(
              child:
                  CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
      ],
    );
  }
}
