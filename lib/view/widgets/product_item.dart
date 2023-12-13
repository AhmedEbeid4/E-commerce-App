import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/view/widgets/product_item_card.dart';
import 'package:e_commerce/view/widgets/product_item_square.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.product,
      required this.itemType,
      this.width,
      required this.heroTag});

  final Product product;
  final int itemType;
  final int? width;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    if (itemType == 0) {
      return ProductItemSquare(
        product: product,
        width: width,
        heroTag: heroTag,
      );
    }
    return ProductItemCard(
      product: product,
      heroTag: heroTag,
    );
  }
}
