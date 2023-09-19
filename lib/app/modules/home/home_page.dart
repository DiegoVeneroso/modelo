import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

// ignore: must_be_immutable
class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
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
                // onPressed: () => controller.authRepository.logout(),
                onPressed: () => controller.logout(),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: FutureBuilder<User?>(
          future: controller.authRepository.getUserIfExists(),
          builder: (_, result) {
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
                  Text(
                    user!.$id.toString(),
                  ),
                  Text(
                    user.name.toString(),
                  ),
                  Text(
                    user.email.toString(),
                  ),
                  Text(
                    user.phone.toString(),
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
