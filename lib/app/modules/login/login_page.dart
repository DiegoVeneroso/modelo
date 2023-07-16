import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                controller.validateAndSign(
                  email: 'diegoveneroso.unipampa@gmail.com',
                  password: '12345678',
                );
              },
              child: const Text('Entrar'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.moveToSignUp();
              },
              child: const Text('não tenho cadastro'),
            ),
          ]),
        ),
      ),
    );
  }
}
