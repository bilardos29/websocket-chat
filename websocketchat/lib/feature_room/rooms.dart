import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/ui/ui.dart';

class Rooms extends StatefulWidget {
  const Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text('Realtime Chat App'),
        centerTitle: true,
        actions: const [SetUsernameButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary,
                    offset: const Offset(10, 10),
                    blurRadius: 20,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Image.asset(
                "assets/images/ic_chat.png",
                scale: 1,
                width: 100,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Create or join a room to chat ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(size.width, 50)),
              onPressed: () => context.push('/create-room'),
              child: const Text("Create Room", style: TextStyle(color: Colors.white),),

            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent.shade100,
                  fixedSize: Size(size.width, 50)),
              onPressed: () => context.push('/join-room'),
              child: const Text("Join a room", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
