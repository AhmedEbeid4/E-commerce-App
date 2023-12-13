import 'package:e_commerce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_router.dart';
import '../../../widgets/product_item.dart';

class HomeListView extends StatelessWidget {
  const HomeListView(
      {super.key,
      required this.length,
      required this.getProduct,
      required this.index});

  final int length;
  final int index;
  final Product Function(int) getProduct;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 295,
      child: ListView.builder(
          itemCount: length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            final product = getProduct(index);
            final heroTag = '${this.index} product-${product.id}';
            return GestureDetector(
                onTap: () => Get.toNamed(RouteNames.showDetails,
                    arguments: {"product": product, 'tag': heroTag}),
                child: ProductItem(
                  product: product,
                  itemType: 0,
                  heroTag: heroTag,
                ));
          }),
    );
  }
}
