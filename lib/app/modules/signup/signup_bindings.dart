import 'package:get/get.dart';
import 'package:auth_modelo/app/modules/login/login_controller.dart';
import 'package:auth_modelo/app/repository/auth_repository.dart';
import 'package:auth_modelo/app/core/services/app_service.dart';
import './signup_controller.dart';

class SignupBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      // () => SignupController(AuthRepository(AppService())),
      () => SignupController(AuthRepository()),
    );
    Get.lazyPut<LoginController>(
      // () => LoginController(AuthRepository(AppService())),
      () => LoginController(AuthRepository()),
    );
  }
}
