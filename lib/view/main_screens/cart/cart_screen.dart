import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/view/widgets/cart_item.dart';
import 'package:e_commerce/view/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  CartView({super.key});

  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            10.he,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
            10.he,
            Expanded(
                child: GetBuilder<UserController>(
              id: 'cart list',
              builder: (controller) {
                if (controller.hasNoOrders()) {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have\'nt added anything to the cart',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      )
                    ],
                  );
                }
                return ListView.builder(
                    itemCount: controller.user!.orders!.length,
                    itemBuilder: (ctx, index) {
                      final order = controller.user!.orders![index];
                      final product =
                          _productController.getItemById("${order.productId}");
                      if (product == null) {
                        return const SizedBox();
                      }
                      return CartItem(
                        product: product,
                        order: order,
                        onDelete: () {
                          controller.removeOrderFromCart(order);
                        },
                        onQuantityChange: (value) {
                          controller.updateQuantity(order, value);
                        },
                      );
                    });
              },
            )),
            10.he,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                GetBuilder<UserController>(
                    id: 'total',
                    builder: (controller) {
                      final total = controller.getTotal(
                          (id) => _productController.getItemById("$id"));
                      return Text('$total EGP',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor));
                    })
              ],
            ),
            10.he,
            Row(
              children: [
                Expanded(
                    child: GetBuilder<UserController>(
                  id: 'checkout',
                  builder: (controller) {
                    return RoundedButton(
                      text: 'Checkout',
                      onClick: () {
                        controller.checkOut2((id) =>
                            _productController.getItemById(id.toString())!);
                      },
                      visible: !controller.isBuying,
                    );
                  },
                ))
              ],
            ),
            10.he,
          ],
        ),
      ),
    ));
  }
}
