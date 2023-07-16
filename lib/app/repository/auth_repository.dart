import 'package:appwrite/models.dart';
import 'package:mots/app/core/services/app_service.dart';

class AuthRepository {
  final AppService appService;
  AuthRepository(this.appService);

  Future<User?> signup(Map map) async {
    return await appService.signup(map);
  }

  Future<User?> sign(Map map) async {
    return await appService.sign(map);
  }
}
