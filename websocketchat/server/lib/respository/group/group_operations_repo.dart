import 'package:shared/shared.dart';

abstract class GroupOperations {
  Future<GroupModel> createGroup({required String name, required int totalUser, required int isGroup});

  Future<CheckGroupModel> checkGroup({required String group});

  Future<List<GroupModel>> getAllGroup();

  Future<void> updateGroup({required String groupId,
    required int totalUser});
}
