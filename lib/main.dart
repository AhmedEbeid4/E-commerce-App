import 'package:flutter/material.dart';
import 'package:e_commerce/view/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'core/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App(
    router: AppRouter(),
    bindings: GlobalBinding(),
  ));
}

class App extends StatelessWidget {
  final Bindings bindings;
  final AppRouter router;

  const App({super.key, required this.bindings, required this.router});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: bindings,
      theme: ThemeData(
        // #0E5286
        primaryColor: const Color.fromRGBO(14, 82, 137, 1),
      ),
      initialRoute: RouteNames.splash,
      getPages: router.getRoutes(),
    );
  }
}