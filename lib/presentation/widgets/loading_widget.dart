import 'package:flutter/material.dart';
import 'package:task_project/presentation/widgets/shimmer_loading.dart';

class LoadingWidget extends StatelessWidget {
  final ShimmerType type;

  const LoadingWidget({super.key, this.type = ShimmerType.product});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      itemBuilder: (context, index) {
        switch (type) {
          case ShimmerType.product:
            return const ProductShimmerCard();
          case ShimmerType.post:
            return const PostShimmerCard();
        }
      },
    );
  }
}

enum ShimmerType { product, post }
