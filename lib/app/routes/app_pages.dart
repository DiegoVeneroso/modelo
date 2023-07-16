import 'package:get/get.dart';
import 'package:mots/app/modules/home/home_bindings.dart';
import 'package:mots/app/modules/home/home_page.dart';
import 'package:mots/app/modules/signup/signup_bindings.dart';
import 'package:mots/app/modules/signup/signup_page.dart';

import '../modules/login/login_bindings.dart';
import '../modules/login/login_page.dart';
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
      name: _Paths.signup,
      page: () => const SignupPage(),
      binding: SignupBindings(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
  ];
}
