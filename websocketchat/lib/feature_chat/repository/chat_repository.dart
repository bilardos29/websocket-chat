import 'package:shared/shared.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String message, GroupModel group);
  Stream<List<ChatMessageInfoModel>> recieveChat();
  Stream<List<ChatMessageInfoModel>> recievePreviousChats();
}
