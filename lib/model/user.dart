import 'package:e_commerce/model/order.dart';
import 'package:e_commerce/model/product.dart';

import 'completed_order.dart';

class UserModel {
  String? id;
  String firstName;
  String lastName;
  String email;
  String? imageUrl;
  int age;
  int height;
  int weight;
  String gender;
  Set<String>? favourites;
  List<CartOrder>? orders;
  List<CompletedOrder>? completedOrders;

  String getFavouriteIdByIndex(int index) {
    return favourites!.toList()[index];
  }

  List<String> getFavAsList() {
    return favourites!.toList();
  }

  UserModel(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.imageUrl,
      required this.age,
      required this.height,
      required this.weight,
      required this.gender,
      this.favourites,
      this.orders,
      this.completedOrders});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<String>? fav;
    List<CartOrder>? orders;
    List<CompletedOrder>? completedOrder;
    if (json['favourites'] != null) {
      fav = [];
      for (var e in (json['favourites'] as List)) {
        fav.add('$e');
      }
    }
    if (json['orders'] != null) {
      orders = [];
      for (var e in (json['orders'] as List)) {
        final order = CartOrder.fromJson(e);

        orders.add(order);
      }
    }
    if (json['completed_orders'] != null) {
      completedOrder = [];
      for (var e in (json['completed_orders'] as List)) {
        final order = CompletedOrder.fromJson(e);

        completedOrder.add(order);
      }
    }

    print('USER_MODEL : ${json['favourites']} ===> $fav');
    print('USER_MODEL :  $completedOrder ===> ${json['completed_orders']}');
    return UserModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        imageUrl: json['image_url'],
        age: json['age'],
        height: json['height'],
        weight: json['weight'],
        gender: json['gender'],
        favourites: fav != null ? fav.toSet() : {},
        orders: orders ?? [],
        completedOrders: completedOrder);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender
    };
    if (imageUrl != null) {
      map['image_url'] = imageUrl;
    }
    if (favourites != null && favourites!.isNotEmpty) {
      map['favourites'] = favourites!.toList();
    }
    if (orders != null && orders!.isNotEmpty) {
      map['orders'] = getJsonOfOrders(orders!);
    }
    if (completedOrders != null && completedOrders!.isNotEmpty) {
      map['completed_orders'] = getJsonOfCompletedOrders(completedOrders!);
    }
    return map;
  }

  List<Map<String, dynamic>> getJsonOfOrders(List<CartOrder> orders) {
    List<Map<String, dynamic>> list = [];
    for (var element in orders) {
      list.add(element.toJson());
    }
    return list;
  }

  List<Map<String, dynamic>> getJsonOfCompletedOrders(
      List<CompletedOrder> orders) {
    List<Map<String, dynamic>> list = [];
    for (var element in orders) {
      list.add(element.toJson());
    }
    return list;
  }

  List<CartOrder> copyOrder() {
    List<CartOrder> copiedOrders = [];
    if (orders == null || orders!.isEmpty) {
      return copiedOrders;
    }
    for (var element in orders!) {
      copiedOrders.add(
          CartOrder(productId: element.productId, quantity: element.quantity));
    }
    return copiedOrders;
  }

  List<CartOrder> updateOrder(int productId, int newQuantity) {
    List<CartOrder> copiedOrders = [];
    if (orders == null || orders!.isEmpty) {
      return copiedOrders;
    }
    for (var element in orders!) {
      if (element.productId == productId) {
        copiedOrders.add(
            CartOrder(productId: element.productId, quantity: newQuantity));
        continue;
      }
      copiedOrders.add(
          CartOrder(productId: element.productId, quantity: element.quantity));
    }
    return copiedOrders;
  }

  List<CartOrder> removeOrder(int productId) {
    List<CartOrder> copiedOrders = [];
    if (orders == null || orders!.isEmpty) {
      return copiedOrders;
    }
    for (var element in orders!) {
      if (element.productId == productId) {
        continue;
      }
      copiedOrders.add(
          CartOrder(productId: element.productId, quantity: element.quantity));
    }
    return copiedOrders;
  }

  void addOrder(int productId) {
    orders ??= [];
    orders!.add(CartOrder(productId: productId));
  }

  bool hasOrdered(int productId) {
    if (orders == null || orders!.isEmpty) {
      return false;
    }
    for (var element in orders!) {
      if (element.productId == productId) {
        return true;
      }
    }
    return false;
  }

  List<Map<String, dynamic>> ordersJson() {
    if (orders == null || orders!.isEmpty) {
      return [];
    }
    List<Map<String, dynamic>> list = [];
    for (var element in orders!) {
      list.add(element.toJson());
    }
    return list;
  }

  List<CompletedOrder> getCompletedOrders(
      String date, Product Function(int id) getProduct) {
    final List<CompletedOrder> list = [];
    final List<CartOrder> ordersList = [];

    if (completedOrders != null && completedOrders!.isNotEmpty) {
      list.addAll(completedOrders!);
    }
    for (var element in orders!) {
      ordersList.add(CartOrder(
          product: getProduct(element.productId!), quantity: element.quantity));
    }
    list.add(CompletedOrder(date: date, orders: ordersList));
    return list;
  }
}
