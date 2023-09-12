import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './signup_controller.dart';

class SignupPage extends GetView<SignupController> {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignupPage'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () async {
                await controller.validateAndSignUp(
                  email: 'diegoveneroso.unipampa@gmail.com',
                  password: '12345678',
                  name: 'Diego Veneroso',
                );
              },
              child: const Text('Cadastrar'),
            )
          ]),
        ),
      ),
    );
  }
}
