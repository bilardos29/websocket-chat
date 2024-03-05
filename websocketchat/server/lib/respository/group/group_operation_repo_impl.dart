import 'package:dotenv/dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/respository/group/group_operations_repo.dart';
import 'package:shared/shared.dart';

class GroupOperationRepoImpl implements GroupOperations {
  GroupOperationRepoImpl(this._dataBase);

  final Db _dataBase;

  DbCollection get _collection => _dataBase.collection(
        DotEnv().getOrElse('COLLECTION_NAME_ROOM', () => 'group'),
      );

  Future<List<String>> _getGroupId() async => _collection
      .find()
      .asyncMap(
        (event) =>
            GroupDto.fromEntity(MongoGroupEntity.fromJson(event)).groupId,
      )
      .toList();

  @override
  Future<CheckGroupModel> checkGroup({required String group}) async {
    final result = await _collection.findOne(where.eq('groupId', group));
    if (result == null) return CheckGroupModel(state: GroupState.undefined);
    final model =
        GroupDto.fromEntity(MongoGroupEntity.fromJson(result)).toModel();
    return CheckGroupModel(state: GroupState.joinable, room: model);
  }

  @override
  Future<GroupModel> createGroup(
      {required String name,
      required int totalUser,
      required int isGroup}) async {
    final groupId = createGroupId(await _getGroupId());

    final result = await _collection.insertOne(
      CreateGroupDto(
              groupId: groupId,
              groupName: name,
              totalUser: totalUser,
              isGroup: isGroup)
          .toJson(),
    );

    return GroupDto.fromEntity(MongoGroupEntity.fromJson(result.document!))
        .toModel();
  }

  @override
  Future<List<GroupModel>> getAllGroup() async {
    final result = await _collection.find().toList();
    final list = result
        .map((data) =>
            GroupDto.fromEntity(MongoGroupEntity.fromJson(data)).toModel())
        .toList();

    return list;
  }

  @override
  Future<void> updateGroup(
          {required String groupId, required int totalUser}) async =>
      _collection.updateOne(
          where.eq('groupId', groupId), modify.set('totalUser', totalUser));
}
