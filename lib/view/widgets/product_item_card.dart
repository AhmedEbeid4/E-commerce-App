import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../model/product.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({super.key, required this.product, required this.heroTag});

  final Product product;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final name = product.name.length <= 26
        ? product.name
        : '${product.name.substring(0, 23)}...';
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(229, 229, 229, 0.2),
          borderRadius: BorderRadius.circular(20)),
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: heroTag,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 100,
              width: 70,
              child: FadeInImage(
                fit: BoxFit.fitWidth,
                placeholder:
                    const AssetImage("assets/images/post_placeholder.png"),
                image: CachedNetworkImageProvider(product.imageUrl),
              ),
            ),
          ),
          8.wi,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16)),
                Text('${product.price} EGP',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.find<UserController>().updateFavourites(product);
                  },
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: GetBuilder<UserController>(
                        id: 'like ${product.id}',
                        builder: (controller) {
                          if (product.isBeingLiked) {
                            return CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).primaryColor,
                            );
                          }
                          return controller.hasLiked('${product.id}')
                              ? const Icon(
                                  Icons.favorite,
                                  size: 18,
                                  color: Color.fromRGBO(140, 140, 140, 1.0),
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  size: 18,
                                  color: Color.fromRGBO(140, 140, 140, 1.0),
                                );
                        }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*
FadeInImage(
              fit: BoxFit.fitWidth,
              placeholder: const AssetImage("assets/images/post_placeholder.png")),
              image: CachedNetworkImageProvider(product.imageUrl),
            ),

            FadeInImage(
                fit: BoxFit.fitWidth,
                placeholder: const AssetImage('post_placeholder.png'),
                image: NetworkImage(product.imageUrl),
              )
 */
