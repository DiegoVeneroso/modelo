import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import '../config/constants.dart' as constants;

class AppService extends GetxService {
  Client client = Client();

  Account? account;

  @override
  void onReady() {}

  signup(Map map) async {
    client
        .setEndpoint(constants.API_END_POINT)
        .setProject(constants.PROJECT_ID)
        .setSelfSigned(status: false);

    account = Account(client);

    await account?.create(
      userId: map["userId"],
      email: map["email"],
      password: map["password"],
      name: map["name"],
    );
  }

  sign(Map map) async {
    client
        .setEndpoint(constants.API_END_POINT)
        .setProject(constants.PROJECT_ID)
        .setSelfSigned(status: false);

    account = Account(client);

    await account?.createEmailSession(
      email: map["email"],
      password: map["password"],
    );
  }
}
