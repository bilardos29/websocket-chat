import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import 'feature_chat/chats.dart';
import 'feature_group/group.dart';

import 'feature_group/ui/routes/group_routes.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Rooms(),
    ),
    GoRoute(
      path: '/join-room',
      builder: (context, state) => const JoinGroupRoute(),
    ),
    GoRoute(
        path: '/create-room',
        builder: (context, state) => const CreateGroupRoute()),
    GoRoute(
      path: '/chats',
      builder: (context, state) => Chats(group: state.extra as GroupModel),
    ),
  ],
);
