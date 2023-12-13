import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/model/order.dart';
import 'package:e_commerce/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product, required this.order, required this.onDelete, required this.onQuantityChange});

  final Product product;
  final CartOrder order;
  final VoidCallback onDelete;
  final Function(int) onQuantityChange;
  @override
  Widget build(BuildContext context) {
    final name = product.name.length <= 18
        ? product.name
        : '${product.name.substring(0, 17)}..';
    final primaryColor = Theme.of(context).primaryColor;
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
                GetBuilder<UserController>(
                    id: 'cart price ${product.id}',
                    builder: (controller) {
                      return Text('${product.price * order.quantity} EGP',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold));
                    })
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
                GestureDetector(
                  onTap: onDelete,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: GetBuilder<UserController>(
                      id: 'cart delete ${product.id}',
                      builder: (controller) {
                        if (order.isBeingDeleted) {
                          return CircularProgressIndicator(
                            strokeWidth: 2,
                            color: primaryColor,
                          );
                        }
                        return const Icon(Icons.close);
                      },
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){onQuantityChange(-1);},
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: Icon(
                            Icons.remove,
                            color: Color.fromRGBO(140, 140, 140, 1.0),
                          ),
                        ),
                      ),
                      8.wi,
                      GetBuilder<UserController>(
                          id: 'cart quantity ${product.id}',
                          builder: (controller) {
                            if (order.isBeingUpdated) {
                              return SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: primaryColor,
                                ),
                              );
                            }
                            return Text(order.quantity.toString());
                          }),
                      8.wi,
                      GestureDetector(
                        onTap: (){onQuantityChange(1);},
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: Icon(
                            Icons.add,
                            color: Color.fromRGBO(140, 140, 140, 1.0),
                          ),
                        ),
                      )
                    ],
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
