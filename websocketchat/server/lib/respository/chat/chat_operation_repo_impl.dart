import 'package:dotenv/dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/respository/repository.dart';
import 'package:shared/shared.dart';

class ChatOperationRepoImpl implements ChatOperationRepo {
  ChatOperationRepoImpl(this._dataBase);

  final Db _dataBase;

  DbCollection get _collection => _dataBase.collection(
        DotEnv().getOrElse('COLLECTION_NAME_CHATS', () => 'chat_me'),
      );

  @override
  Future<List<ChatModel>> getAllChats({required String group}) async {
    return (await _collection.find(where.eq('group', group)).toList())
        .map(
          (json) =>
              ChatDto.fromEntity(MongoChatEntity.fromJson(json)).toModel(),
        )
        .toList();
  }

  @override
  Future<ChatModel> insertChat({required ChatModel chat}) async {
    final result = await _collection.insertOne(
      NewChatDto.fromModel(chat).toJson(),
    );

    return ChatDto.fromEntity(MongoChatEntity.fromJson(result.document!))
        .toModel();
  }

  @override
  @Deprecated('Incomplete method cannot be used')
  Stream<ChatModel> streamChats({required String group}) async* {
    // yields the previous data from the stream
    yield* Stream.fromIterable(await getAllChats(group: group));
    //yields the current data from the stream

    //   final pipeLine = AggregationPipelineBuilder()
    //       .addStage(Match(where.eq('room', room).map[r'$query']))
    //       .build();

    //   final stream = _collection
    //       .watch(
    //         pipeLine,
    //         changeStreamOptions:
    //             ChangeStreamOptions(fullDocument: 'updateLookup'),
    //       )
    //       .cast<List<Map<String, dynamic>>>()
    //       .asyncMap((event) => null);

    //   stream.listen((event) {
    //     print(event);
    //   });
  }

  @override
  Future<void> deleteChat({required ChatModel chat}) async => chat.id != null
      ? _collection.deleteOne(
          where.eq('_id', ObjectId.fromHexString(chat.id!)),
        )
      : null;
}
