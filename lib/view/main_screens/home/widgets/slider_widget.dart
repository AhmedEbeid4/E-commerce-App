import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/view/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_router.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {super.key, required this.getProduct, required this.width});

  final Product Function() getProduct;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(
          height: 300.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        itemCount: 7,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          final product = getProduct();
          final heroTag = '0 product-${product.id}';
          return GestureDetector(
            onTap: () =>
                Get.toNamed(RouteNames.showDetails, arguments: {"product":product,'tag':heroTag}),
            child: ProductItem(
                heroTag: heroTag,
                product: product, itemType: 0, width: width.toInt()),
          );
        });
  }
}
