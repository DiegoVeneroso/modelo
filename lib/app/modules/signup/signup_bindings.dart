import 'package:get/get.dart';
import 'package:mots/app/repository/auth_repository.dart';
import 'package:mots/app/core/services/app_service.dart';
import './signup_controller.dart';

class SignupBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(AuthRepository(AppService())),
    );
  }
}
