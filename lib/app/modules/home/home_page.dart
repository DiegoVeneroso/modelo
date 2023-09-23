import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import './home_controller.dart';

// ignore: must_be_immutable
class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                // onPressed: () => controller.authRepository.logout(),
                onPressed: () => controller.logout(),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: FutureBuilder<User?>(
          future: controller.authRepository.getUserIfExists(),
          builder: (_, result) {
            User userLocal = GetStorage().read('user');

            if (result.hasError)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            if (result.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
            User? user = result.data;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Usuário da API',
                  // ),
                  // Text(
                  //   user!.$id.toString(),
                  // ),
                  // Text(
                  //   user.name.toString(),
                  // ),
                  // Text(
                  //   user.email.toString(),
                  // ),
                  // Text(
                  //   user.phone.toString(),
                  // ),
                  Text(
                    'Usuário local',
                  ),
                  Text(
                    userLocal.$id,
                  ),
                  Text(
                    userLocal.name,
                  ),
                  Text(
                    userLocal.email,
                  ),
                  Text(
                    GetStorage().read('userLogged'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
