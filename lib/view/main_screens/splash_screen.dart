import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/controllers/root_container_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/view/routes/app_router.dart';
import 'package:e_commerce/view/widgets/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  Future<bool> futureFunction() async {
    Get.find<RootContainerController>().currIndex.value = 0;
    final authController = Get.find<AuthenticationController>();
    if (authController.hasJoined) {
      return true;
    }
    final userController = Get.find<UserController>();
    final productController = Get.find<ProductController>();
    print(
        'userController.user == null = ${userController.user == null}\nauthController.hasLoggedInBefore = ${authController.hasLoggedInBefore}');
    if (userController.user == null && !authController.hasLoggedInBefore) {
      print('IN_11');
      await Future.delayed(const Duration(seconds: 3));
      return false;
    } else if (userController.user != null) {
      print('IN_12');
      final res = await productController.getProducts(
          updateFav: () => userController.observeData());
      if (!res) {
        return res;
      }
      authController.hasJoined = true;
      await productController.getRecommendations(user: userController.user!);
      return true;
    } else if (authController.hasLoggedInBefore) {
      authController.hasJoined = true;
      print('IN_13');
      final res = await Future.wait([
        productController.getProducts(
            updateFav: () => userController.observeData()),
        userController.getUser()
      ]);
      authController.user = userController.user;
      print(
          'res12414312 : ${res[0]} , res12414312: ${res[0]} : ${userController.user!.firstName}');
      if (res[0] && res[1]) {
        productController.getRecommendations(user: userController.user!);
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashWidget(
          futureFunction: futureFunction(),
          onSuccess: () {
            Get.offNamed(RouteNames.rootContainer);
          },
          onFail: () {
            Get.offNamed(RouteNames.login);
          }),
    );
  }
}
