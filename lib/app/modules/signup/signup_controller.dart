import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:auth_modelo/app/modules/login/login_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:auth_modelo/app/repository/auth_repository.dart';
import 'package:auth_modelo/app/routes/app_pages.dart';

import '../../core/mixins/loader_mixin.dart';
import '../../core/mixins/messages_mixin.dart';
import '../../core/config/constants.dart' as constants;

class SignupController extends GetxController with LoaderMixin, MessagesMixin {
  final AuthRepository authRepository;

  SignupController(this.authRepository);

  LoginController loginController = LoginController(AuthRepository());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController nameEditingController = TextEditingController();

  bool isFormValid = false;

  String msgErrorAppwriteException = '';

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  Client client = Client();
  Databases? databases;

  Account? account;

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

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Nome obrigatório";
    }
    return null;
  }

  Future<void> validateAndSignUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String url_avatar,
  }) async {
    // Client client = Client();

    // Account account;
    // client
    //     .setEndpoint(constants.API_END_POINT)
    //     .setProject(constants.PROJECT_ID)
    //     .setSelfSigned(status: false);

    // account = Account(client);
    // try {
    //   await account.create(
    //     userId: ID.unique(),
    //     email: 'deigo@gmail.com',
    //     password: 'password',
    //     name: 'name',
    //   );
    // } catch (e) {
    //   _message(
    //     MessageModel(
    //       title: 'Atenção!',
    //       message: e.toString(),
    //       type: MessageType.error,
    //     ),
    //   );
    // }
    // if (!isFormValid) {
    //   return;
    // } else {
    // formKey.currentState!.save();

    try {
      _loading.toggle();

      await authRepository.signup({
        "name": name,
        "email": email,
        "password": password,
        "admin": false,
        "phone": phone,
        "url_avatar": url_avatar,
      });
      _loading.toggle();
      _message(
        MessageModel(
          title: 'Parabéns!',
          message: 'Cadastrado com sucesso!',
          type: MessageType.success,
        ),
      );
      await loginController.validateAndSign(email: email, password: password);
    } catch (e) {
      print(e.toString());
      _loading.toggle();

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

      // switch (e) {
      //   case 'A user with the same id, email, or phone already exists in your project.':
      //     text = 'E-mail já cadastrado, recupere a sua senha!';
      //     break;
      // }

      _message(
        MessageModel(
          title: 'Atenção!',
          message: msgErrorAppwriteException,
          type: MessageType.error,
        ),
      );
    }

    // print('result');
    // print(result);

    // await account?.create(
    //   userId: ID.unique(),
    //   email: email,
    //   password: password,
    //   name: name,
    // );
    // _loading.toggle();

    // .then((value) {
    //   _loading.toggle();

    //   _message(
    //     MessageModel(
    //       title: 'Parabéns!',
    //       message: 'Cadastrado com sucesso!',
    //       type: MessageType.success,
    //     ),
    //   );

    //   Get.toNamed(Routes.login);

    // authRepository.sign({
    //   "userId": ID.unique(),
    //   "name": name,
    //   "email": email,
    //   "password": password
    // }).then((value) {
    //   Get.toNamed('/home');
    //   // CustomSnackBar.showSuccessSnackBar(
    //   //     context: Get.context,
    //   //     title: 'Sucesso',
    //   //     message: 'Seja bem vindo a home!');
    // });
    // }).catchError((error) {
    //   _loading.toggle();
    //   if (error is AppwriteException) {
    //     log(error.response['message']);
    //     switch (error.response['type']) {
    //       case 'general_rate_limit_exceeded':
    //         msgErrorAppwriteException =
    //             'Muitas tentativas de acesso! \nTente mais tarde.';
    //         break;
    //       case 'user_email_already_exists':
    //         msgErrorAppwriteException =
    //             'E-mail já cadastrado! \nRecupere a senha de acesso.';
    //         break;
    //       case 'user_already_exists':
    //         msgErrorAppwriteException =
    //             'Usuário já cadastrado! \nRecupere a senha de acesso.';
    //         break;
    //     }

    //     _message(
    //       MessageModel(
    //         title: 'Atenção!',
    //         message: msgErrorAppwriteException,
    //         type: MessageType.error,
    //       ),
    //     );
    //   } else {
    //     _message(
    //       MessageModel(
    //         title: 'Atenção!',
    //         message: 'Erro ao cadastrar usuário!',
    //         type: MessageType.error,
    //       ),
    //     );
    //   }
    // });
    // } catch (e) {
    //   debugPrint('erro no controller');
    //   _loading.toggle();
    //   _message(
    //     MessageModel(
    //       title: 'Erro',
    //       message: e.toString(),
    //       type: MessageType.error,
    //     ),
    //   );
    // }
  }
}
// }
