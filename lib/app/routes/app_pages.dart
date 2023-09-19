import 'package:get/get.dart';
import 'package:auth_modelo/app/modules/home/home_bindings.dart';
import 'package:auth_modelo/app/modules/home/home_page.dart';
import 'package:auth_modelo/app/modules/auth/register/register_bindigns.dart';
import 'package:auth_modelo/app/modules/auth/register/register_page.dart';

import '../modules/auth/login/login_bindings.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterPage(),
      binding: RegisterBindings(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
  ];
}
