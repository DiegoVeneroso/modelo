import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auth_modelo/app/routes/app_pages.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/mixins/loader_mixin.dart';
import '../../core/mixins/messages_mixin.dart';
import '../../repository/auth_repository.dart';
import '../../utils/custom_snack_bar.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  AuthRepository authRepository;

  LoginController(this.authRepository);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();

  bool isFormValid = false;

  String msgErrorAppwriteException = '';

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

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

  validateEmail(String value) {
    return Validatorless.multiple([
      Validatorless.required('E-mail obrigatório'),
      Validatorless.email('E-mail inválido'),
    ]);
    // if (!GetUtils.isEmail(value)) {
    //   print("E-mail obrigatório");
    // }
    // return null;
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
    if (!isFormValid) {
      return null;
    } else {
      formKey.currentState!.save();

      try {
        _loading.toggle();

        await authRepository.sign({"email": email, "password": password});

        _message(
          MessageModel(
            title: 'Parabéns!',
            message: 'Conectado com sucesso!',
            type: MessageType.success,
          ),
        );
        Get.toNamed(Routes.home);
      } catch (e) {
        _loading.toggle();

        log(e.toString());
        switch (e) {
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
        _message(
          MessageModel(
            title: 'Atenção!',
            message: msgErrorAppwriteException,
            type: MessageType.error,
          ),
        );
      }
    }
  }
}
