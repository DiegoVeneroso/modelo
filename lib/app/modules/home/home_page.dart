import 'package:appwrite/models.dart';
import 'package:auth_modelo/app/repository/auth_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('gfds'),
          // title: FutureBuilder<User?>(
          //   future: authRepository.getUserIfExists(),
          //   builder: (_, snapshot) {
          //     if (snapshot.hasError) return const CircularProgressIndicator();
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     }
          //     User? user = snapshot.data;
          //     // return Text(user?.prefs.data['Admin'].toString() ?? '');
          //     return Text(user!.email.toString());
          //   },
          // ),
          actions: [
            IconButton(
                onPressed: () => controller.logout(),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(),
      ),
    );
  }
}
