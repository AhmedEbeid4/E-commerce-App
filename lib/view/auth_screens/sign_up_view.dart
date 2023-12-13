import 'dart:io';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/view/widgets/radio_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../routes/app_router.dart';
import '../widgets/password_rounded_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_text_field.dart';
import '../widgets/text_button.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final AuthenticationController _authController =
      Get.find<AuthenticationController>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                15.he,
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final pickedImage = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedImage != null) {
                      _authController.imagePath = pickedImage.path;
                    } else {
                      _authController.imagePath = null;
                    }
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Obx(() {
                      if (_authController.hasNoImage) {
                        return const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/profile_icon.png'),
                        );
                      }
                      return CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            FileImage(File(_authController.pathImage.value!)),
                      );
                    }),
                  ),
                ),
                26.he,
                RoundedTextField(
                  hintText: 'First Name',
                  textEditingController: _firstNameController,
                  inputType: TextInputType.name,
                ),
                15.he,
                RoundedTextField(
                  hintText: 'Last Name',
                  textEditingController: _lastNameController,
                  inputType: TextInputType.name,
                ),
                15.he,
                RoundedTextField(
                  hintText: 'Age',
                  textEditingController: _ageController,
                  inputType: TextInputType.number,
                ),
                15.he,
                Row(
                  children: [
                    Expanded(
                      child: RoundedTextField(
                        hintText: 'Height',
                        textEditingController: _heightController,
                        inputType: TextInputType.number,
                      ),
                    ),
                    10.wi,
                    Expanded(
                      child: RoundedTextField(
                        hintText: 'Weight',
                        textEditingController: _weightController,
                        inputType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                15.he,
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DefaultRadioButton(
                            text: 'Male',
                            isSelected:
                                _authController.selectedGender.value != null &&
                                    _authController.selectedGender.value!,
                            onClick: () {
                              if (_authController.selectedGender.value !=
                                      null &&
                                  _authController.selectedGender.value!) {
                                return;
                              }
                              _authController.selectedGender.value = true;
                            },
                          )),
                    ),
                    10.wi,
                    Expanded(
                      child: Obx(() => DefaultRadioButton(
                          text: 'Female',
                          isSelected:
                              _authController.selectedGender.value != null &&
                                  !_authController.selectedGender.value!,
                          onClick: () {
                            if (_authController.selectedGender.value != null &&
                                !_authController.selectedGender.value!) {
                              return;
                            }
                            _authController.selectedGender.value = false;
                          })),
                    )
                  ],
                ),
                15.he,
                RoundedTextField(
                  hintText: 'Email',
                  textEditingController: _emailController,
                  inputType: TextInputType.emailAddress,
                ),
                15.he,
                PasswordField(
                  text: 'Password',
                  textEditingController: _passwordController,
                ),
                15.he,
                PasswordField(
                  text: 'Confirm Password',
                  textEditingController: _confirmPasswordController,
                  forConfirm: true,
                ),
                15.he,
                SizedBox(
                    width: double.infinity,
                    child: Obx(
                      () => RoundedButton(
                        text: 'Sign Up',
                        visible: !_authController.isAuthenticating.value, //
                        onClick: () {
                          _authController.signUp(
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailController.text,
                              _ageController.text,
                              _weightController.text,
                              _heightController.text,
                              _passwordController.text,
                              _confirmPasswordController.text, () {
                            _firstNameController.text = '';
                            _lastNameController.text = '';
                            _emailController.text = '';
                            _ageController.text = '';
                            _weightController.text = '';
                            _heightController.text = '';
                            _passwordController.text = '';
                            _confirmPasswordController.text = '';
                          });
                          /*
                          _userController.signUp(
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailController.text,
                              _passwordController.text,
                              _confirmPasswordController.text, () {
                            _firstNameController.text = '';
                            _lastNameController.text = '';
                            _emailController.text = '';
                            _passwordController.text = '';
                            _confirmPasswordController.text = '';
                          });

                           */
                        },
                      ),
                    )),
                5.he,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account ?"),
                    Obx(() => DefaultTextButton(
                          onClick: _authController.isAuthenticating.value
                              ? () {}
                              : () {
                                  _authController.die();
                                  Get.offNamed(RouteNames.login);
                                },
                          text: "Login",
                        )),
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
