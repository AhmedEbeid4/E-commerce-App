import 'package:e_commerce/controllers/data/remote_services/firebase_services/auth_service.dart';
import 'package:e_commerce/controllers/data/remote_services/firebase_services/storage_service.dart';

import 'firebase_services/cloud_store_service.dart';
import 'firebase_services/real_time_database.dart';

class RemoteServices{
  AuthService authService;
  StorageService storageService;
  CloudStoreService cloudStoreService;
  RealTimeDatabase realTimeDatabase;

  RemoteServices(this.authService, this.storageService, this.cloudStoreService, this.realTimeDatabase);

}