import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auth_modelo/app/routes/app_pages.dart';

import '../../repository/auth_repository.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/fullScreenDialogLoader.dart';

class HomeController extends GetxController {
  AuthRepository authRepository;

  HomeController(this.authRepository);

  moveToSign() {
    Get.toNamed(Routes.login);
  }

  Future<void> logout() async {
    try {
      FullScreenDialogLoader.showDialog();

      await authRepository.logout();
      Get.toNamed(Routes.login);
    } catch (e) {
      debugPrint('erro no repository');
      FullScreenDialogLoader.cancelDialog();
      CustomSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Erro', message: e.toString());
    }
  }
}
