import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:server/respository/repository.dart';

import 'package:shared/shared.dart';
import '../../main.dart';

/// This hold the list of [WebSocketChannel]
/// Though this is just a `in-memory mapping` [Map] hoding th [String] group with
/// the [List] of [WebSocketChannel]s
/// The similar thing can be applied with pubsub feature of the redis server
/// for a long running and traffic based application
final Map<String, List<WebSocketChannel>> _channelsGroup = {};

Future<Response> onRequest(RequestContext context, String group) async {
  logger.shout(_channelsGroup);
  //room validation
  final groupRepo = context.read<GroupOperations>();
  final groupValidation = await groupRepo.checkGroup(group: group);

  final query = context.request.uri.queryParameters;
  final chatRepo = context.read<ChatOperationRepo>();

  final handler = webSocketHandler(
    (channel, protocol) async {
      // Room State validation
      if (groupValidation.state != GroupState.joinable) {
        await channel.sink.close(
          WsCloseCodes.mandatoryExtensionNotFound.closeCode,
          'Group is not joinable',
        );
        return;
      }
      // QueryParms validation
      if (!query.containsKey('username')) {
        await channel.sink.close(
          WsCloseCodes.mandatoryExtensionNotFound.closeCode,
          'username not found',
        );
        return;
      }
      final username = query['username']!;

      // Updating the `_channelsRoom` as per the join sequence
      if (_channelsGroup.containsKey(group)) {
        _channelsGroup.update(group, (value) => value..add(channel));
      } else {
        _channelsGroup.putIfAbsent(group, () => [channel]);
      }
      if (_channelsGroup[group]?.length != null) {
        await groupRepo.updateGroup(
          groupId: group,
          totalUser: _channelsGroup[group]!.length,
        );
      }
      //send all the previous chats stored in mongodb database
      await channel.sink.addStream(
        chatRepo.streamChats(group: group).asyncMap(
              (chat) => WsBaseMessages.message(
                chat,
                owner: chat.username == username
                    ? ChatOwner.self
                    : ChatOwner.other,
              ),
            ),
      );

      //welcome message to the stream
      _channelsGroup[group]?.forEach(
        (others) => others.sink.add(WsBaseMessages.joined(username)),
      );

      channel.stream.listen(
        (event) async {
          // Get all the associated sockets [WebSocketChannel] present
          // with the same group then channelize through all the sockets
          // not brodcasting it (sending to all sockets except the channel )
          final sockets = _channelsGroup[group];

          try {
            final message = WsBaseMessages.parseMessage(event as String);
            final savedModel = await chatRepo.insertChat(chat: message.model!);

            // print(savedModel);

            sockets?.forEach(
              (socket) => socket.sink.add(
                WsBaseMessages.message(
                  savedModel,
                  owner: channel == socket ? ChatOwner.self : ChatOwner.other,
                ),
              ),
            );
          } on FormatException {
            logger.info('format exception');
            await channel.sink.close(
              WsCloseCodes.closeUnsupportedPayLoad.closeCode,
              WsCloseCodes.closeUnsupportedPayLoad.name,
            );
          } catch (e) {
            logger.shout(e);
            await channel.sink.close(
              WsCloseCodes.closeProtocolError.closeCode,
              WsCloseCodes.closeProtocolError.name,
            );
          }
        },
        onDone: () async {
          logger.fine('closed the stream');
          _channelsGroup.update(group, (value) => value..remove(channel));

          _channelsGroup[group]?.forEach(
            (others) => others.sink.add(
              WsBaseMessages.dissconnected(
                username,
                reason: channel.closeReason,
              ),
            ),
          );
          await groupRepo.updateGroup(
            groupId: group,
            totalUser: _channelsGroup[group]?.length ?? 0,
          );
        },
        onError: (_) async {
          logger.shout('some error occured !!');
          _channelsGroup.update(group, (value) => value..remove(channel));
          _channelsGroup[group]?.forEach(
            (others) => others.sink.add(
              WsBaseMessages.dissconnected(
                username,
                reason: channel.closeReason,
              ),
            ),
          );
          await groupRepo.updateGroup(
            groupId: group,
            totalUser: _channelsGroup[group]?.length ?? 0,
          );
        },
        cancelOnError: true,
      );
    },
  );
  return handler(context);
}
