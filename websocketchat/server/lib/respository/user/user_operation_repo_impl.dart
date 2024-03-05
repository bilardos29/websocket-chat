import 'package:dotenv/dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared/shared.dart';

import 'user_operation_repo.dart';

class UserOperationRepoImpl implements UserOperations {
  UserOperationRepoImpl(this._dataBase);

  final Db _dataBase;

  DbCollection get _collection => _dataBase.collection(
        DotEnv().getOrElse('COLLECTION_NAME_USER', () => 'user'),
      );

  @override
  Future<UserModel> addUser({required UserModel user}) async {
    final result =
        await _collection.insertOne(UserDto.fromModel(user).toJson());

    return UserDto.fromEntity(MongoUserEntity.fromJson(result.document!))
        .toModel();
  }

  @override
  Future<CheckUserModel> checkUser({required String userId}) async {
    final result = await _collection.findOne(where.eq('_id', ObjectId.fromHexString(userId)));
    if (result == null) return CheckUserModel(state: UserState.undefined);

    final model =
        UserDto.fromEntity(MongoUserEntity.fromJson(result)).toModel();
    return CheckUserModel(state: UserState.exist, user: model);
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    final result = await _collection.find().toList();
    final list = result
        .map((data) =>
            UserDto.fromEntity(MongoUserEntity.fromJson(data)).toModel())
        .toList();

    return list;
  }

  @override
  Future<void> updateUser({required UserModel user}) async =>
      _collection.updateOne(
          where.eq('_id', ObjectId.fromHexString(user.id!)), modify.set('fullname', user.fullname));
}
