import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';

class ForgetPasswordWidget extends StatelessWidget {
  final _forgetPasswordEmailController = TextEditingController();
  final _authController = Get.find<AuthenticationController>();

  ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Forgot Password',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          15.he,
          const Text(
              'Enter your email for reset password process, we will send email to you'),
          15.he,
          SizedBox(
              width: double.infinity,
              child: RoundedTextField(
                hintText: 'Email',
                textEditingController: _forgetPasswordEmailController,
                inputType: TextInputType.emailAddress,
              )),
          19.he,
          SizedBox(
              width: double.infinity,
              child: Obx(()=>RoundedButton(
                text: 'OK',
                onClick: () {
                  _authController.sendResetPasswordEmail(_forgetPasswordEmailController.text);
                },
                visible: !_authController.isSendingResetPassword.value,
              )))
        ],
      ),
    );
  }
}
