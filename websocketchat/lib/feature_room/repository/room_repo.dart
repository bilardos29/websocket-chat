import 'package:shared/shared.dart';

abstract class RoomRepo {
  Stream<Resource<RoomModel>> createRoom(int max);
  Stream<Resource<CheckRoomModel>> checkRoom(String room);
  Stream<Resource<List<RoomModel>>> getAllRoom();
}
