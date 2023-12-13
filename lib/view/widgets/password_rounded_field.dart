import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/password_controller.dart';
import 'package:e_commerce/view/widgets/rounded_text_field.dart';

class PasswordField extends StatelessWidget {
  final String text;
  final TextEditingController textEditingController;
  final PasswordController controller = PasswordController();
  bool? forConfirm;
  PasswordField({super.key, required this.textEditingController, this.forConfirm = false, required this.text});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return RoundedTextField(
        textEditingController: textEditingController,
        hintText: text,
        inputType: TextInputType.visiblePassword,
        obscureText: controller.passwordHidden.value,
        onClickSuffixIcon: (){
          controller.passwordHidden.toggle();
        },
        suffixIcon: controller.passwordHidden.value
            ? Icons.visibility
            : Icons.visibility_off,
      );
    });
  }
}
