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
              onPressed: () {
                controller.validateAndSignUp(
                  email: 'diegoveneroso.unipampa@gmail.com',
                  password: '12345678',
                  name: 'Diego Veneroso',
                  phone: '5555984598383',
                  url_avatar:
                      'http://ec2-15-228-235-228.sa-east-1.compute.amazonaws.com/console/project-auth_appwrite/databases/database-db_auth/collection-cl_auth/attributes',
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
