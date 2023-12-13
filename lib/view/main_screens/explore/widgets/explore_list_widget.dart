import 'package:e_commerce/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/product.dart';
import '../../../routes/app_router.dart';
import '../../../widgets/product_item.dart';

class ExploreListWidget extends StatelessWidget {
  const ExploreListWidget({super.key, required this.controller, required this.products, });
  final List<Product> products;
  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          final product = controller.getItemById(products[index].id.toString())!;
          final tag = '3 product-${product.id}';
          return GestureDetector(
              onTap: () =>
                  Get.toNamed(RouteNames.showDetails,
                      arguments: {"product": product, 'tag': tag}),
              child: ProductItem(product: product, itemType: 1, heroTag: tag));
        });
  }
}
