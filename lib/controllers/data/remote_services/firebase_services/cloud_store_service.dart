import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/user.dart';

class CloudStoreService {
  FirebaseFirestore cloudStore;

  CloudStoreService(this.cloudStore);

  Future addUser(UserModel user) async {
    final userRef = cloudStore.collection('users');
    await userRef.doc(user.id!).set(user.toJson());
  }

  Future<UserModel?> getUser(String id) async {
    final userRef = cloudStore.collection('users');
    final res = await userRef.doc(id).get();
    final resJson = res.data() as Map<String, dynamic>;
    return UserModel.fromJson(resJson);
  }

  Future updateUser(Map<String,dynamic> userMap, String userId) async {
    final usersRef = cloudStore.collection('users');
    DocumentReference userRef = usersRef.doc(userId);
    await userRef
        .update(userMap)
        .timeout(const Duration(seconds: 5));
  }

  Future deleteUser(String userId) async {
    final userRef = cloudStore.collection('users');
    DocumentReference userRe = userRef.doc(userId);
    await userRe.delete().timeout(const Duration(seconds: 5));
  }

  Future updateFavourites(List<String> favourites, String userId) async {
    final userRef = cloudStore.collection('users');
    DocumentReference favouritesRef = userRef.doc(userId);
    await favouritesRef
        .update({'favourites': favourites}).timeout(const Duration(seconds: 5));
  }

  Future updateOrders(List<Map<String, dynamic>> orders, String userId) async {
    final userRef = cloudStore.collection('users');
    DocumentReference favouritesRef = userRef.doc(userId);
    await favouritesRef
        .update({'orders': orders}).timeout(const Duration(seconds: 5));
  }

  Future checkOut(
      List<Map<String, dynamic>> completedOrders, String userId) async {
    final userRef = cloudStore.collection('users');
    DocumentReference favouritesRef = userRef.doc(userId);
    await favouritesRef
        .update({'orders': [], 'completed_orders': completedOrders}).timeout(
            const Duration(seconds: 5));
  }

/*
  Future checkOut(
      List<Map<String, dynamic>> completedOrders, String userId) async {
    final userRef = cloudStore.collection('users');
    DocumentReference favouritesRef = userRef.doc(userId);
    await favouritesRef
        .update({'orders': [], 'completed_orders': completedOrders}).timeout(
            const Duration(seconds: 5));
  }

 */
}
