import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auth_modelo/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  GetStorage storage;
  late User user;

  SplashController(
    this.storage,
  );

  @override
  void onInit() {
    init();

    super.onInit();
  }

  // @override
  // void onReady() async {
  //   super.onReady();

  //   init();
  // }

  init() async {
    // var result = await storage.read('user');

    if (storage.read('userLogged') == 'true') {
      print('usuario já estava logado');
      Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAllNamed(Routes.home),
      );
    } else {
      print('usuario não estava logado');
      Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAllNamed(Routes.login),
      );
    }
  }
}
