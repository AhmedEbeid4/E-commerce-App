import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_router.dart';
import 'widgets/account_delete_dialog.dart';
import 'widgets/change_password_dialog.dart';
import 'widgets/option_item_widget.dart';
import 'widgets/profile_header_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final _userController = Get.find<UserController>();
  final _authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                15.he,
                ProfileHeaderWidget(
                  email: _userController.user!.email,
                ),
                10.he,
                const Text(
                  'Options',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                20.he,
                OptionItem(
                    title: 'Edit Profile',
                    icon: Icons.person_outlined,
                    arrowVisible: true,
                    onClick: () {
                      Get.toNamed(RouteNames.editProfile);
                    }),
                20.he,
                OptionItem(
                    title: 'Shopping History',
                    icon: Icons.shopping_cart_outlined,
                    arrowVisible: true,
                    onClick: () {
                      Get.toNamed(RouteNames.shoppingHistory);
                    }),
                20.he,
                OptionItem(
                    title: 'Change Password',
                    icon: Icons.lock_outline,
                    arrowVisible: true,
                    onClick: () {
                      Get.dialog(ChangePasswordDialog(_authController));
                    }),
                20.he,
                OptionItem(
                    title: 'Logout',
                    icon: Icons.logout,
                    arrowVisible: false,
                    onClick: () {
                      _authController.logout(() {
                        _userController.user = null;
                      });
                    }),
                20.he,
                OptionItem(
                    title: 'Delete Account',
                    icon: Icons.delete_outlined,
                    arrowVisible: false,
                    onClick: () {
                      Get.dialog(AccountDeleteDialog(
                        onOk: () {
                          _authController.deleteAccount(() {
                            _userController.user = null;
                          });
                        },
                      ));
                    }),
                20.he,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
