import 'package:e_commerce/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../widgets/password_rounded_field.dart';
import '../../../widgets/rounded_button.dart';

class ChangePasswordDialog extends StatelessWidget {
  ChangePasswordDialog(this.authenticationController, {super.key});

  final AuthenticationController authenticationController;
  final TextEditingController _oldPasswordController =  TextEditingController();
  final TextEditingController _confirmPasswordController =  TextEditingController();
  final TextEditingController _newPasswordController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        height: 390,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              5.he,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () => Get.back(), icon: const Icon(Icons.close))
                ],
              ),
              20.he,
              PasswordField(
                text: 'Old Password',
                textEditingController: _oldPasswordController,
              ),
              10.he,
              PasswordField(
                text: 'New Password',
                textEditingController: _newPasswordController,
              ),
              10.he,
              PasswordField(
                text: 'Confirm New Password',
                textEditingController: _confirmPasswordController,
              ),
              15.he,
              SizedBox(
                width: double.infinity,
                child: Obx(() => RoundedButton(
                      text: 'Submit',
                      onClick: () {
                        authenticationController.changePassword(_oldPasswordController.text, _newPasswordController.text, _confirmPasswordController.text);
                      },
                      visible: !authenticationController.isUpdatingPassword.value,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
