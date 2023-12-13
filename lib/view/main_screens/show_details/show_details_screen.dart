import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/core/toast.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/view/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowDetailsScreen extends StatelessWidget {
  ShowDetailsScreen({super.key});

  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final Product product = args['product'];
    final tag = args['tag'];
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.he,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: tag,
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: FadeInImage(
                        placeholder: const AssetImage(
                            "assets/images/post_placeholder.png"),
                        image: CachedNetworkImageProvider(product.imageUrl),
                      ),
                    ),
                  ),
                ],
              ),
              15.he,
              Text(
                product.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              10.he,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${product.price} EGP',
                    style: const TextStyle(fontSize: 18),
                  ),
                  GetBuilder<UserController>(
                      id: 'show details',
                      builder: (controller) {
                        return Text(
                          _productController.exist(product.id)
                              ? 'Available in stock'
                              : 'Out of stock',
                          style: TextStyle(
                              fontSize: 14,
                              color: _productController.exist(product.id)
                                  ? Theme.of(context).primaryColor
                                  : Colors.red),
                        );
                      })
                ],
              ),
              10.he,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Weight',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${product.weightText} KG',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  )
                ],
              ),
              10.he,
              const Text(
                'About',
                style: TextStyle(fontSize: 18),
              ),
              8.he,
              Text(
                product.desc,
                style: const TextStyle(fontSize: 13),
              ),
              15.he,
              Row(
                children: [
                  Expanded(
                      child: GetBuilder<UserController>(
                    id: 'cart button',
                    builder: (controller) {
                      final hasOrdered = controller.hasOrder(product);
                      return RoundedButton(
                        text: hasOrdered ? 'Remove From Cart' : 'Add to Cart',
                        onClick: () {
                          if (!_productController.exist(product.id)) {
                            showToast('The product is out of the stock');
                            return;
                          }
                          if (hasOrdered) {
                            controller.removeFromCart(product);
                          } else {
                            controller.addToCart(product);
                          }
                        },
                        visible: !controller.isAddingToCart,
                      );
                    },
                  )),
                ],
              ),
              10.he
            ],
          ),
        ),
      )),
    );
  }
}
