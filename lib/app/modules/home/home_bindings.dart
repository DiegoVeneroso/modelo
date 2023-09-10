import 'package:get/get.dart';
import '../../core/services/app_service.dart';
import '../../repository/auth_repository.dart';
import './home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(AuthRepository(AppService())),
    );
  }
}
