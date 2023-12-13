import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/model/completed_order.dart';
import 'package:e_commerce/model/product.dart';
import 'package:e_commerce/model/user.dart';
import 'package:e_commerce/model/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'remote_services/remote_services.dart';
import '../../core/exceptions.dart';

class Repository {
  RemoteServices remoteServices;

  Repository(this.remoteServices);

  Future<Either<Failure, void>> signUp(
      UserModel user, String password, String? imagePath) async {
    try {
      final id = await remoteServices.authService.signUp(user.email, password);

      String? imageUrl;
      if (imagePath != null) {
        imageUrl = await remoteServices.storageService
            .uploadImage(imagePath, 'profile_pictures', id!);
      }
      user.id = id;
      user.imageUrl = imageUrl;
      print('USER_ID : ${user.id}, USER_IMAGE : ${user.imageUrl}');
      print('USER_b: in add user function');
      await remoteServices.cloudStoreService.addUser(user);
      return right(null);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final id = await remoteServices.authService.signIn(email, password);
      UserModel? user = await remoteServices.cloudStoreService.getUser(id!);
      if (user == null) {
        return left(getFailure('Something went wrong'));
      }
      user.id = id;
      return right(user);
    } catch (e) {
      if (e is NotVerifiedException) {
        await remoteServices.authService.logout();
      }
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, void>> forgetPassword(String email) async {
    try {
      await remoteServices.authService.resetPassword(email);
      return right(null);
    } catch (e) {
      print('Firebase_Exception IN_FORGET_PASSWORD_LOGIC: $e');
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, UserModel>> getUser(String id) async {
    try {
      final user = await remoteServices.cloudStoreService.getUser(id);
      print('USER_DATA : ${user.toString()}');
      return right(user!);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, UserModel>> updateUser(
      UserModel user, String? imagePath) async {
    try {
      if (imagePath != null && user.imageUrl == null) {
        final imageUrl = await remoteServices.storageService
            .uploadImage(imagePath, 'profile_pictures', user.id!);
        user.imageUrl = imageUrl;
      } else if (imagePath != null && user.imageUrl != null) {
        await remoteServices.storageService.uploadImageWithOutGettingURL(
            imagePath, 'profile_pictures', user.id!);
      }
      print('USER_ID : ${user.id}');
      await remoteServices.cloudStoreService
          .updateUser(user.toJson(), user.id!);
      return right(user);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      await remoteServices.authService.logout();
      return right(null);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, void>> deleteAccount(UserModel user) async {
    try {
      await remoteServices.authService.deleteAccount();
      if (user.imageUrl != null) {
        await remoteServices.storageService
            .deleteImage('profile_pictures', user.id!);
      }
      await remoteServices.cloudStoreService.deleteUser(user.id!);
      return right(null);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  bool hasLoggedIn() {
    return remoteServices.authService.firebaseAuth.currentUser != null;
  }

  String? getUserId() {
    if (remoteServices.authService.firebaseAuth.currentUser == null) {
      return null;
    }
    return remoteServices.authService.firebaseAuth.currentUser!.uid;
  }

  Future<Either<Failure, Map<int, Product>>> getProducts(
      Function(Map<int, Product>) onChange) async {
    try {
      final res = await remoteServices.realTimeDatabase.getItemsForFirstTime();
      remoteServices.realTimeDatabase.listenToProducts(onChange);
      return right(res);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, List<String>>> updateFavourites(
      List<String> list, String userId) async {
    try {
      await remoteServices.cloudStoreService.updateFavourites(list, userId);
      return right(list);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, void>> updateOrders(
      List<CartOrder> list, String userId) async {
    try {
      List<Map<String, dynamic>> ordersJson = [];
      for (var element in list) {
        ordersJson.add(element.toJson());
      }
      await remoteServices.cloudStoreService.updateOrders(ordersJson, userId);
      return right(null);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future<Either<Failure, void>> checkOut(List<CompletedOrder> completedOrders,String userId) async {
    try {
      List<Map<String,dynamic>> list = [];
      for(var ele in completedOrders){
        list.add(ele.toJson());
      }
      await remoteServices.cloudStoreService.checkOut(list, userId);
      return right(null);
    } catch (e) {
      return left(getFailure(e));
    }
  }


/*
  Future<Either<Failure, void>> checkOut(List<CartOrder> completedOrders,String userId) async {
    try {
      List<Map<String,dynamic>> list = [];
      for(var ele in completedOrders){
        list.add(ele.toJson());
      }
      await remoteServices.cloudStoreService.checkOut(list, userId);
      return right(null);
    } catch (e) {
      return left(getFailure(e));
    }
  }

 */




  Future<Either<Failure, void>> changePassword(
      UserModel user, String oldPassword, String newPassword) async {
    try {
      await remoteServices.authService
          .changePassword(user.email, oldPassword, newPassword);
      return right(null);
    } catch (e) {
      return left(getFailure(e));
    }
  }

  Future observeAuthState(Function(User?) onChange) async {
    remoteServices.authService.observeAuthState((user) => onChange(user));
  }

  Failure getFailure(Object e) {
    if (e is NotVerifiedException) {
      return AuthFailure.fromNotVerifiedException();
    } else if (e is FirebaseAuthException) {
      return AuthFailure.fromFirebaseAuthException(e);
    } else if (e is BadResponseException) {
      return ServerFailure.fromHttpException(e);
    } else if (e is SocketException) {
      return ServerFailure.fromSocketException();
    } else if (e is TimeoutException) {
      return ServerFailure.fromSocketException();
    }
    print('NEW_EXCEPTION \nTYPE: ${e.runtimeType}');
    if(e is TypeError){
      print('NEW_EXCEPTION \nMessage: ${e.toString()}');
    }
    if (e is FirebaseException) {
      print('NEW_EXCEPTION \nCODE: ${e.code}\nMESSAGE: ${e.message}');
    }
    return AuthFailure(e.toString());
  }
}
