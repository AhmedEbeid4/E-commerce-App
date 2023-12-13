import 'package:e_commerce/view/main_screens/cart/cart_screen.dart';
import 'package:e_commerce/view/main_screens/profile/edit_profile/edit_account_information_screen.dart';
import 'package:e_commerce/view/main_screens/root_container/root_container.dart';
import 'package:e_commerce/view/main_screens/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../auth_screens/login_view.dart';
import '../auth_screens/sign_up_view.dart';
import '../main_screens/profile/shopping_history/shopping_history_screen.dart';
import '../main_screens/show_details/show_details_screen.dart';

class AppRouter {
  List<GetPage<dynamic>> getRoutes() {
    return [
      GetPage(name: RouteNames.login, page: () => LoginView()),
      GetPage(name: RouteNames.signUp, page: () => SignUpView()),
      GetPage(name: RouteNames.rootContainer, page: () => RootContainer()),
      GetPage(name: RouteNames.splash, page: () => const SplashView()),
      GetPage(name: RouteNames.cart, page: () => CartView()),
      GetPage(name: RouteNames.showDetails, page: () => ShowDetailsScreen()),
      GetPage(name: RouteNames.shoppingHistory, page: () => ShoppingHistory()),
      GetPage(
          name: RouteNames.editProfile,
          page: () => EditAccountInformationScreen())
    ];
  }
}

class RouteNames {
  static const String login = '/login';
  static const String signUp = '/SignUp';
  static const String rootContainer = '/RootContainer';
  static const String splash = '/splash';
  static const String cart = '/cart';
  static const String showDetails = '/ShowDetails';
  static const String shoppingHistory = '/ShoppingHistory';
  static const String editProfile = '/EditProfile';
}
