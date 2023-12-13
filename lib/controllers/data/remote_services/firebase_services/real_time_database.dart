import 'package:firebase_database/firebase_database.dart';

import '../../../../model/product.dart';

class RealTimeDatabase {
  DatabaseReference? databaseReference;

  RealTimeDatabase(FirebaseDatabase firebaseDatabase) {
    databaseReference = firebaseDatabase.ref().child('products');
  }

  Future<Map<int, Product>> getItemsForFirstTime() async {
    DataSnapshot dataSnapshot = await databaseReference!.get();
    final Map<int, Product> products = {};
    if (dataSnapshot.value != null) {
      final productsJson = dataSnapshot.value as List<dynamic>;
      for (dynamic productJson in productsJson) {

        if(productJson == null){
          continue;
        }
        final product = Product.fromJson(productJson);
        products[product.id] = product;
      }
    }
    return products;
  }

  void listenToProducts(Function(Map<int, Product>) onChange) {
    databaseReference!.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final Map<int, Product> products = {};
        final productsJson = event.snapshot.value as List<dynamic>;
        for (dynamic productJson in productsJson) {
          if(productJson == null){
            continue;
          }
          final product = Product.fromJson(productJson);
          products[product.id] = product;
        }
        onChange(products);
      }
    });
  }
}
