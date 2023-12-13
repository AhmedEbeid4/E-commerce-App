import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/view/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDeleteDialog extends StatelessWidget {
  const AccountDeleteDialog({super.key, required this.onOk});

  final VoidCallback onOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Account'),
      content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.'),
      actions: [
        DefaultTextButton(
          onClick: () => Get.back(),
          text: 'Cancel',
        ),
        Obx(() {
          if (Get.find<AuthenticationController>().isDeletingAccount.value) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 20,
              width: 60,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.red,
              ),
            );
          }
          return TextButton(
            onPressed: () {
              onOk();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          );
        })
      ],
    );
  }
}
