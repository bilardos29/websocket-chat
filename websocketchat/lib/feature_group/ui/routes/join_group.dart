import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:websocketchat/core/ui/ui.dart';
import 'package:shared/shared.dart';

import '../../context/group_context.dart';
import '../widgets/widgets.dart';

class JoinGroupRoute extends ConsumerStatefulWidget {
  const JoinGroupRoute({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinGroupRouteState();
}

class _JoinGroupRouteState extends ConsumerState<JoinGroupRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _roomId;

  void _checkRoom() {
    showDialog(
      context: context,
      builder: (context) => JoinRoomDialog(roomId: _roomId!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          centerTitle: true,
          title: const Text("List Room"),
          actions: const [SetUsernameButton()],
        ),
        body: ref.watch(getAllGroupStateProvider("")).when(
            success: (data, _) {
              List<GroupModel> list = data;
              debugPrint("sukses $list");
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    GroupModel item = list[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _roomId = item.groupId;
                        });
                        _checkRoom();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.blueAccent.shade100
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              'Room : ${item.groupName}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                                'Attendance : ${item.totalUser} ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2, color: Colors.white)),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    );
                  });
            },
            failed: (message, _, __) => Text(message),
            loading: (__, _) => const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Checking", textAlign: TextAlign.center),
                      SizedBox(width: 10),
                      CircularProgressIndicator()
                    ],
                  ),
                )));
  }
}
