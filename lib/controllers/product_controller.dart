import 'dart:math';
import 'package:e_commerce/controllers/data/repository.dart';
import 'package:e_commerce/core/toast.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/model/user.dart';
import 'package:get/get.dart';

import '../view/routes/app_router.dart';

class ProductController extends GetxController {
  Repository repository;

  ProductController(this.repository);

  Map<int, Product>? productsMap;
  List<Product>? productsList;
  List<Product>? recommendations;

  int? weight;
  String? gender;
  String _searchText = "";
  set searchText(String value){
    _searchText = value.trim().toLowerCase();
    update(['explore']);
  }

  Future<List<Product>?> getSearchItems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if(productsList == null || productsList!.isEmpty){
      return null;
    }
    if(_searchText.isEmpty){
      return productsList;
    }
    final List<Product> list = [];
    for(var elements in productsList!){
      if(elements.name.toLowerCase().contains(_searchText)){
        list.add(elements);
      }
    }
    return list;
  }

  Future<bool> getProducts({Function? updateFav}) async {
    bool hasFetched = true;
    final res = await repository.getProducts((map) {
      print('IN_CONTROLLER : $map');
      productsMap = map;
      productsList = [];

      for (var element in productsMap!.values) {
        print('index : ${element.id - 1}');
        productsList!.add(element);
      }

      update(['more', 'explore']);
      if (updateFav != null) {
        updateFav();
      }
      getRecommendations();
    });
    res.fold((l) {
      hasFetched = false;
      showToast(l.message);
    }, (map) {
      print('IN_CONTROLLER : $map');
      productsMap = map;
      productsList = [];
      for (var element in productsMap!.values) {
        print('index : ${element.id - 1}');
        productsList!.add(element);
      }

    });

    return hasFetched;
  }

  Future getRecommendations({UserModel? user}) async {
    recommendations = [];
    if (weight == null && gender == null && user != null) {
      weight = user.weight;
      gender = user.gender;
    } else if (weight == null || productsList == null) {
      return;
    }
    print('IN_RECOMMENDATION:');
    print('USER_WEIGHT: $weight');
    for (var element in productsList!) {
      if (element.gender == gender &&
          ((weight! > 90 && element.minWeight == 90) ||
              element.minWeight <= weight! && weight! <= element.maxWeight!)) {
        print('IN_RECOMMENDATION:}');
        print('ITEM_MIN_WEIGHT: ${element.minWeight}');
        print('BOOLEAN: ${(weight! > 90 && element.minWeight == 90)}');
        print(
            'ALL BOOLEAN: ${((weight! > 90 && element.minWeight == 90) || element.minWeight <= weight! && weight! <= element.maxWeight!)}');
        recommendations!.add(element);
      }
    }
    print('RECOMMENDATIONS LENGTH : ${recommendations!.length}');
    update(['recommend']);
  }

  bool exist(int id) {
    return productsMap!.containsKey(id);
  }

  Product getItemByIndex(int index) {
    return productsList![index];
  }

  Product? getItemById(String id) {
    return productsMap![int.parse(id)];
  }

  Product getRecommendationByIndex(int index) {
    return recommendations![index];
  }

  Product? getRandomElement() {
    if(productsList == null){
      Get.offNamed(RouteNames.login);
      return null;
    }
    Product product = productsList![Random().nextInt(productsList!.length)];
    while (product.gender == 'female') {
      product = productsList![Random().nextInt(productsList!.length)];
    }
    return product;
  }
}
