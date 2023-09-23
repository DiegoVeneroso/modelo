import 'package:get/get.dart';
import 'package:auth_modelo/app/modules/splash/splash_controller.dart';
import 'package:get_storage/get_storage.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(GetStorage()));
  }
}
