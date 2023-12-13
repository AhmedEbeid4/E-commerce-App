import 'dart:io';

import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/rounded_button.dart';
import '../../../widgets/rounded_text_field.dart';

class EditAccountInformationScreen extends StatelessWidget {
  EditAccountInformationScreen({super.key});

  final UserController _userController = Get.find<UserController>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void _assignProfileData(UserModel user) {
    _firstNameController.text = user.firstName;
    _secondNameController.text = user.lastName;
    _weightController.text = user.weight.toString();
    _heightController.text = user.height.toString();
    _ageController.text = user.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    _userController.imagePath = null;
    _assignProfileData(_userController.user!);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.he,
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () async {
                      final picker = ImagePicker();
                      final pickedImage = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedImage != null) {
                        _userController.imagePath = pickedImage.path;
                      } else {
                        _userController.imagePath = null;
                      }
                    },
                    child: GetBuilder<UserController>(
                        id: 'edit profile pictures',
                        builder: (controller) {
                          if (controller.pathImage == null) {
                            return SizedBox(
                              height: 100,
                              width: 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: controller.user!.imageUrl != null
                                    ? FadeInImage(
                                        fit: BoxFit.cover,
                                        placeholder: const AssetImage(
                                            "assets/images/profile_icon.png"),
                                        image: NetworkImage(
                                            controller.user!.imageUrl!))
                                    : Image.asset(
                                        "assets/images/profile_icon.png"),
                              ),
                            );
                          }
                          return SizedBox(
                            height: 100,
                            width: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.file(
                                  fit: BoxFit.cover,
                                  File(controller.pathImage!)),
                            ),
                          );
                        }),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              26.he,
              RoundedTextField(
                labelText: 'First Name',
                textEditingController: _firstNameController,
                inputType: TextInputType.name,
              ),
              15.he,
              RoundedTextField(
                labelText: 'Second Name',
                textEditingController: _secondNameController,
                inputType: TextInputType.name,
              ),
              15.he,
              RoundedTextField(
                labelText: 'Age',
                textEditingController: _ageController,
                inputType: TextInputType.number,
              ),
              15.he,
              RoundedTextField(
                labelText: 'Height',
                textEditingController: _heightController,
                inputType: TextInputType.number,
              ),
              15.he,
              RoundedTextField(
                labelText: 'Weight',
                textEditingController: _weightController,
                inputType: TextInputType.number,
              ),
              25.he,
              SizedBox(
                width: double.infinity,
                child: Obx(() => RoundedButton(
                      text: 'Save',
                      onClick: () {
                        _userController.updateUser(
                            _firstNameController.text,
                            _secondNameController.text,
                            _weightController.text,
                            _heightController.text,
                            _ageController.text, (user) {
                          _assignProfileData(user);
                        });
                      },
                      visible: !_userController.isUpdatingProfile.value,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
