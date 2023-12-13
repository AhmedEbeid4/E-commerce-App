import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/view/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_router.dart';

class WishListView extends StatelessWidget {
  WishListView({super.key});

  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<UserController>(
      id: 'wishlist',
      builder: (controller) {
        final fav = controller.getFavAsList();
        if (controller.user!.favourites!.isEmpty) {
          return const Center(
            child: Text(
              'There is no favourite items',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          );
        }
        return ListView.builder(
            itemCount: fav.length + 1,
            itemBuilder: (ctx, index) {
              if (index == fav.length) {
                return const SizedBox(
                  height: 20,
                );
              }

              final product = _productController.getItemById(fav[index]);

              if (product == null) {
                return const SizedBox();
              }
              final tag = '4 product-${product.id}';
              return Container(
                  margin: const EdgeInsets.all(3),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(RouteNames.showDetails,
                        arguments: {"product": product, 'tag': tag}),
                    child: ProductItem(
                      product: product,
                      itemType: 1,
                      heroTag: tag,
                    ),
                  ));
            });
      },
    ));
  }
}
