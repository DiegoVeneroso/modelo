import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import 'package:auth_modelo/app/core/config/api_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepository {
  User? _current;
  User? get current => _current;

  Session? _session;
  Session? get session => _session;

  register(Map map) async {
    try {
      final result = await ApiClient.account.create(
        userId: ID.unique(),
        email: map["email"],
        password: map["password"],
        name: map["name"],
      );
      _current = result;

      var id = result.$id;

      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      var token = await firebaseMessaging.getToken();

      await ApiClient.databases.createDocument(
          databaseId: 'db_auth',
          collectionId: 'cl_auth',
          documentId: ID.unique(),
          data: {
            'userID': id,
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
      final session = await ApiClient.account.createEmailSession(
        email: map["email"],
        password: map["password"],
      );
      _session = session;

      User user = await ApiClient.account.get();
      return user;
    } on AppwriteException catch (e) {
      _session = null;
      log(e.response['type']);

      throw (e.response['type']);
    }
  }

  logout() async {
    try {
      await ApiClient.account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e) {
      print('erro no repo');
      throw (e);
    }
  }

  recoveryPassword(String email) async {
    try {
      await ApiClient.account.createRecovery(
        email: email,
        url: 'http://frontapp.com.br:8080',
      );
      print('email de recuperação de senha enviado!');
    } on AppwriteException catch (e) {
      print('erro no envio do email de recuperação de senha');
      throw (e.type.toString());
    }
  }

  Future<User?> getUserIfExists() async {
    try {
      final user = await ApiClient.account.get();
      print(user.email);
      return user;
    } on AppwriteException catch (e) {
      throw (e);
    }
  }
}
