import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auth_modelo/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/mixins/loader_mixin.dart';
import '../../../core/mixins/messages_mixin.dart';
import '../../../repository/auth_repository.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  AuthRepository authRepository;

  LoginController(this.authRepository);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String msgErrorAppwriteException = '';

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  GetStorage storage = GetStorage();

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  moveToRegister() {
    Get.toNamed(Routes.register);
  }

  moveToRecoveryPassword() {
    Get.toNamed(Routes.recovery_password);
  }

  moveToHome() {
    Get.toNamed(Routes.home);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _loading.toggle();

      User user =
          await authRepository.login({"email": email, "password": password});

      await storage.write('user', user);
      if (user.email != '') {
        await storage.write('userLogged', 'true');
      }

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
