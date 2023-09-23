import 'package:auth_modelo/app/repository/auth_repository.dart';
import 'package:auth_modelo/app/repository/home_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      // () => HomeController(AuthRepository(AppService())),
      () => HomeController(
        HomeRepository(),
        AuthRepository(),
        GetStorage(),
      ),
    );
  }
}
