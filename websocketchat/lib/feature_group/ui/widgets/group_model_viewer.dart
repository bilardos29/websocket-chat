import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class GroupModelViewer extends StatelessWidget {
  final CheckGroupModel groupModel;
  const GroupModelViewer({super.key, required this.groupModel});

  String get typeToString {
    switch (groupModel.state) {
      case GroupState.full:
        return "ROOM FULL";
      case GroupState.joinable:
        return "ROOM JOINABLE";
      case GroupState.undefined:
        return "ROOM NOT FOUND";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          typeToString,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        if (groupModel.state == GroupState.undefined) ...[
          const SizedBox(height: 2),
          Text(
            'Room dont exists create a new one ',
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
        const SizedBox(height: 10),
        if (groupModel.room != null)
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Joined: ${groupModel.room!.totalUser}"),
                  Text("Maximum: ${groupModel.room!.totalUser}")
                ],
              ),
            ),
          )
      ],
    );
  }
}
