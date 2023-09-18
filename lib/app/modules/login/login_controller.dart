import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auth_modelo/app/routes/app_pages.dart';

import '../../repository/auth_repository.dart';
import '../../utils/custom_snack_bar.dart';
import '../../utils/fullScreenDialogLoader.dart';

class LoginController extends GetxController {
  AuthRepository authRepository;

  LoginController(this.authRepository);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();

  bool isFormValid = false;

  String msgErrorAppwriteException = '';

  @override
  void onClose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    nameEditingController.dispose();
  }

  void clearTextEditingController() {
    emailEditingController.clear();
    passwordEditingController.clear();
    nameEditingController.clear();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "E-mail obrigatório";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Senha obrigatória";
    }
    return null;
  }

  moveToSignUp() {
    Get.toNamed(Routes.signup);
  }

  moveToHome() {
    Get.toNamed(Routes.home);
  }

  Future<void> validateAndSign({
    required String email,
    required String password,
  }) async {
    // if (!isFormValid) {
    //   return;
    // } else {
    // formKey.currentState!.save();

    try {
      FullScreenDialogLoader.showDialog();

      await authRepository
          .sign({"email": email, "password": password}).then((value) {
        FullScreenDialogLoader.cancelDialog();
        CustomSnackBar.showSuccessSnackBar(
            context: Get.context,
            title: 'Sucesso',
            message: 'Usuario logado com sucesso!');
        Get.toNamed(Routes.home);
      }).catchError((error) {
        FullScreenDialogLoader.cancelDialog();

        if (error is AppwriteException) {
          print(error.response['message']);
          switch (error.response['type']) {
            case 'general_rate_limit_exceeded':
              msgErrorAppwriteException =
                  'Muitas tentativas de acesso! \nTente mais tarde.';
              break;
            case 'user_email_already_exists':
              msgErrorAppwriteException =
                  'E-mail já cadastrado! \nRecupere a senha de acesso.';
              break;
            case 'user_already_exists':
              msgErrorAppwriteException =
                  'Usuário já cadastrado! \nRecupere a senha de acesso.';
              break;
            case 'user_invalid_credentials':
              msgErrorAppwriteException =
                  'Usuario ou senha não conferem! \nVerifique seu usuario e senha.';
              break;
          }

          CustomSnackBar.showErrorSnackBar(
            context: Get.context,
            title: 'Erro',
            message: msgErrorAppwriteException,
          );
        } else {
          CustomSnackBar.showErrorSnackBar(
              context: Get.context,
              title: 'Erro',
              message: 'Usuario ou senha não conferem!');
        }
      });
    } catch (e) {
      debugPrint('erro no repository');
      FullScreenDialogLoader.cancelDialog();
      CustomSnackBar.showErrorSnackBar(
          context: Get.context, title: 'Erro', message: e.toString());
    }
  }
}
