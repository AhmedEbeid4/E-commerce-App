import 'package:e_commerce/controllers/root_container_controller.dart';
import 'package:e_commerce/view/main_screens/explore/explore_screen.dart';
import 'package:e_commerce/view/main_screens/favourites/favourites_screen.dart';
import 'package:e_commerce/view/main_screens/home/home_screen.dart';
import 'package:e_commerce/view/main_screens/profile/profile_screen.dart';
import 'package:e_commerce/view/main_screens/root_container/widgets/btm_nav_bar.dart';
import 'package:e_commerce/view/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootContainer extends StatelessWidget {
  RootContainer({super.key});

  final _controller = Get.find<RootContainerController>();

  Widget getScreenByIndex(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return ExploreView();
      case 3:
        return WishListView();
      case 4:
        return ProfileView();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => getScreenByIndex(_controller.currIndex.value)),
      bottomNavigationBar: Obx(() => BottomNavBar(
            index: _controller.currIndex.value,
            onChange: (index) {
              if (index == 2) {
                Get.toNamed(RouteNames.cart);
                return;
              }
              _controller.currIndex.value = index;
            },
          )),
    );
  }
}
