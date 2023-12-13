import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/model/order.dart';
import 'package:e_commerce/model/product.dart';
import 'package:flutter/material.dart';

class ShoppingHistoryItem extends StatelessWidget {
  const ShoppingHistoryItem(
      {super.key, required this.product, required this.order});

  final Product product;
  final CartOrder order;

  @override
  Widget build(BuildContext context) {
    final name = product.name.length <= 18
        ? product.name
        : '${product.name.substring(0, 17)}..';
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(229, 229, 229, 0.2),
          borderRadius: BorderRadius.circular(20)),
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
          8.wi,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16)),
                Text('${product.price * order.quantity} EGP',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      8.wi,
                      Text(order.quantity.toString()),
                      8.wi,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
