import 'package:flutter/material.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_item_widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  static const String name = "/wish-list-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wish List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (ctx, index) =>
              const FittedBox(child: ProductItemWidget()),
        ),
      ),
    );
  }
}
