import 'package:elevate_flower_app/core/shared/widgets/custom_shimmer_grid.dart';
import 'package:elevate_flower_app/core/shared/widgets/vertical_shimmer_list.dart';
import 'package:flutter/widgets.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalShimmerList(
      height: .infinity,
      itemCount: 3,
      itemBuilder: (context, index) {
        return const CustomShimmerContainer(
          height: 100,
          width: double.infinity,
          borderRadius: 10,
        );
      },
    );
  }
}
