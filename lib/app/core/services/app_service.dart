import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:get/get.dart';
import '../config/constants.dart' as constants;

class AppService extends GetxService {
  Client client = Client();

  Account? account;
  User? _user;

  AppService() {
    client
        .setEndpoint(constants.API_END_POINT)
        .setProject(constants.PROJECT_ID)
        .setSelfSigned(status: false);

    account = Account(client);
  }

  @override
  void onReady() {}

  signup(Map map) async {
    await account?.create(
      userId: map["userId"],
      email: map["email"],
      password: map["password"],
      name: map["name"],
    );

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

  Future<User?> getUser() async {
    // Future<String> getUser() async {
    // try {
    _user = await account?.get();

    return _user;

    // _status = AuthStatus.authenticated;
    // } on AppwriteException catch (e) {
    //   _status = AuthStatus.unauthenticated;
    //   _error = e.message;
    // } finally {
    //   _loading = false;
    //   if (notify) {
    //     notifyListeners();
    //   }
    // }
  }
}
