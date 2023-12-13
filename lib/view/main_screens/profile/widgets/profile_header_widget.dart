import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget(
      {super.key,
      required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: GetBuilder<UserController>(
                id: 'header profile image',
                builder: (controller) {
                  return controller.user!.imageUrl != null
                      ? FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: const AssetImage(
                              "assets/images/profile_icon.png"),
                          image: NetworkImage(controller.user!.imageUrl!))
                      : Image.asset("assets/images/profile_icon.png");
                }),
          ),
        ),
        9.wi,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<UserController>(
                id: 'profile username',
                builder: (controller) {
                  return Text(
                    '${controller.user!.firstName} ${controller.user!.lastName}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  );
                }),
            Text(
              email,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor),
            )
          ],
        )
      ],
    );
  }
}
