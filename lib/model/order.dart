import 'package:e_commerce/model/product.dart';

class CartOrder {

  int? productId;
  int quantity;
  Product? product;

  bool isBeingUpdated = false;
  bool isBeingDeleted = false;
  String? date;

  CartOrder({this.productId,this.product ,this.quantity = 1, this.date});

  factory CartOrder.fromJson(Map<String, dynamic> data) {
    Product? product;
    if(data['product'] != null){
      product = Product.fromJson(data['product']);
    }
    return CartOrder(productId: data['product_id'],product: product ,quantity: data['quantity'], date: data['date']);
  }

  Map<String, dynamic> toJson() {
    if(product != null){
      final Map<String, dynamic> map = {'product' : product!.toJson(), 'quantity': quantity};
      return map;
    }
    final Map<String, dynamic> map = {'product_id': productId, 'quantity': quantity};
    if(date != null){
      map['date'] = date;
    }
    return map;
  }

}
