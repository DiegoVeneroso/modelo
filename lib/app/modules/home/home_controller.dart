import 'package:auth_modelo/app/repository/auth_repository.dart';
import 'package:auth_modelo/app/repository/home_repository.dart';
import 'package:auth_modelo/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/mixins/loader_mixin.dart';
import '../../core/mixins/messages_mixin.dart';

class HomeController extends GetxController with LoaderMixin, MessagesMixin {
  HomeRepository homeRepository;
  AuthRepository authRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  HomeController(
    this.homeRepository,
    this.authRepository,
  );

  logout() async {
    try {
      _loading.toggle();

      await authRepository.logout();
      Get.toNamed(Routes.login);
      _message(
        MessageModel(
          title: 'Parabéns!',
          message: 'Usuário desconectado!',
          type: MessageType.success,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      _loading.toggle();

      _message(
        MessageModel(
          title: 'Atenção!',
          message: 'Erro ao sair!',
          type: MessageType.error,
        ),
      );
    }
  }
}
