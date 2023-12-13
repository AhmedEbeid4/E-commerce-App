import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItemSquare extends StatelessWidget {
  final Product product;

  const ProductItemSquare({super.key, required this.product, this.width, required this.heroTag});
  final String heroTag;
  final int? width;

  @override
  Widget build(BuildContext context) {
    final name = product.name.length <= 25
        ? product.name
        : '${product.name.substring(0, 24)}...';

    return Stack(
      children: [
        Container(
          width: width == null ? 220 : 240,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(229, 229, 229, 0.3),
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Hero(
                tag: heroTag,
                child: SizedBox(
                    height: 200,
                    child: FadeInImage(
                      fit: BoxFit.fitWidth,
                      placeholder:
                          const AssetImage("assets/images/post_placeholder.png"),
                      image: CachedNetworkImageProvider(product.imageUrl),
                    )),
              ),
              15.he,
              Container(
                height: 70,
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(140, 140, 140, 1.0)),
                    ),
                    Text('${product.price} EGP',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: width == null
              ? const EdgeInsets.only(top: 4)
              : const EdgeInsets.only(top: 5, right: 12),
          width: width == null ? 220 : 240,
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Get.find<UserController>().updateFavourites(product);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
