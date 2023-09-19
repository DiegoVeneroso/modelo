import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../core/config/constants.dart' as constants;

class HomeRepository {
  Client client = Client();
  Databases? databases;

  Account? account;

  register(Map map) async {
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
            'admin': map["admin"],
            'url_avatar': map["url_avatar"],
            'tokenPush': token,
          });

      log('Usuario cadastrado com sucesso!');
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  login(Map map) async {
    try {
      client
          .setEndpoint(constants.API_END_POINT)
          .setProject(constants.PROJECT_ID)
          .setSelfSigned(status: false);

      account = Account(client);

      await account?.createEmailSession(
        email: map["email"],
        password: map["password"],
      );
    } on AppwriteException catch (e) {
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  logout() async {
    try {
      client
          .setEndpoint(constants.API_END_POINT)
          .setProject(constants.PROJECT_ID)
          .setSelfSigned(status: false);

      account = Account(client);
      var result = await this.account?.get();
      final sessionUser = result!.$id;
      print(sessionUser.toString());
    } on AppwriteException catch (e) {
      if (e.code != 401 || e.type != 'general_unauthorized_scope') rethrow;
    }

    // return null;
  }

  Future<Preferences> getUserPreferences() async {
    return await account!.getPrefs();
  }

  updatePreferences({required String bio}) async {
    return account!.updatePrefs(prefs: {'bio': bio});
  }

  Future<User?> getUserIfExists() async {
    try {
      final user = await this.account?.get();
      print(user?.email);
      return user;
    } on AppwriteException catch (e) {
      if (e.code != 401 || e.type != 'general_unauthorized_scope') rethrow;
    }
    return null;
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
