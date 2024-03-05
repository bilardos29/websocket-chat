import 'package:shared/shared.dart';

abstract class ChatOperationRepo {
  Future<List<ChatModel>> getAllChats({required String group});

  Future<ChatModel> insertChat({required ChatModel chat});

  Future<void> deleteChat({required ChatModel chat});

  Stream<ChatModel> streamChats({required String group});
}
