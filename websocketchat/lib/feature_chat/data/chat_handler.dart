import 'package:shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/local_data_repo.dart';

class ChatHandler {
  final GroupModel group;
  final LocalDataRepo _localData;

  static final _endpoint = 'ws://192.168.23.202:8080/ws';

  ChatHandler(this._localData, {required this.group});

  late final WebSocketChannel _channel;

  Future<WebSocketChannel> init() async {
    String username = await _localData.getUsername() ?? 'anonymous';
    final uri = Uri.parse('$_endpoint/${group.groupId}?username=$username');
    _channel = WebSocketChannel.connect(uri);
    return _channel;
  }

  Future<void> close() async => _channel.sink.close();
}
