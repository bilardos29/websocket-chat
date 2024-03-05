import 'package:dart_frog/dart_frog.dart';
import 'package:server/middleware/db_middleware.dart';
import 'package:server/respository/repository.dart';

Middleware groupMiddleWare() {
  return provider<GroupOperations>(
    (context) => GroupOperationRepoImpl(database.db),
  );
}
