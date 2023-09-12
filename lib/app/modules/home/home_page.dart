import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mots/app/core/services/app_service.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<User?>(
            future: AppService().getUser(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return CircularProgressIndicator();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              User? user = snapshot.data;
              // return Text(user?.prefs.data['Admin'].toString() ?? '');
              return Text(user?.phone ?? '');
            },
          ),
          actions: [
            IconButton(
                onPressed: () => controller.logout(), icon: Icon(Icons.logout))
          ],
        ),
        body: Container(),
      ),
    );
  }
}
