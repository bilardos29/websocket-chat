import 'package:shared/shared.dart';

abstract class GroupRepo {
  Stream<Resource<GroupModel>> createGroup(int max);
  Stream<Resource<CheckGroupModel>> checkGroup(String group);
  Stream<Resource<List<GroupModel>>> getAllGroup();
}
