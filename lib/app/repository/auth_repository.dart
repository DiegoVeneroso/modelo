import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../core/config/constants.dart' as constants;

class AuthRepository {
  Client client = Client();
  Databases? databases;

  Account? account;
  // User? _user;

  AppService() {
    client
        .setEndpoint(constants.API_END_POINT)
        .setProject(constants.PROJECT_ID)
        .setSelfSigned(status: false);

    account = Account(client);
    databases = Databases(client);
  }

  @override
  void onReady() {}

  signup(Map map) async {
    try {
      client
          .setEndpoint(constants.API_END_POINT)
          .setProject(constants.PROJECT_ID)
          .setSelfSigned(status: false);

      account = Account(client);

      var user = await account?.create(
        userId: ID.unique(),
        email: map["email"],
        password: map["password"],
        name: map["name"],
      );

      // if (user!.$id.isEmpty) {
      //   return user.$id;
      // }

      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      var token = await firebaseMessaging.getToken();

      await databases?.createDocument(
          databaseId: 'db_auth',
          collectionId: 'cl_auth',
          documentId: ID.unique(),
          data: {
            'userID': user?.$id,
            'name': map["name"],
            'email': map["email"],
            'phone': map["phone"],
            'admin': map["admin"] == false ? false : true,
            'url_avatar': map["url_avatar"],
            'tokenPush': token,
          });

      // await account?.createEmailSession(
      //   email: map["email"],
      //   password: map["password"],
      // );

      // var sessionID = session?.$id;
    } on AppwriteException catch (e) {
      log(e.message.toString());
      throw (e.message.toString());
      // return e.runtimeType;
    }
  }

  sign(Map map) async {
    await account?.createEmailSession(
      email: map["email"],
      password: map["password"],
    );
  }

  logout() async {
    await account?.deleteSessions();
  }
  // final AppService appService;
  // AuthRepository(this.appService);

  // Future<User?> signup(Map map) async {
  //   return await appService.signup(map);
  // }

  // Future<User?> sign(Map map) async {
  //   return await appService.sign(map);
  // }

  // logout() async {
  //   return await appService.logout();
  // }
}
