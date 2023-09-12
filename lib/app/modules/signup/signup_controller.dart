import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mots/app/repository/auth_repository.dart';
import 'package:mots/app/routes/app_pages.dart';
import 'package:mots/app/utils/custom_snack_bar.dart';
import 'package:mots/app/utils/fullScreenDialogLoader.dart';

class SignupController extends GetxController {
  AuthRepository authRepository;

  SignupController(this.authRepository);

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
    String admin = "false",
    String? phone = '',
  }) async {
    // if (!isFormValid) {
    //   return;
    // } else {
    // formKey.currentState!.save();

    try {
      FullScreenDialogLoader.showDialog();

      await authRepository.signup({
        "userId": ID.unique(),
        "name": name,
        "email": email,
        "password": password,
        "admin": admin,
        "phone": phone,
      }).then((value) {
        FullScreenDialogLoader.cancelDialog();
        CustomSnackBar.showSuccessSnackBar(
            context: Get.context,
            title: 'Sucesso',
            message: 'Cadastrado com sucesso!');

        Get.toNamed(Routes.login);

        // authRepository.sign({
        //   "userId": ID.unique(),
        //   "name": name,
        //   "email": email,
        //   "password": password
        // }).then((value) {
        //   Get.toNamed('/home');
        //   CustomSnackBar.showSuccessSnackBar(
        //       context: Get.context,
        //       title: 'Sucesso',
        //       message: 'Seja bem vindo a home!');
        // });
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
              message: 'Erro ao cadastrar usuário!');
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
// }
