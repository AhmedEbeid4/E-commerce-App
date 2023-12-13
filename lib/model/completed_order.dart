import 'order.dart';

class CompletedOrder {
  String date;
  List<CartOrder> orders;

  CompletedOrder({required this.date, required this.orders});

  factory CompletedOrder.fromJson(Map<String, dynamic> data) {
    final List<CartOrder> ordersList = [];
    final ordersJson = data['orders'] as List<dynamic>;
    for (var element in ordersJson) {
      final elementMap = element as Map<String, dynamic>;
      ordersList.add(CartOrder.fromJson(elementMap));
    }
    return CompletedOrder(date: data['date'], orders: ordersList);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson = [];
    for (var ele in orders) {
      productsJson.add(ele.toJson());
    }
    final Map<String, dynamic> map = {'date': date, 'orders': productsJson};
    return map;
  }
}
