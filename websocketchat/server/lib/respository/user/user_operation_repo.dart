import 'package:shared/shared.dart';

abstract class UserOperations {
  Future<UserModel> addUser({required UserModel user});

  Future<CheckUserModel> checkUser({required String userId});

  Future<List<UserModel>> getAllUser();

  Future<void> updateUser({required UserModel user});
}
