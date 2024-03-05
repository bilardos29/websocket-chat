import 'package:dart_frog/dart_frog.dart';
import 'package:server/middleware/db_middleware.dart';
import 'package:server/middleware/group_middleware.dart';
import 'package:server/middleware/user_middleware.dart';

Handler middleware(Handler handler) =>
    handler.use(chatProvider()).use(groupMiddleWare()).use(userMiddleWare()).use(requestLogger());
