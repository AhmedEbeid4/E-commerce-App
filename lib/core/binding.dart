import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/data/remote_services/firebase_services/auth_service.dart';
import 'package:e_commerce/controllers/data/remote_services/firebase_services/cloud_store_service.dart';
import 'package:e_commerce/controllers/data/remote_services/firebase_services/real_time_database.dart';
import 'package:e_commerce/controllers/data/remote_services/firebase_services/storage_service.dart';
import 'package:e_commerce/controllers/data/remote_services/remote_services.dart';
import 'package:e_commerce/controllers/data/repository.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'package:e_commerce/controllers/root_container_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class GlobalBinding implements Bindings {
  @override
  void dependencies() {
    final AuthService authService = AuthService(FirebaseAuth.instance);

    final StorageService storageService =
        StorageService(FirebaseStorage.instance);

    final CloudStoreService cloudStoreService =
        CloudStoreService(FirebaseFirestore.instance);

    final RealTimeDatabase realTimeDatabase =
        RealTimeDatabase(FirebaseDatabase.instance);

    final RemoteServices remoteServices = RemoteServices(
        authService, storageService, cloudStoreService, realTimeDatabase);

    final Repository repository = Repository(remoteServices);

    Get.put<AuthenticationController>(AuthenticationController(repository));
    Get.put<UserController>(UserController(repository));
    Get.put<ProductController>(ProductController(repository));
    Get.put<RootContainerController>(RootContainerController());
  }
}
