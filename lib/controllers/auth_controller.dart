import 'package:e_commerce/controllers/data/repository.dart';
import 'package:e_commerce/core/extensions.dart';
import 'package:e_commerce/core/toast.dart';
import 'package:e_commerce/model/user.dart';
import 'package:get/get.dart';

import '../view/routes/app_router.dart';

class AuthenticationController extends GetxController {
  Repository repository;

  AuthenticationController(this.repository);

  Rx<String?> pathImage = Rx<String?>(null);

  bool hasJoined = false;

  @override
  void onInit() {
    super.onInit();
    repository.observeAuthState((user) {
      if (user == null && this.user != null) {
        Get.offAllNamed(RouteNames.login);
      }
    });
  }

  set imagePath(String? imagePath) {
    pathImage.value = imagePath;
  }

  get hasNoImage {
    return pathImage.value == null;
  }

  bool get hasLoggedInBefore {
    return repository.hasLoggedIn();
  }

  final Rx<bool?> selectedGender = Rx<bool?>(null);
  final isAuthenticating = false.obs;
  final isSendingResetPassword = false.obs;
  final isUpdatingPassword = false.obs;
  UserModel? user;

  Rx<bool> isDeletingAccount = false.obs;

  Future login(String email, String password, Function onSuccess) async {
    if (email.isEmpty) {
      showToast('Email Field is empty');
      return;
    }
    if (password.isEmpty) {
      showToast('Password field is empty');
      return;
    }
    isAuthenticating.value = true;
    final res = await repository.login(email, password);
    res.fold((l) {
      showToast(l.message);
      isAuthenticating.value = false;
    }, (r) {
      isAuthenticating.value = false;
      user = r;
      onSuccess();
      Get.offNamed(RouteNames.splash);
    });
  }

  Future signUp(
      String firstName,
      String lastName,
      String email,
      String ageText,
      String weightText,
      String heightText,
      String password,
      String confirmPassword,
      Function onSuccess) async {
    firstName = firstName.trim();
    lastName = lastName.trim();
    email = email.trim();
    ageText = ageText.trim();
    weightText = weightText.trim();
    heightText = heightText.trim();

    if (firstName.isEmpty) {
      showToast('First Name field is Empty');
      return;
    }
    if (lastName.isEmpty) {
      showToast('Last Name field is Empty');
      return;
    }

    if (ageText.isEmpty) {
      showToast('Age Field is empty');
      return;
    }
    if (!ageText.isNumber()) {
      showToast('Enter a valid age, please');
      return;
    }

    if (heightText.isEmpty) {
      showToast('Height Field is empty');
      return;
    }
    if (!heightText.isNumber()) {
      showToast('Enter a valid height, please');
      return;
    }

    if (weightText.isEmpty) {
      showToast('Weight Field is empty');
      return;
    }
    if (!weightText.isNumber()) {
      showToast('Enter a valid weight, please');
      return;
    }

    int age = int.parse(ageText);
    int height = int.parse(heightText);
    int weight = int.parse(weightText);

    if (age > 120 || age <= 5) {
      showToast('Enter a valid age, please');
      return;
    }

    if (height > 210 || height < 110) {
      showToast('Enter a valid height, please');
      return;
    }
    if (selectedGender.value == null) {
      showToast('Select a gender please');
      return;
    }
    if (email.isEmpty) {
      showToast('Email field is empty');
      return;
    }
    if (!email.isValidEmail()) {
      showToast('Email is not valid');
      return;
    }
    if (password.isEmpty) {
      showToast('Password field is empty');
      return;
    }
    if (confirmPassword.isEmpty) {
      showToast('Confirm password is empty');
      return;
    }

    if (password != confirmPassword) {
      showToast('Check you password, please');
      return;
    }
    if (!isPasswordValid(password)) {
      showToast('Requires at least 8 characters, including at least one uppercase letter, one lowercase letter, and one digit.');
      return;
    }
    isAuthenticating.value = true;

    String gender = selectedGender.value! ? 'male' : 'female';
    UserModel user = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        age: age,
        height: height,
        weight: weight,
        gender: gender);

    final res = await repository.signUp(user, password, pathImage.value);

    res.fold((l) {
      showToast(l.message);
      isAuthenticating.value = false;
    }, (r) {
      die();
      onSuccess();
      isAuthenticating.value = false;
      Get.offNamed(RouteNames.login, arguments: {'createdAccount': true});
    });
  }

  Future sendResetPasswordEmail(String email) async {
    email = email.trim();
    if (email.isEmpty) {
      showToast('Email Field is empty');
      return;
    }
    if (!email.isValidEmail()) {
      showToast('Enter a valid email, please');
      return;
    }
    isSendingResetPassword.value = true;
    final res = await repository.forgetPassword(email);
    res.fold((l) {
      isSendingResetPassword.value = false;
      showToast(l.message);
    }, (r) {
      isSendingResetPassword.value = false;
      showToast('Check your email, please');
      Get.back();
    });
  }

  Future logout(Function onSuccess) async {
    final res = await repository.logout();
    res.fold((l) {
      showToast(l.message);
    }, (r) {
      user = null;
      Get.offNamed(RouteNames.login);
      onSuccess();
    });
  }

  Future deleteAccount(Function onSuccess) async {
    print('AUTH_CURR_USER :: ${user.toString()}');
    if (user == null) {
      return;
    }
    isDeletingAccount.value = true;
    final res = await repository.deleteAccount(user!);
    res.fold((l) {
      showToast(l.message);
      isDeletingAccount.value = false;
    }, (r) {
      isDeletingAccount.value = false;
      user = null;
      Get.offAllNamed(RouteNames.login);
      onSuccess();
    });
  }

  Future changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    if (user == null) {
      showToast('Something went wrong');
      return;
    }
    if(oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty){
      showToast('Fill all blanks please');
      return;
    }
    if (newPassword != confirmPassword) {
      showToast('The new password is not like confirm password');
      return;
    }
    if (!isPasswordValid(newPassword)) {
      showToast(
          'Requires at least 8 characters, including at least one uppercase letter, one lowercase letter, and one digit.');
      return;
    }
    isUpdatingPassword.value = true;
    final res =
        await repository.changePassword(user!, oldPassword, newPassword);
    res.fold((l) {
      showToast(l.message);
      isUpdatingPassword.value = false;
    }, (r) {
      showToast('The password has changed successfully');
      isUpdatingPassword.value = false;
      Get.back();
    });
  }

  bool isPasswordValid(String password) {
    // requires at least 8 characters, including at least one uppercase letter, one lowercase letter, and one digit.
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^\s]{8,}$')
        .hasMatch(password);
  }

  void die() {
    pathImage.value = null;
    selectedGender.value = null;
  }
}
