// import 'dart:developer';

// import 'package:appwrite/appwrite.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import '../config/constants.dart' as constants;

// class AppService extends GetxService {
//   Client client = Client();
//   Databases? databases;

//   Account? account;
//   // User? _user;

//   AppService() {
//     client
//         .setEndpoint(constants.API_END_POINT)
//         .setProject(constants.PROJECT_ID)
//         .setSelfSigned(status: false);

//     account = Account(client);
//     databases = Databases(client);
//   }

//   @override
//   void onReady() {}

//   signup(Map map) async {
//     try {
//       var user = await account?.create(
//         userId: ID.unique(),
//         email: map["email"],
//         password: map["password"],
//         name: map["name"],
//       );

//       return user.toString();

//       // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//       // var token = await firebaseMessaging.getToken();

//       // databases?.createDocument(
//       //   databaseId: 'db_auth',
//       //   collectionId: 'cl_auth',
//       //   documentId: ID.unique(),
//       //   data: {
//       //     'userID': user?.$id,
//       //     'name': map["name"],
//       //     'email': map["email"],
//       //     'phone': map["phone"],
//       //     'admin': map["admin"] == false ? false : true,
//       //     'url_avatar': map["url_avatar"],
//       //     'tokenPush': token,
//       //   },

//       // await account?.createEmailSession(
//       //   email: map["email"],
//       //   password: map["password"],
//       // );

//       // var sessionID = session?.$id;

//       // print('sessionID');
//       // print(sessionID);
//       // print('idUser');
//       // print(idUser);
//     } on FirebaseAuthException catch (e, s) {
//       log('Erro ao pegar o token push', error: e, stackTrace: s);
//       return e.toString();
//     } on AppwriteException catch (e, s) {
//       log('Erro ao realizar login appwrite', error: e, stackTrace: s);
//       return e.toString();
//     } catch (e) {
//       log(e.toString());
//       return e.toString();
//     }
//   }

//   sign(Map map) async {
//     await account?.createEmailSession(
//       email: map["email"],
//       password: map["password"],
//     );
//   }

//   logout() async {
//     await account?.deleteSessions();
//   }

//   // getUser() async {
//   //   // Future<String?> getUser() async {
//   //   // try {
//   //   var user_logged = await account?.get();

//   //   return user_logged;

//   //   // _status = AuthStatus.authenticated;
//   //   // } on AppwriteException catch (e) {
//   //   //   _status = AuthStatus.unauthenticated;
//   //   //   _error = e.message;
//   //   // } finally {
//   //   //   _loading = false;
//   //   //   if (notify) {
//   //   //     notifyListeners();
//   //   //   }
//   //   // }
// }
