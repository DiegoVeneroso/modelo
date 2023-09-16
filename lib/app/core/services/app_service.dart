import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../config/constants.dart' as constants;

class AppService extends GetxService {
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
    var id = ID.unique();
    try {
      await account?.create(
        userId: map["userId"],
        email: map["email"],
        password: map["password"],
        name: map["name"],
      );
      var session = await account?.createEmailSession(
        email: map["email"],
        password: map["password"],
      );

      var userID = session?.$id;

      print('userID');
      print(userID);

      await databases?.createDocument(
        databaseId: 'db_auth',
        collectionId: 'cl_auth',
        documentId: id,
        data: {
          'userID': id,
          'name': map["name"],
          'email': map["email"],
          'phone': map["phone"],
          'admin': map["admin"] != '' ? true : false,
          'avatar': map["avatar"],
        },
        // permissions: [
        //   Permission.write(Role.user(userID.toString())),
        //   Permission.read(Role.user(userID.toString())),
        // ],
      );

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: map["email"],
        password: map["password"],
      );
    } on FirebaseAuthException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
    } on AppwriteException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
    } catch (e) {
      log(e.toString());
    }

    // await account?.updatePrefs(prefs: {
    //   "admin": map["admin"],
    //   "phone": map["phone"],
    // });
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

  // Future<User?> getUser() async {
  //   // Future<String> getUser() async {
  //   // try {
  //   _user = await account?.get();

  //   return _user;

  //   // _status = AuthStatus.authenticated;
  //   // } on AppwriteException catch (e) {
  //   //   _status = AuthStatus.unauthenticated;
  //   //   _error = e.message;
  //   // } finally {
  //   //   _loading = false;
  //   //   if (notify) {
  //   //     notifyListeners();
  //   //   }
  //   // }
  // }
}
