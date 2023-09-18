import 'package:get/get.dart';
import '../../core/services/app_service.dart';
import '../../repository/auth_repository.dart';
import './login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      // () => LoginController(AuthRepository(AppService())),
      () => LoginController(AuthRepository()),
    );
  }
}
