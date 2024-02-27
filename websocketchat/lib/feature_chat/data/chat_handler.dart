import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:websocketchat/main.dart';
import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/local_data_repo.dart';
import '../../utils.dart';

class ChatHandler {
  final RoomModel room;
  final LocalDataRepo _localData;

  static final _endpoint = 'ws://192.168.23.202:8080/ws';
      //dotenv.get('WEBSOCKET_HOST', fallback: 'ws://192.168.23.202:8181/ws');

  ChatHandler(this._localData, {required this.room});

  late final WebSocketChannel _channel;

  Future<WebSocketChannel> init() async {
    String username = await _localData.getUsername() ?? 'anonymous';
    final uri = Uri.parse('$_endpoint/${room.roomId}?username=$username');
    print('test print uri $uri');
    _channel = WebSocketChannel.connect(uri);
    print('check result ${_channel}');
    return _channel;
  }

  Future<void> close() async => _channel.sink.close();
}
