import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/controllers/root_container_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/view/main_screens/home/widgets/home_list_view.dart';
import 'package:e_commerce/view/main_screens/home/widgets/section_header.dart';
import 'package:e_commerce/view/main_screens/home/widgets/slider_widget.dart';
import 'package:e_commerce/view/main_screens/home/widgets/welcome_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final _userController = Get.find<UserController>();
  final _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.he,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: WelcomeWidget(
                name: _userController.user!.firstName,
                imageUrl: _userController.user!.imageUrl,
                onImageClicked: () =>
                    Get.find<RootContainerController>().currIndex.value = 4,
              ),
            ),
            20.he,
            SliderWidget(
              getProduct: () => _productController.getRandomElement()!,
              width: MediaQuery.of(context).size.width,
            ),
            16.he,
            const Text(
              ' Recommendations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            20.he,
            GetBuilder<ProductController>(
                id: 'recommend',
                builder: (controller) {
                  return HomeListView(
                    length: controller.recommendations!.length,
                    getProduct: (index) =>
                        controller.getRecommendationByIndex(index),
                    index: 1,
                  );
                }),
            20.he,
            SectionHeader(
                title: 'More',
                onSeeAllClicked: () {
                  Get.find<RootContainerController>().currIndex.value = 1;
                }),
            10.he,
            GetBuilder<ProductController>(
                id: 'more',
                builder: (controller) {
                  return HomeListView(
                    length: 10,
                    getProduct: (index) => controller.getItemByIndex(index),
                    index: 2,
                  );
                }),
            20.he,
          ],
        ),
      ),
    );
  }
}
