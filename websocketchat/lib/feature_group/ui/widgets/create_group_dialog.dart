import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../context/context.dart';
import './widgets.dart';

class CreateGroupDialog extends ConsumerStatefulWidget {
  final int maxCount;
  const CreateGroupDialog({super.key, required this.maxCount});

  @override
  ConsumerState<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends ConsumerState<CreateGroupDialog> {
  GroupModel? _groupModel;
  void _setClipBoardData({required String data}) async {
    await Clipboard.setData(ClipboardData(text: data));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_groupModel?.groupId} copied to clipboard')));
  }

  void _onJoin() => context.push("/chats", extra: _groupModel);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      titleTextStyle: Theme.of(context).textTheme.headlineSmall,
      title: const Text("Creating chat room "),
      content: ref.watch(createGroupStateProvider(widget.maxCount)).when(
            success: (data, _) {
              _groupModel = data;
              return CreateGroupViewer(
                data: data,
                onCopy: () => _setClipBoardData(data: data.groupId),
              );
            },
            failed: (message, _, __) => Text(message),
            loading: (__, _) => Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Checking", textAlign: TextAlign.center),
                SizedBox(width: 10),
                CircularProgressIndicator()
              ],
            ),
          ),
      actions: [
        Builder(builder: (context) {
          final roomProvider = ref
              .watch(createGroupStateProvider(widget.maxCount).notifier)
              .joinRoomNotifier;
          return TextButton(
            onPressed: roomProvider.allowed ? _onJoin : null,
            child: Text(
              'Join Chat ',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          );
        })
      ],
    );
  }
}
