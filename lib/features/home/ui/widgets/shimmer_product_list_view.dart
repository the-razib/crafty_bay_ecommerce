import 'package:flutter/material.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_item_widget.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductListView extends StatelessWidget {
  const ShimmerProductListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ProductItemWidget()),
          Expanded(child: ProductItemWidget()),
          Expanded(child: ProductItemWidget()),
        ],
      ),
    );
  }
}
