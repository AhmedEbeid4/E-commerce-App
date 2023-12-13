import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/view/auth_screens/widgets/forget_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_router.dart';
import '../widgets/password_rounded_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_text_field.dart';
import '../widgets/text_button.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _authController = Get.find<AuthenticationController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void showCustomAlertDialog() {
    Get.defaultDialog(
      title: 'Account Created',
      middleText:
          'Congratulations! Your account is created. Please verify your email to log in. Thank you!',
      content: Column(
        children: [
          const Icon(
            Icons.check_circle,
            size: 40,
            color: Colors.green,
          ),
          10.he,
          const Text(
              'After verifying your email, you will be able to access all the features.'),
          15.he,
          SizedBox(
            height: 40,
            width: double.infinity,
            child: RoundedButton(
                padding: 10,
                text: 'Ok',
                onClick: () {
                  Get.back();
                }),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    if (args != null) {
      final hasCreatedAnAccount = args['createdAccount'] as bool?;
      if (hasCreatedAnAccount != null && hasCreatedAnAccount) {
        Future.delayed(Duration.zero, () {
          showCustomAlertDialog();
        });
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                10.he,
                SizedBox(
                  width: double.infinity,
                  child: Image.asset('assets/images/login_screen_image.png'),
                ),
                RoundedTextField(
                  textEditingController: _emailController,
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                ),
                10.he,
                PasswordField(
                  text: 'Password',
                  textEditingController: _passwordController,
                ),
                2.he,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefaultTextButton(
                      onClick: _authController.isAuthenticating.value
                          ? () {}
                          : () {
                              Get.bottomSheet(
                                ForgetPasswordWidget(),
                                isScrollControlled: true,
                              );
                            },
                      text: "Forget Password ?",
                    )
                  ],
                ),
                20.he,
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => RoundedButton(
                        text: 'Login',
                        onClick: () {
                          _authController.login(
                              _emailController.text, _passwordController.text,
                              () {
                            Get.find<UserController>().user =
                                _authController.user;
                          });
                        },
                        visible: !_authController.isAuthenticating.value,
                      )),
                ),
                5.he,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    Obx(() {
                      return DefaultTextButton(
                        onClick: _authController.isAuthenticating.value
                            ? () {}
                            : () {
                                Get.offNamed(RouteNames.signUp);
                              },
                        text: "Sign Up",
                      );
                    }),
                  ],
                ),
                10.he
              ],
            ),
          ),
        ),
      ),
    );
  }
}
