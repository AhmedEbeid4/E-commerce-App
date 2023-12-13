import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/view/main_screens/profile/shopping_history/widgets/shopping_history_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingHistory extends StatelessWidget {
  ShoppingHistory({super.key});

  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: _userController.user!.completedOrders == null ||
                _userController.user!.completedOrders!.isEmpty
            ? const Center(
                child: Text(
                  'There is no items',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _userController.user!.completedOrders!.length,
                itemBuilder: (ctx, index) {
                  final order = _userController.user!.completedOrders![index];
                  // return ShoppingHistoryItem(product: product, order: order);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.he,
                      Text(
                        'Order\'s Date : ${order.date}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      10.he,
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.orders.length,
                          itemBuilder: (ctx, i) {
                            return ShoppingHistoryItem(
                                product: order.orders[i].product!,
                                order: order.orders[i]);
                          }),
                    ],
                  );
                }),
      ),
    );
  }
}
