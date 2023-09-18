import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './login_controller.dart';
import '../../core/config/constants.dart' as constants;

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
              onPressed: () async {
                controller.moveToSignUp();
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
                //   print(e);
                // }
              },
              child: const Text('não tenho cadastro'),
            ),
          ]),
        ),
      ),
    );
  }
}
